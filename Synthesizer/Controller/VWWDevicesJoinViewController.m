//
//  VWWDevicesJoinViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/14/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWDevicesJoinViewController.h"
#import "MBProgressHUD.h"

@interface VWWDevicesJoinViewController () <NSNetServiceDelegate, NSNetServiceBrowserDelegate, AsyncSocketDelegate>
@property (strong, nonatomic) AsyncSocket *socket;
@property (strong, nonatomic) NSMutableArray *services;
@property (strong, nonatomic) NSNetServiceBrowser *serviceBrowser;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation VWWDevicesJoinViewController

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
    
    
    // Start Browsing
    [self startBrowsing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark IBActions
- (IBAction)testButtonTouchUpInside:(id)sender {
    [self sendString:@"Testing"];
}


#pragma mark Private methods


-(void)sendString:(NSString*)payload{
    
    VWW_LOG_INFO(@"isConnected: %@", self.socket.isConnected ? @"YES" : @"NO");
    VWW_LOG_INFO(@"connectedAddress: %@", self.socket.connectedAddress);
    VWW_LOG_INFO(@"connectedHost: %@", self.socket.connectedHost);
    VWW_LOG_INFO(@"connectedPort: %ld", (long)self.socket.connectedPort);
    
    NSString *terminatedPayload = [NSString stringWithFormat:@"%@\r\n", payload];
    NSData* data = [terminatedPayload dataUsingEncoding:NSUTF8StringEncoding];
    self.socket.delegate = self;
    [self.socket writeData:data withTimeout:50 tag:1];
    
    VWW_LOG_INFO(@"Message sent: %@", data.description);
}



- (void)cancel:(id)sender {
    VWW_LOG_INFO(@"Cancelling browse");
    // Stop Browsing Services
    [self stopBrowsing];
    
    // Dismiss View Controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)startBrowsing {
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





- (BOOL)connectWithService:(NSNetService *)service {
    BOOL _isConnected = NO;
    
    // Copy Service Addresses
    NSArray *addresses = [[service addresses] mutableCopy];
    
    if (!self.socket || ![self.socket isConnected]) {
        // Initialize Socket
        self.socket = [[AsyncSocket alloc] initWithDelegate:self];
        
        VWW_LOG_INFO(@"Attempting to establish connection to %@...", addresses[0]);
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



- (void)stopBrowsing {
    if (self.serviceBrowser) {
        [self.serviceBrowser stop];
        [self.serviceBrowser setDelegate:nil];
        [self setServiceBrowser:nil];
    }
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.services ? 1 : 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.services count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // Fetch Service
    NSNetService *service = [self.services objectAtIndex:[indexPath row]];
    
    // Configure Cell
    [cell.textLabel setText:[service name]];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    self.hud.dimBackground = YES;
//    self.hud.labelText = @"Connecting...";
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Fetch Service
    NSNetService *service = [self.services objectAtIndex:indexPath.row];
    
    // Resolve Service
    [service setDelegate:self];
    [service resolveWithTimeout:30.0];
    
    VWW_LOG_INFO(@"Connecting to %@", self.services[indexPath.row]);
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
    if ([self connectWithService:service]) {
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
        
        // Update Table View
        [self.tableView reloadData];
    }
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)serviceBrowser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing {
    // Update Services
    [self.services removeObject:service];
    
    if(!moreComing) {
        // Update Table View
        [self.tableView reloadData];
    }
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)serviceBrowser {
    [self stopBrowsing];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didNotSearch:(NSDictionary *)userInfo {
    [self stopBrowsing];
}



@end
