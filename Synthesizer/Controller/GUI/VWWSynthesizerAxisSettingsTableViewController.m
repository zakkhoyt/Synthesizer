//
//  VWWSynthesizerAxisSettingsTableViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/18/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizerAxisSettingsTableViewController.h"
#import "VWWSynthesizerGroup.h"
#import "VWWFrequencyParametersTableViewController.h"
#import "VWWWaveformParametersTableViewController.h"
#import "VWWAmplitudeParametersTableViewController.h"
#import "VWWEffectParametersTableViewController.h"
#import "VWWSensitivityParameterTableViewController.h"

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
@property (weak, nonatomic) IBOutlet UILabel *frequencySummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *waveformSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *amplitudeSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *effectSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *sensitivitySummaryLabel;

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
    if([segue.identifier isEqualToString:VWWSegueAxisToFrequency]){
        VWWFrequencyParametersTableViewController *vc = segue.destinationViewController;
        vc.synthesizerGroup = self.synthesizerGroup;
    } else if([segue.identifier isEqualToString:VWWSegueAxisToWaveform]){
        VWWWaveformParametersTableViewController *vc = segue.destinationViewController;
        vc.synthesizerGroup = self.synthesizerGroup;
    } else if([segue.identifier isEqualToString:VWWSegueAxisToAmplitude]){
        VWWAmplitudeParametersTableViewController *vc = segue.destinationViewController;
        vc.synthesizerGroup = self.synthesizerGroup;
    } else if([segue.identifier isEqualToString:VWWSegueAxisToEffect]){
        VWWEffectParametersTableViewController *vc = segue.destinationViewController;
        vc.synthesizerGroup = self.synthesizerGroup;
    } else if([segue.identifier isEqualToString:VWWSegueAxisToSensitivity]){
        VWWSensitivityParameterTableViewController *vc = segue.destinationViewController;
        vc.synthesizerGroup = self.synthesizerGroup;
    }
}


#pragma mark Private methods


-(NSString*)stringFromWavetype:(VWWWaveType)waveType{
    if(waveType == VWWWaveTypeSine){
        return @"Sine wave";
    } else if(waveType == VWWWaveTypeSquare){
        return @"Square wave";
    } else if(waveType == VWWWaveTypeTriangle){
        return @"Triangle wave";
    } else if(waveType == VWWWaveTypeSawtooth){
        return @"Sawtooth wave";
    }
    return @"";
}


-(NSString*)stringFromEffectType:(VWWEffectType)effectType{
    if(effectType == VWWEffectTypeNone){
        return @"None";
    } else if(effectType == VWWEffectTypeAutoTune){
        return @"Autotune";
    }
    return @"";
    
}

-(void)updateControls{
    NSString *frequencySummaryString = [NSString stringWithFormat:@"x: %.0fHz - %.0fHz\n"
                                        @"y: %.0fHz - %.0fHz\n"
                                        @"z: %.0fHz - %.0fHz",
                                        self.synthesizerGroup.xSynthesizer.frequencyMin, self.synthesizerGroup.xSynthesizer.frequencyMax,
                                        self.synthesizerGroup.ySynthesizer.frequencyMin, self.synthesizerGroup.ySynthesizer.frequencyMax,
                                        self.synthesizerGroup.zSynthesizer.frequencyMin, self.synthesizerGroup.zSynthesizer.frequencyMax];
    self.frequencySummaryLabel.text = frequencySummaryString;
    
    
    NSString *waveformSummaryString = [NSString stringWithFormat:@"x: %@\n"
                                        @"y: %@\n"
                                        @"z: %@",
                                       [self stringFromWavetype:self.synthesizerGroup.xSynthesizer.waveType],
                                       [self stringFromWavetype:self.synthesizerGroup.ySynthesizer.waveType],
                                       [self stringFromWavetype:self.synthesizerGroup.zSynthesizer.waveType]];
    self.waveformSummaryLabel.text = waveformSummaryString;


    NSString *amplitudeSummaryString = [NSString stringWithFormat:@"x: %ld%%\n"
                                        @"y: %ld%%\n"
                                        @"z: %ld%%",
                                        (long)(self.synthesizerGroup.xSynthesizer.amplitude * 100.0),
                                        (long)(self.synthesizerGroup.ySynthesizer.amplitude * 100.0),
                                        (long)(self.synthesizerGroup.zSynthesizer.amplitude * 100.0)];
    self.amplitudeSummaryLabel.text = amplitudeSummaryString;
    
    
    NSString *effectSummaryString = [NSString stringWithFormat:@"x: %@\n"
                                       @"y: %@\n"
                                       @"z: %@",
                                       [self stringFromEffectType:self.synthesizerGroup.xSynthesizer.effectType],
                                       [self stringFromEffectType:self.synthesizerGroup.ySynthesizer.effectType],
                                       [self stringFromEffectType:self.synthesizerGroup.zSynthesizer.effectType]];
    self.effectSummaryLabel.text = effectSummaryString;

    
    
//    NSString *amplitudeSummaryString = [NSString stringWithFormat:@"x: %.2f\n"
//                                        @"y: %.2f\n"
//                                        @"z: %.2f",
//                                        self.synthesizerGroup.xSynthesizer.amplitude,
//                                        self.synthesizerGroup.ySynthesizer.amplitude,
//                                        self.synthesizerGroup.zSynthesizer.amplitude];
//    self.amplitudeSummaryLabel.text = amplitudeSummaryString;
    
    
    
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
