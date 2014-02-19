//
//  VWWSensitivityParameterTableViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/19/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWSensitivityParameterTableViewController.h"
#import "VWWSynthesizerGroup.h" 



@interface VWWSensitivityParameterTableViewController ()
@property (weak, nonatomic) IBOutlet UISlider *xSensitivitySlider;
@property (weak, nonatomic) IBOutlet UISlider *ySensitivitySlider;
@property (weak, nonatomic) IBOutlet UISlider *zSensitivitySlider;

@end

@implementation VWWSensitivityParameterTableViewController

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
    
    
    // Slider minimum values
    self.xSensitivitySlider.minimumValue = 0.0;
    self.ySensitivitySlider.minimumValue = 0.0;
    self.zSensitivitySlider.minimumValue = 0.0;
    
    // Slider maximum values
    self.xSensitivitySlider.maximumValue = 1.0;
    self.ySensitivitySlider.maximumValue = 1.0;
    self.zSensitivitySlider.maximumValue = 1.0;
    
//    // Slider value
//    self.xSensitivitySlider.value = self.synthesizerGroup.xSynthesizer.sensitivity;
//    self.ySensitivitySlider.value = self.synthesizerGroup.ySynthesizer.sensitivity;
//    self.zSensitivitySlider.value = self.synthesizerGroup.zSynthesizer.sensitivity;
    self.xSensitivitySlider.value = 1.0;
    self.ySensitivitySlider.value = 1.0;
    self.zSensitivitySlider.value = 1.0;
    
}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self updateControls];
    return YES;
}



#pragma mark UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case VWWAxisTypeX:
            return @"X-Axis";
        case VWWAxisTypeY:
            return @"Y-Axis";
        case VWWAxisTypeZ:
            return @"Z-Axis";
        default:
            break;
    }
    return @"";
}
@end
