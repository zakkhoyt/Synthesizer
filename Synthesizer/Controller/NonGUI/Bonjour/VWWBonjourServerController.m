//
//  VWWBonjourServerController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/14/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWBonjourServerController.h"
#import "VWWBonjourDefines.h"
#import "AsyncSocket.h"

@interface VWWBonjourServerController () <AsyncSocketDelegate, NSNetServiceDelegate>
@property (strong, nonatomic) NSNetService *service;
@property (strong, nonatomic) AsyncSocket *socket;
@end

@implementation VWWBonjourServerController


#pragma mark Public methods



+(VWWBonjourServerController*)sharedInstance{
    static VWWBonjourServerController *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
//        [self startBroadcast];
    }
    return self;
}






#pragma mark Private methods

- (void)startBroadcast {
    self.socket = [[AsyncSocket alloc] initWithDelegate:self];
    
    // Start Listening for Incoming Connections
    NSError *error = nil;
    if ([self.socket acceptOnPort:0 error:&error]) {
        self.service = [[NSNetService alloc] initWithDomain:VWWBonjourDefinesDomain type:VWWBonjourDefinesType name:@"" port:[self.socket localPort]];
        [self.service setDelegate:self];
        [self.service publish];
        
        
        [self.delegate bonjourControllerDidStartBroadcasting:self];
    } else {
        VWW_LOG_INFO(@"Unable to create socket. Error %@ with user info %@.", error, [error userInfo]);
    }
}




#pragma mark AsyncSocketDelegate
- (void)onSocket:(AsyncSocket *)socket didAcceptNewSocket:(AsyncSocket *)newSocket {
    VWW_LOG_INFO(@"Accepted New Socket from %@:%hu", [newSocket connectedHost], [newSocket connectedPort]);
    
    // Socket
    [self setSocket:newSocket];
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

//- (void)onSocket:(AsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{
//    VWW_LOG_INFO(@"Partial data read");
//}
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    NSString *payload = [NSString stringWithUTF8String:[data bytes]];
    VWW_LOG_INFO(@"Received payload: %@", payload);
    
//    [[[UIAlertView alloc]initWithTitle:@"Rx" message:payload delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
//    if (tag == 1)
//    {
//        
//    }
    
    [self.socket readDataToLength:sizeof(uint64_t) withTimeout:-1.0 tag:0];
    
    [self.delegate bonjourController:self didRecieveCommand:payload];
}


#pragma mark NSNetServiceDelegate
- (void)netServiceDidPublish:(NSNetService *)service {
    VWW_LOG_INFO(@"Bonjour Service Published: domain(%@) type(%@) name(%@) port(%i)", [service domain], [service type], [service name], (int)[service port]);
    [self.delegate bonjourController:self didPublishService:service];
}

- (void)netService:(NSNetService *)service didNotPublish:(NSDictionary *)errorDict {
    VWW_LOG_INFO(@"Failed to Publish Service: domain(%@) type(%@) name(%@) - %@", [service domain], [service type], [service name], errorDict);
    NSError *error = [NSError errorWithDomain:service.domain code:-100 userInfo:errorDict];
    [self.delegate bonjourController:self service:service errorOccurred:error];
}




@end
