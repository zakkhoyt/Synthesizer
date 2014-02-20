//
//  VWWGeneralSettingsTableViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/14/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWGeneralSettingsTableViewController.h"
#import "VWWGeneralSettings.h"

@interface VWWGeneralSettingsTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *frequencyMinimumTextField;
@property (weak, nonatomic) IBOutlet UITextField *frequencyMaximumTextField;

@end

@implementation VWWGeneralSettingsTableViewController

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
    VWWGeneralSettings *generalSettings = [VWWGeneralSettings sharedInstance];
    
    self.frequencyMinimumTextField.text = [NSString stringWithFormat:@"%.0f", generalSettings.frequencyMin];
    self.frequencyMaximumTextField.text = [NSString stringWithFormat:@"%.0f", generalSettings.frequencyMax];
}

-(void)validateControls{
    
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

- (IBAction)frequencyMinimumTextFieldEditingDidEnd:(UITextField*)sender {
    float value = sender.text.floatValue;
    [[VWWGeneralSettings sharedInstance] setFrequencyMin:value];
}


- (IBAction)frequencyMaximumTextFieldEditingDidEnd:(UITextField*)sender {
    float value = sender.text.floatValue;
    [[VWWGeneralSettings sharedInstance] setFrequencyMax:value];

}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    [self validateControls];
    [self updateControls];
    return YES;
}

@end
