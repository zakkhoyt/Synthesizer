//
//  VWWDevicesClientViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/14/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWDevicesClientViewController.h"
#import "VWWBonjourClientController.h"

@interface VWWDevicesClientViewController () <VWWBonjourClientControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VWWBonjourClientController *clientController;
@end

@implementation VWWDevicesClientViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clientController = [VWWBonjourClientController sharedInstance];
    self.clientController.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.clientController startBrowsing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark IBActions
- (IBAction)testButtonTouchUpInside:(id)sender {
//    [self sendString:@"Testing"];
    [self.clientController sendCommand:@"command string"];
}




#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.clientController.services.count ? 1 : 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.clientController.services count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // Fetch Service
    NSNetService *service = [self.clientController.services objectAtIndex:[indexPath row]];
    
    // Configure Cell
    [cell.textLabel setText:[service name]];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    // Fetch Service
//    NSNetService *service = [self.services objectAtIndex:indexPath.row];
//    
//    // Resolve Service
//    [service setDelegate:self];
//    [service resolveWithTimeout:30.0];
//    
//    VWW_LOG_INFO(@"Connecting to %@", self.services[indexPath.row]);
    
//    NSNetService *service = self.clientController.services[indexPath.row];
//    [self.clientController connectToService:service];
    
    [self.clientController connectToServiceAtIndex:indexPath.row];
}




#pragma mark VWWBonjourClientControllerDelegate

-(void)bonjourClientControllerDidStartBrowsing:(VWWBonjourClientController*)sender{
    VWW_LOG_TRACE;
    
}

-(void)bonjourClientController:(VWWBonjourClientController*)sender didStopBrowsingWithError:(NSError*)error{
    VWW_LOG_TRACE;
}

-(void)bonjourClientController:(VWWBonjourClientController*)sender didDiscoverServices:(NSArray*)services{
    VWW_LOG_TRACE;
//    self.services = services;
    [self.tableView reloadData];
}



@end
