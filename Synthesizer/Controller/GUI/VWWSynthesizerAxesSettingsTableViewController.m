//
//  VWWSynthesizerSettingsTableViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/14/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizerAxesSettingsTableViewController.h"
#import "VWWSynthesizerSettingsTableViewController.h"

static NSString *VWWSegueAxesToSynthesizer = @"VWWSegueAxesToSynthesizer";
const NSInteger VWWSynthesizerTouchScreenSection = 0;
const NSInteger VWWSynthesizerAccelerometerSection = 1;
const NSInteger VWWSynthesizerGyroscopeSection = 2;
const NSInteger VWWSynthesizerMagnetometerSection = 3;
const NSInteger VWWSynthesizerXAxisRow = 0;
const NSInteger VWWSynthesizerYAxisRow = 1;
const NSInteger VWWSynthesizerZAxisRow = 2;

@interface VWWSynthesizerAxesSettingsTableViewController ()

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
    if([segue.identifier isEqualToString:VWWSegueAxesToSynthesizer]){
        VWWSynthesizerSettingsTableViewController *vc = segue.destinationViewController;
        vc.normalizedSynthesizer = sender;
    }
}


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
    VWWNormalizedSynthesizer *normalizedSynthesizer;
    if(indexPath.section == VWWSynthesizerTouchScreenSection){
        if(indexPath.row == VWWSynthesizerXAxisRow){
        } else if(indexPath.row == VWWSynthesizerYAxisRow){
        } else if(indexPath.row == VWWSynthesizerZAxisRow){
        }
    } else if(indexPath.section == VWWSynthesizerAccelerometerSection){
        if(indexPath.row == VWWSynthesizerXAxisRow){
        } else if(indexPath.row == VWWSynthesizerYAxisRow){
        } else if(indexPath.row == VWWSynthesizerZAxisRow){
        }
    } else if(indexPath.section == VWWSynthesizerGyroscopeSection){
        if(indexPath.row == VWWSynthesizerXAxisRow){
        } else if(indexPath.row == VWWSynthesizerYAxisRow){
        } else if(indexPath.row == VWWSynthesizerZAxisRow){
        }
    } else if(indexPath.section == VWWSynthesizerMagnetometerSection){
        if(indexPath.row == VWWSynthesizerXAxisRow){
        } else if(indexPath.row == VWWSynthesizerYAxisRow){
        } else if(indexPath.row == VWWSynthesizerZAxisRow){
        }
    }
    
    [self performSegueWithIdentifier:VWWSegueAxesToSynthesizer sender:normalizedSynthesizer];
}



@end
