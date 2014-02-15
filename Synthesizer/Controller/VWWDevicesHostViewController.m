//
//  VWWDevicesHostViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/14/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWDevicesHostViewController.h"

@interface VWWDevicesHostViewController () <AsyncSocketDelegate, NSNetServiceDelegate>
@property (strong, nonatomic) NSNetService *service;
@property (strong, nonatomic) AsyncSocket *socket;

@end

@implementation VWWDevicesHostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startBroadcast];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Private methods

- (void)startBroadcast {
    // Initialize GCDAsyncSocket
    self.socket = [[AsyncSocket alloc] initWithDelegate:self];
    //    self.socket = [[AsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    // Start Listening for Incoming Connections
    NSError *error = nil;
    if ([self.socket acceptOnPort:0 error:&error]) {
        // Initialize Service
        self.service = [[NSNetService alloc] initWithDomain:@"local." type:@"_vww_theremin._tcp." name:@"" port:[self.socket localPort]];
        
        // Configure Service
        [self.service setDelegate:self];
        
        // Publish Service
        [self.service publish];
        

        
    } else {
        VWW_LOG_INFO(@"Unable to create socket. Error %@ with user info %@.", error, [error userInfo]);
    }
}





#pragma mark AsyncSocketDelegate
- (void)onSocket:(AsyncSocket *)socket didAcceptNewSocket:(AsyncSocket *)newSocket {
    VWW_LOG_INFO(@"Accepted New Socket from %@:%hu", [newSocket connectedHost], [newSocket connectedPort]);
    
    // Socket
    [self setSocket:newSocket];
//    self.socket = socket;
    self.socket.delegate = self;
    
    // Read Data from Socket
    [self.socket readDataToLength:sizeof(uint64_t) withTimeout:-1.0 tag:0];
}


- (void)onSocketDidDisconnect:(AsyncSocket *)socket withError:(NSError *)error {
    VWW_LOG_INFO(@"%s", __PRETTY_FUNCTION__);
    
    if (self.socket == socket) {
        [self.socket setDelegate:nil];
        [self setSocket:nil];
    }
}

- (void)onSocket:(AsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
    VWW_LOG_INFO(@"Partial data read");
}
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    NSString *payload = [NSString stringWithUTF8String:[data bytes]];
    VWW_LOG_INFO(@"Received payload: %@", payload);
    
    [[[UIAlertView alloc]initWithTitle:@"Rx" message:payload delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    if (tag == 1)
    {
        
    }
    
    [self.socket readDataToLength:sizeof(uint64_t) withTimeout:-1.0 tag:0];
}


#pragma mark NSNetServiceDelegate
- (void)netServiceDidPublish:(NSNetService *)service {
    VWW_LOG_INFO(@"Bonjour Service Published: domain(%@) type(%@) name(%@) port(%i)", [service domain], [service type], [service name], (int)[service port]);
}

- (void)netService:(NSNetService *)service didNotPublish:(NSDictionary *)errorDict {
    VWW_LOG_INFO(@"Failed to Publish Service: domain(%@) type(%@) name(%@) - %@", [service domain], [service type], [service name], errorDict);
}


@end
