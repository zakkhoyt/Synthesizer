//
//  VWWSynthesizerAxisSettingsTableViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/18/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizerAxisSettingsTableViewController.h"


const NSInteger VWWSynthesizerAxisFrequencyRow = 0;
const NSInteger VWWSynthesizerAxisWaveformRow = 1;
const NSInteger VWWSynthesizerAxisAmplitudeRow = 2;
const NSInteger VWWSynthesizerAxisEffectRow = 3;
const NSInteger VWWSynthesizerAxisSensitivityRow = 4;

static NSString *VWWSegueAxisToFrequency = @"VWWSegueAxisToFrequency";
static NSString *VWWSegueAxisToWaveform = @"VWWSegueAxisToWaveform";
static NSString *VWWSegueAxisToAmplitude = @"VWWSegueAxisToAmplitude";
static NSString *VWWSegueAxisToEffect = @"VWWSegueAxisToEffect";
static NSString *VWWSegueAxisToSensitivity = @"VWWSegueAxisToSensitivity";

@interface VWWSynthesizerAxisSettingsTableViewController ()

@end

@implementation VWWSynthesizerAxisSettingsTableViewController

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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:VWWSegueAxisToFrequency]){
        
    } else if([segue.identifier isEqualToString:VWWSegueAxisToWaveform]){
        
    } else if([segue.identifier isEqualToString:VWWSegueAxisToAmplitude]){
        
    } else if([segue.identifier isEqualToString:VWWSegueAxisToEffect]){
        
    } else if([segue.identifier isEqualToString:VWWSegueAxisToSensitivity]){
        
    }
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row == VWWSynthesizerAxisFrequencyRow){
        [self performSegueWithIdentifier:VWWSegueAxisToFrequency sender:self];
    } else if(indexPath.row == VWWSynthesizerAxisWaveformRow){
        [self performSegueWithIdentifier:VWWSegueAxisToWaveform sender:self];
    } else if(indexPath.row == VWWSynthesizerAxisAmplitudeRow){
        [self performSegueWithIdentifier:VWWSegueAxisToAmplitude sender:self];
    } else if(indexPath.row == VWWSynthesizerAxisEffectRow){
        [self performSegueWithIdentifier:VWWSegueAxisToEffect sender:self];
    } else if(indexPath.row == VWWSynthesizerAxisSensitivityRow){
        [self performSegueWithIdentifier:VWWSegueAxisToSensitivity sender:self];
    }
    
    
}
@end
