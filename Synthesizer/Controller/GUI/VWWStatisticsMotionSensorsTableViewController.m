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
@property (nonatomic, strong) VWWSynthesizersController *synthesizersController;
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
    self.synthesizersController = [VWWSynthesizersController sharedInstance];
    [self updateControls];
    [self addKeyValueObservers];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeKeyValueObservers];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Private methods (KVO)


-(void)addKeyValueObservers{
    [self.synthesizersController addObserver:self forKeyPath:VWWSynthesizersControllerAccelerometersStatisticsString options:NSKeyValueObservingOptionNew context:NULL];
    [self.synthesizersController addObserver:self forKeyPath:VWWSynthesizersControllerGyroscopesStatisticsString options:NSKeyValueObservingOptionNew context:NULL];
    [self.synthesizersController addObserver:self forKeyPath:VWWSynthesizersControllerMagnetoometersStatisticsString options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)removeKeyValueObservers{
    [self.synthesizersController removeObserver:self forKeyPath:VWWSynthesizersControllerAccelerometersStatisticsString];
    [self.synthesizersController removeObserver:self forKeyPath:VWWSynthesizersControllerGyroscopesStatisticsString];
    [self.synthesizersController removeObserver:self forKeyPath:VWWSynthesizersControllerMagnetoometersStatisticsString];
}


-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    // Rather than passing the parameters though KVO, they are already available as public properties.
    // Easier to use that, just using KVO as a trigger.
    if([keyPath isEqualToString:VWWSynthesizersControllerAccelerometersStatisticsString]){
        self.accelerometersLabel.text = self.synthesizersController.accelerometersStatisticsString;
    } else if([keyPath isEqualToString:VWWSynthesizersControllerGyroscopesStatisticsString]) {
        self.gyroscopesLabel.text = self.synthesizersController.gyroscopesStatisticsString;
    } else if([keyPath isEqualToString:VWWSynthesizersControllerMagnetoometersStatisticsString]) {
        self.magnetometersLabel.text = self.synthesizersController.magnetometersStatisticsString;
    }
}


#pragma mark Private methods
-(void)updateControls{
    VWW_LOG_TODO_TASK(@"Use KVO to update these labels");
    self.accelerometersLabel.text = self.synthesizersController.accelerometersStatisticsString;
    self.gyroscopesLabel.text = self.synthesizersController.gyroscopesStatisticsString;
    self.magnetometersLabel.text = self.synthesizersController.magnetometersStatisticsString;
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
