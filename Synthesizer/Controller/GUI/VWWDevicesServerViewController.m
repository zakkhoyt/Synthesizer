//
//  VWWDevicesServerViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/14/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWDevicesServerViewController.h"
#import "VWWBonjourServerController.h"

@interface VWWDevicesServerViewController () <VWWBonjourServerControllerDelegate>
@property (nonatomic, strong) VWWBonjourServerController *server;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation VWWDevicesServerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.server = [VWWBonjourServerController sharedInstance];
    [self.server startBroadcast];
    self.server.delegate = self;
    self.infoLabel.text = @"Started";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Private methods




#pragma mark VWWBonjourServerControllerDelegate
-(void)bonjourControllerDidStartBroadcasting:(VWWBonjourServerController*)sender{
    VWW_LOG_TRACE;
    
    self.infoLabel.text = @"Started broadcasting";
}
-(void)bonjourController:(VWWBonjourServerController*)sender didPublishService:(NSNetService*)service{
    VWW_LOG_TRACE;
    
    self.infoLabel.text = @"Published service on bonjour";
}

-(void)bonjourController:(VWWBonjourServerController*)sender didRecieveCommand:(NSString*)command{
    VWW_LOG_TRACE;
    
    self.infoLabel.text = [NSString stringWithFormat:@"Received command: %@", command];
}

-(void)bonjourController:(VWWBonjourServerController*)sender didConnectToClient:(NSNetService*)service{
    VWW_LOG_TRACE;
    
    self.infoLabel.text = [NSString stringWithFormat:@"Established connection to service: %@", service.hostName ];
}
-(void)bonjourController:(VWWBonjourServerController*)sender service:(NSNetService*)service errorOccurred:(NSError*)error{
    VWW_LOG_TRACE;
    self.infoLabel.text = [NSString stringWithFormat:@"Error occurred with service: %@\nerror: %@", service.hostName, error.localizedDescription];
}


@end
