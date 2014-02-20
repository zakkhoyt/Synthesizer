//
//  VWWStatisticsMotionSensorsTableViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/19/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWStatisticsMotionSensorsTableViewController.h"
#import "VWWSynthesizersController.h"

@interface VWWStatisticsMotionSensorsTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *accelerometersLabel;
@property (weak, nonatomic) IBOutlet UILabel *gyroscopesLabel;
@property (weak, nonatomic) IBOutlet UILabel *magnetometersLabel;

@end

@implementation VWWStatisticsMotionSensorsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateControls];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Private methods

-(void)updateControls{
    VWW_LOG_TODO_TASK(@"Use KVO to update these labels");
    self.accelerometersLabel.text = [VWWSynthesizersController sharedInstance].accelerometersStatisticsString;
    self.gyroscopesLabel.text = [VWWSynthesizersController sharedInstance].gyroscopesStatisticsString;
    self.magnetometersLabel.text = [VWWSynthesizersController sharedInstance].magnetometersStatisticsString;
}



#pragma mark UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Accelerometers";
        case 1:
            return @"Gyroscopes";
        case 2:
            return @"Magnetometers";
        default:
            break;
    }
    return @"";
}
@end
