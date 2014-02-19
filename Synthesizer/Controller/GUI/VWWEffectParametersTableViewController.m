//
//  VWWEffectParametersTableViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/19/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWEffectParametersTableViewController.h"
#import "VWWSynthesizerGroup.h"
#import "VWWEffectTableViewCell.h"

@interface VWWEffectParametersTableViewController ()

@end

@implementation VWWEffectParametersTableViewController

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



#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VWWEffectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VWWEffectTableViewCell"];
    cell.effectType = (VWWEffectType)indexPath.row;
    
    if(indexPath.section == VWWAxisTypeX){
        if(indexPath.row == (NSInteger)self.synthesizerGroup.xSynthesizer.effectType){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if(indexPath.section == VWWAxisTypeY){
        if(indexPath.row == (NSInteger)self.synthesizerGroup.ySynthesizer.effectType){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if(indexPath.section == VWWAxisTypeZ){
        if(indexPath.row == (NSInteger)self.synthesizerGroup.zSynthesizer.effectType){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

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




#pragma mark UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Update checkmark
    for(NSInteger index = 0; index < 2; index++){
        NSIndexPath *ip = [NSIndexPath indexPathForRow:index inSection:indexPath.section];
        VWWEffectTableViewCell *cell = (VWWEffectTableViewCell*)[tableView cellForRowAtIndexPath:ip];
        if(index == indexPath.row){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    // Set wavetype
    if(indexPath.section == VWWAxisTypeX) {
        self.synthesizerGroup.xSynthesizer.effectType = (VWWEffectType)indexPath.row;
    } else if(indexPath.section == VWWAxisTypeY) {
        self.synthesizerGroup.ySynthesizer.effectType = (VWWEffectType)indexPath.row;
    } else if(indexPath.section == VWWAxisTypeZ) {
        self.synthesizerGroup.zSynthesizer.effectType = (VWWEffectType)indexPath.row;
    }
}



@end
