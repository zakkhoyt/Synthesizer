//
//  VWWGroupSettingsViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/16/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWGroupSettingsViewController.h"

static NSString *VWWSegueGroupsToAxis = @"VWWSegueGroupsToAxis";

@interface VWWGroupSettingsViewController ()

@end

@implementation VWWGroupSettingsViewController

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
    self.navigationController.navigationBar.hidden = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:VWWSegueGroupsToAxis sender:self];
}
@end
