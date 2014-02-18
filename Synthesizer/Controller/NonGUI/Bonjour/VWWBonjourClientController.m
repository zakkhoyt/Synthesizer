//
//  VWWBonjourClientController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/17/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWBonjourClientController.h"
#import "VWWBonjourDefines.h"
#import "AsyncSocket.h"


@interface VWWBonjourClientController () <NSNetServiceDelegate, NSNetServiceBrowserDelegate, AsyncSocketDelegate>
@property (strong, nonatomic) AsyncSocket *socket;
@property (strong, nonatomic, readwrite) NSMutableArray *services;
@property (strong, nonatomic) NSNetServiceBrowser *serviceBrowser;

@end

@implementation VWWBonjourClientController

+(VWWBonjourClientController*)sharedInstance{
    static VWWBonjourClientController *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(void)startBrowsing{
    VWW_LOG_INFO(@"Browsing for network services");
    if (self.services) {
        [self.services removeAllObjects];
    } else {
        self.services = [[NSMutableArray alloc] init];
    }
    
    // Initialize Service Browser
    self.serviceBrowser = [[NSNetServiceBrowser alloc] init];
    
    // Configure Service Browser
    [self.serviceBrowser setDelegate:self];
    [self.serviceBrowser searchForServicesOfType:@"_vww_theremin._tcp." inDomain:@"local."];
}

-(void)stopBrowsing{
    if (self.serviceBrowser) {
        [self.serviceBrowser stop];
        [self.serviceBrowser setDelegate:nil];
        [self setServiceBrowser:nil];
    }
}



-(void)sendCommand:(NSString*)command{
    VWW_LOG_INFO(@"isConnected: %@", self.socket.isConnected ? @"YES" : @"NO");
    VWW_LOG_INFO(@"connectedAddress: %@", self.socket.connectedAddress);
    VWW_LOG_INFO(@"connectedHost: %@", self.socket.connectedHost);
    VWW_LOG_INFO(@"connectedPort: %ld", (long)self.socket.connectedPort);
    
    NSString *terminatedPayload = [NSString stringWithFormat:@"%@\r\n", command];
    NSData* data = [terminatedPayload dataUsingEncoding:NSUTF8StringEncoding];
    self.socket.delegate = self;
    [self.socket writeData:data withTimeout:50 tag:1];
    
    VWW_LOG_INFO(@"Message sent: %@", data.description);
}

-(void)connectToServiceAtIndex:(NSInteger)index{
    NSNetService *service = self.services[index];
    [self connectToService:service];
}



#pragma mark Private methods



- (void)cancel:(id)sender {
    VWW_LOG_INFO(@"Cancelling browse");
    // Stop Browsing Services
    [self stopBrowsing];
    
//    // Dismiss View Controller
//    [self dismissViewControllerAnimated:YES completion:nil];
}





-(BOOL)connectToService:(NSNetService*)service{
    BOOL _isConnected = NO;
    
    
    [service setDelegate:self];
    [service resolveWithTimeout:30.0];
    
    // Copy Service Addresses
    NSArray *addresses = [[service addresses] mutableCopy];
    
    if (!self.socket || ![self.socket isConnected]) {
        // Initialize Socket
        self.socket = [[AsyncSocket alloc] initWithDelegate:self];
        
        //VWW_LOG_INFO(@"Attempting to establish connection to %@...", addresses[0]);
        // Connect
        while (!_isConnected && [addresses count]) {
            NSData *address = [addresses objectAtIndex:0];
            
            NSError *error = nil;
            if ([self.socket connectToAddress:address error:&error]) {
                _isConnected = YES;
                VWW_LOG_INFO(@"Successfully connected");
            } else if (error) {
                VWW_LOG_INFO(@"Unable to connect to address. Error %@ with user info %@.", error, [error userInfo]);
            }
        }
        
    } else {
        _isConnected = [self.socket isConnected];
        VWW_LOG_INFO(@"Successfully connected");
    }
    
    return _isConnected;
}







#pragma mark AsyncSocketDelegate

- (void)onSocket:(AsyncSocket *)socket didConnectToHost:(NSString *)host port:(UInt16)port {
    VWW_LOG_INFO(@"Socket Did Connect to Host: %@ Port: %hu", host, port);
    
    // Start Reading
    [socket readDataToLength:sizeof(uint64_t) withTimeout:-1.0 tag:0];
    
    
    //    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)onSocketDidDisconnect:(AsyncSocket *)socket withError:(NSError *)error {
    VWW_LOG_INFO(@"Socket Did Disconnect with Error %@ with User Info %@.", error, [error userInfo]);
    
    [socket setDelegate:nil];
    [self setSocket:nil];
    
    //    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    VWW_LOG_INFO(@"Payload sent");
    //    [self.socket readDataToLength:sizeof(uint64_t) withTimeout:-1.0 tag:0];
}


- (void)onSocket:(AsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
    VWW_LOG_INFO(@"Payload partially sent");
}
#pragma mark NSNetServiceDelegate

- (void)netService:(NSNetService *)service didNotResolve:(NSDictionary *)errorDict {
    VWW_LOG_INFO(@"Did not resolve.");
    [service setDelegate:nil];
    //    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)netServiceDidResolveAddress:(NSNetService *)service {
    // Connect With Service
    if ([self connectToService:service]) {
        VWW_LOG_INFO(@"Did Connect with Service: domain(%@) type(%@) name(%@) port(%i)", [service domain], [service type], [service name], (int)[service port]);
    } else {
        VWW_LOG_INFO(@"Unable to Connect with Service: domain(%@) type(%@) name(%@) port(%i)", [service domain], [service type], [service name], (int)[service port]);
    }
}

#pragma mark NSNetServiceBrowserDelegate

- (void)netServiceBrowser:(NSNetServiceBrowser *)serviceBrowser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing {
    // Update Services
    [self.services addObject:service];
    
    if(!moreComing) {
        // Sort Services
        [self.services sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        
//        // Update Table View
//        [self.tableView reloadData];
        [self.delegate bonjourClientController:self didDiscoverServices:self.services];
    }
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)serviceBrowser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing {
    // Update Services
    [self.services removeObject:service];
    
    if(!moreComing) {
//        // Update Table View
//        [self.tableView reloadData];
        [self.delegate bonjourClientController:self didDiscoverServices:self.services];
    }
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser*)serviceBrowser {
    [self stopBrowsing];
    NSError *error = [NSError errorWithDomain:VWWBonjourDefinesDomain code:-101 userInfo:@{@"todo" : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]}];
    [self.delegate bonjourClientController:self didStopBrowsingWithError:error];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didNotSearch:(NSDictionary *)userInfo {
    [self stopBrowsing];
    NSError *error = [NSError errorWithDomain:VWWBonjourDefinesDomain code:-102 userInfo:@{@"todo" : [NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]}];
    [self.delegate bonjourClientController:self didStopBrowsingWithError:error];
}



@end
