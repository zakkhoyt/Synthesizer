//
//  VWWAmplitudeParametersTableViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/19/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWAmplitudeParametersTableViewController.h"
#import "VWWSynthesizerGroup.h" 

@interface VWWAmplitudeParametersTableViewController ()
@property (weak, nonatomic) IBOutlet UISlider *xAmplitudeSlider;
@property (weak, nonatomic) IBOutlet UISlider *yAmplitudeSlider;
@property (weak, nonatomic) IBOutlet UISlider *zAmplitudeSlider;

@property (weak, nonatomic) IBOutlet UITextField *xAmplitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *yAmplitudeTextField;
@property (weak, nonatomic) IBOutlet UITextField *zAmplitudeTextField;
@end

@implementation VWWAmplitudeParametersTableViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateControls];
}

#pragma mark Private methods
-(void)updateControls{
    
    
    // Slider minimum values
    self.xAmplitudeSlider.minimumValue = 0.0;
    self.yAmplitudeSlider.minimumValue = 0.0;
    self.zAmplitudeSlider.minimumValue = 0.0;
    
    // Slider maximum values
    self.xAmplitudeSlider.maximumValue = 1.0;
    self.yAmplitudeSlider.maximumValue = 1.0;
    self.zAmplitudeSlider.maximumValue = 1.0;
    
    // Slider value
    self.xAmplitudeSlider.value = self.synthesizerGroup.xSynthesizer.amplitude;
    self.yAmplitudeSlider.value = self.synthesizerGroup.ySynthesizer.amplitude;
    self.zAmplitudeSlider.value = self.synthesizerGroup.zSynthesizer.amplitude;
    
//    // Text boxes
//    self.xFrequencyMinTextField.text = [NSString stringWithFormat:@"%.0f", self.synthesizerGroup.xSynthesizer.frequencyMin];
//    self.xFrequencyMaxTextField.text = [NSString stringWithFormat:@"%.0f", self.synthesizerGroup.xSynthesizer.frequencyMax];
//    self.yFrequencyMinTextField.text = [NSString stringWithFormat:@"%.0f", self.synthesizerGroup.ySynthesizer.frequencyMin];
//    self.yFrequencyMaxTextField.text = [NSString stringWithFormat:@"%.0f", self.synthesizerGroup.ySynthesizer.frequencyMax];
//    self.zFrequencyMinTextField.text = [NSString stringWithFormat:@"%.0f", self.synthesizerGroup.zSynthesizer.frequencyMin];
//    self.zFrequencyMaxTextField.text = [NSString stringWithFormat:@"%.0f", self.synthesizerGroup.zSynthesizer.frequencyMax];
    
    
    
}


#pragma mark IBActions

- (IBAction)xAmplitudeSliderValueChanged:(UISlider*)sender {
    self.synthesizerGroup.xSynthesizer.amplitude = sender.value;
}
- (IBAction)yAmplitudeSliderValueChanged:(UISlider*)sender {
    self.synthesizerGroup.ySynthesizer.amplitude = sender.value;
}
- (IBAction)zAmplitudeSliderValueChanged:(UISlider*)sender {
    self.synthesizerGroup.zSynthesizer.amplitude = sender.value;
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
