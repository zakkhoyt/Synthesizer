//
//  VWWFrequencyParametersTableViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/19/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWFrequencyParametersTableViewController.h"
#import "VWWGeneralSettings.h"
#import "VWWSynthesizerGroup.h" 

const NSInteger VWWFrequencyParametersTableViewControllerXAxisSection = 0;
const NSInteger VWWFrequencyParametersTableViewControllerYAxisSection = 1;
const NSInteger VWWFrequencyParametersTableViewControllerZAxisSection = 2;



@interface VWWFrequencyParametersTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *xFrequencyMinTextField;
@property (weak, nonatomic) IBOutlet UITextField *xFrequencyMaxTextField;

@property (weak, nonatomic) IBOutlet UITextField *yFrequencyMinTextField;
@property (weak, nonatomic) IBOutlet UITextField *yFrequencyMaxTextField;

@property (weak, nonatomic) IBOutlet UITextField *zFrequencyMinTextField;
@property (weak, nonatomic) IBOutlet UITextField *zFrequencyMaxTextField;


@property (weak, nonatomic) IBOutlet UISlider *xFrequencyMinSlider;
@property (weak, nonatomic) IBOutlet UISlider *xFrequencyMaxSlider;

@property (weak, nonatomic) IBOutlet UISlider *yFrequencyMinSlider;
@property (weak, nonatomic) IBOutlet UISlider *yFrequencyMaxSlider;

@property (weak, nonatomic) IBOutlet UISlider *zFrequencyMinSlider;
@property (weak, nonatomic) IBOutlet UISlider *zFrequencyMaxSlider;

@end

@implementation VWWFrequencyParametersTableViewController

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
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Private methods
-(void)updateControls{
    
    VWWGeneralSettings *generalSettings = [VWWGeneralSettings sharedInstance];
    
    // Slider minimum values
    self.xFrequencyMinSlider.minimumValue = generalSettings.frequencyMin;
    self.xFrequencyMaxSlider.minimumValue = generalSettings.frequencyMin;
    self.yFrequencyMinSlider.minimumValue = generalSettings.frequencyMin;
    self.yFrequencyMaxSlider.minimumValue = generalSettings.frequencyMin;
    self.zFrequencyMinSlider.minimumValue = generalSettings.frequencyMin;
    self.zFrequencyMaxSlider.minimumValue = generalSettings.frequencyMin;
    
    // Slider maximum values
    self.xFrequencyMinSlider.maximumValue = generalSettings.frequencyMax;
    self.xFrequencyMaxSlider.maximumValue = generalSettings.frequencyMax;
    self.yFrequencyMinSlider.maximumValue = generalSettings.frequencyMax;
    self.yFrequencyMaxSlider.maximumValue = generalSettings.frequencyMax;
    self.zFrequencyMinSlider.maximumValue = generalSettings.frequencyMax;
    self.zFrequencyMaxSlider.maximumValue = generalSettings.frequencyMax;
    
    // Slider value
    self.xFrequencyMinSlider.value = self.synthesizerGroup.xSynthesizer.frequencyMin;
    self.xFrequencyMaxSlider.value = self.synthesizerGroup.xSynthesizer.frequencyMax;
    self.yFrequencyMinSlider.value = self.synthesizerGroup.ySynthesizer.frequencyMin;
    self.yFrequencyMaxSlider.value = self.synthesizerGroup.ySynthesizer.frequencyMax;
    self.zFrequencyMinSlider.value = self.synthesizerGroup.zSynthesizer.frequencyMin;
    self.zFrequencyMaxSlider.value = self.synthesizerGroup.zSynthesizer.frequencyMax;
    
    // Text boxes
    self.xFrequencyMinTextField.text = [NSString stringWithFormat:@"%.0f", self.synthesizerGroup.xSynthesizer.frequencyMin];
    self.xFrequencyMaxTextField.text = [NSString stringWithFormat:@"%.0f", self.synthesizerGroup.xSynthesizer.frequencyMax];
    self.yFrequencyMinTextField.text = [NSString stringWithFormat:@"%.0f", self.synthesizerGroup.ySynthesizer.frequencyMin];
    self.yFrequencyMaxTextField.text = [NSString stringWithFormat:@"%.0f", self.synthesizerGroup.ySynthesizer.frequencyMax];
    self.zFrequencyMinTextField.text = [NSString stringWithFormat:@"%.0f", self.synthesizerGroup.zSynthesizer.frequencyMin];
    self.zFrequencyMaxTextField.text = [NSString stringWithFormat:@"%.0f", self.synthesizerGroup.zSynthesizer.frequencyMax];

    
    
}


#pragma mark IBActions

- (IBAction)xFrequencyMinSliderValueChanged:(UISlider*)sender {
    self.synthesizerGroup.xSynthesizer.frequencyMin = sender.value;
    [self updateControls];
}
- (IBAction)xFrequencyMaxSliderValueChanged:(UISlider*)sender {
    self.synthesizerGroup.xSynthesizer.frequencyMax = sender.value;
    [self updateControls];
}
- (IBAction)yFrequencyMinSliderValueChanged:(UISlider*)sender {
    self.synthesizerGroup.ySynthesizer.frequencyMin = sender.value;
    [self updateControls];
}
- (IBAction)yFrequencyMaxSliderValueChanged:(UISlider*)sender {
    self.synthesizerGroup.ySynthesizer.frequencyMax = sender.value;
    [self updateControls];
}
- (IBAction)zFrequencyMinSliderValueChanged:(UISlider*)sender {
    self.synthesizerGroup.zSynthesizer.frequencyMin = sender.value;
    [self updateControls];
}
- (IBAction)zFrequencyMaxSliderValueChanged:(UISlider*)sender {
    self.synthesizerGroup.zSynthesizer.frequencyMax = sender.value;
    [self updateControls];
}


- (IBAction)xFrequencyMinTextFieldEditingDidEnd:(id)sender {
    VWW_LOG_INFO(@"")
}





#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self updateControls];
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    /* for backspace */
    if([string length]==0){
        return YES;
    }
    
    /*  limit to only numeric characters  */
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < [string length]; i++) {
        unichar c = [string characterAtIndex:i];
        if ([myCharSet characterIsMember:c]) {
            return YES;
        }
    }
    
    return NO;
}



#pragma mark UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case VWWFrequencyParametersTableViewControllerXAxisSection:
            return @"X-Axis";
        case VWWFrequencyParametersTableViewControllerYAxisSection:
            return @"Y-Axis";
        case VWWFrequencyParametersTableViewControllerZAxisSection:
            return @"Z-Axis";
        default:
            break;
    }
    return @"";
}

@end
