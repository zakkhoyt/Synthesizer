//
//  VWWSynthesizerSettingsTableViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/14/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizerAxesSettingsTableViewController.h"
//#import "VWWSynthesizerSettingsTableViewController.h"
#import "VWWSynthesizerAxisSettingsTableViewController.h"
#import "VWWSynthesizersController.h"


static NSString *VWWSegueAxesToGroupConfig = @"VWWSegueAxesToGroupConfig";
const NSInteger VWWSynthesizerTouchScreenSection = 0;
const NSInteger VWWSynthesizerAccelerometerSection = 1;
const NSInteger VWWSynthesizerGyroscopeSection = 2;
const NSInteger VWWSynthesizerMagnetometerSection = 3;
const NSInteger VWWSynthesizerConfigureRow = 0;
const NSInteger VWWSynthesizerXAxisRow = 1;
const NSInteger VWWSynthesizerYAxisRow = 2;
const NSInteger VWWSynthesizerZAxisRow = 3;

@interface VWWSynthesizerAxesSettingsTableViewController ()
@property (nonatomic, strong) VWWSynthesizersController *synthesizersController;
@property (weak, nonatomic) IBOutlet UISwitch *touchscreenXAxisSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *touchscreenYAxisSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *accelerometersXAxisSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *accelerometersYAxisSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *accelerometersZAxisSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *gyroscopesXAxisSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *gyroscopesYAxisSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *gyroscopesZAxisSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *magnetometersXAxisSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *magnetometersYAxisSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *magnetometersZAxisSwitch;








@end

@implementation VWWSynthesizerAxesSettingsTableViewController

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

    self.synthesizersController = [VWWSynthesizersController sharedInstance];
    
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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:VWWSegueAxesToGroupConfig]){
        VWWSynthesizerAxisSettingsTableViewController *vc = segue.destinationViewController;
        vc.synthesizerGroup = sender;
    }
}


#pragma mark Private methods
-(void)updateControls{
    // Touchscreen
    self.touchscreenXAxisSwitch.on = !self.synthesizersController.touchscreenGroup.xSynthesizer.muted;
    self.touchscreenYAxisSwitch.on = !self.synthesizersController.touchscreenGroup.ySynthesizer.muted;

    // Accelerometers
    self.accelerometersXAxisSwitch.on = !self.synthesizersController.accelerometersGroup.xSynthesizer.muted;
    self.accelerometersYAxisSwitch.on = !self.synthesizersController.accelerometersGroup.ySynthesizer.muted;
    self.accelerometersZAxisSwitch.on = !self.synthesizersController.accelerometersGroup.zSynthesizer.muted;
    
    // Gyroscopes
    self.gyroscopesXAxisSwitch.on = !self.synthesizersController.gyroscopesGroup.xSynthesizer.muted;
    self.gyroscopesYAxisSwitch.on = !self.synthesizersController.gyroscopesGroup.ySynthesizer.muted;
    self.gyroscopesZAxisSwitch.on = !self.synthesizersController.gyroscopesGroup.zSynthesizer.muted;
    
    // Magnetometers
    self.magnetometersXAxisSwitch.on = !self.synthesizersController.magnetometersGroup.xSynthesizer.muted;
    self.magnetometersYAxisSwitch.on = !self.synthesizersController.magnetometersGroup.ySynthesizer.muted;
    self.magnetometersZAxisSwitch.on = !self.synthesizersController.magnetometersGroup.zSynthesizer.muted;
}

#pragma mark IBActions
- (IBAction)touchscreenXAxisSwitchValueChanged:(UISwitch*)sender {
    self.synthesizersController.touchscreenGroup.xSynthesizer.muted = !sender.on;
}
- (IBAction)touchscreenYAxisSwitchValueChanged:(UISwitch*)sender {
    self.synthesizersController.touchscreenGroup.ySynthesizer.muted = !sender.on;
}


- (IBAction)accelerometersXAxisSwitchValueChanged:(UISwitch*)sender {
    self.synthesizersController.accelerometersGroup.xSynthesizer.muted = !sender.on;
}
- (IBAction)accelerometersYAxisSwitchValueChanged:(UISwitch*)sender {
    self.synthesizersController.accelerometersGroup.ySynthesizer.muted = !sender.on;
}
- (IBAction)accelerometersZAxisSwitchValueChanged:(UISwitch*)sender {
    self.synthesizersController.accelerometersGroup.zSynthesizer.muted = !sender.on;
}

- (IBAction)gyroscopesXAxisSwitchValueChanged:(UISwitch*)sender {
    self.synthesizersController.gyroscopesGroup.xSynthesizer.muted = !sender.on;
}
- (IBAction)gyroscopesYAxisSwitchValueChanged:(UISwitch*)sender {
    self.synthesizersController.gyroscopesGroup.ySynthesizer.muted = !sender.on;
}
- (IBAction)gyroscopesZAxisSwitchValueChanged:(UISwitch*)sender {
    self.synthesizersController.gyroscopesGroup.zSynthesizer.muted = !sender.on;
}

- (IBAction)magnetometersXAxisSwitchValueChanged:(UISwitch*)sender {
    self.synthesizersController.magnetometersGroup.xSynthesizer.muted = !sender.on;
}
- (IBAction)magnetometersYAxisSwitchValueChanged:(UISwitch*)sender {
    self.synthesizersController.magnetometersGroup.ySynthesizer.muted = !sender.on;
}
- (IBAction)magnetometersZAxisSwitchValueChanged:(UISwitch*)sender {
    self.synthesizersController.magnetometersGroup.zSynthesizer.muted = !sender.on;
}




#pragma mark UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Touch Screen";
        case 1:
            return @"Accelerometers";
        case 2:
            return @"Gyroscopes";
        case 3:
            return @"Magnetometers";
        default:
            break;
    }
    return @"";
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    VWWSynthesizerGroup *synthesizerGroup;
    if(indexPath.section == VWWSynthesizerTouchScreenSection){
        synthesizerGroup = self.synthesizersController.touchscreenGroup;
//        if(indexPath.row == VWWSynthesizerXAxisRow){
//        } else if(indexPath.row == VWWSynthesizerYAxisRow){
//        } else if(indexPath.row == VWWSynthesizerZAxisRow){
//        }
    } else if(indexPath.section == VWWSynthesizerAccelerometerSection){
        synthesizerGroup = self.synthesizersController.accelerometersGroup;
//        if(indexPath.row == VWWSynthesizerXAxisRow){
//        } else if(indexPath.row == VWWSynthesizerYAxisRow){
//        } else if(indexPath.row == VWWSynthesizerZAxisRow){
//        }
    } else if(indexPath.section == VWWSynthesizerGyroscopeSection){
        synthesizerGroup = self.synthesizersController.gyroscopesGroup;
//        if(indexPath.row == VWWSynthesizerXAxisRow){
//        } else if(indexPath.row == VWWSynthesizerYAxisRow){
//        } else if(indexPath.row == VWWSynthesizerZAxisRow){
//        }
    } else if(indexPath.section == VWWSynthesizerMagnetometerSection){
        synthesizerGroup = self.synthesizersController.magnetometersGroup;
//        if(indexPath.row == VWWSynthesizerXAxisRow){
//        } else if(indexPath.row == VWWSynthesizerYAxisRow){
//        } else if(indexPath.row == VWWSynthesizerZAxisRow){
//        }
    }
    
    if(indexPath.row == VWWSynthesizerConfigureRow){
        [self performSegueWithIdentifier:VWWSegueAxesToGroupConfig sender:synthesizerGroup];
    }
}



@end
