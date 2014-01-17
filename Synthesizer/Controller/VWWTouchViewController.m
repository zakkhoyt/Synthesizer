//
//  VWWTouchViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWTouchViewController.h"
#import "VWWTouchView.h"
#import "VWWNormalizedSynthesizer.h"

static NSString *VWWSegueTouchToGroups = @"VWWSegueTouchToGroups";

@interface VWWTouchViewController () <VWWTouchViewDelegate>
@property (weak, nonatomic) IBOutlet VWWTouchView *touchView;
@property (nonatomic, strong) VWWNormalizedSynthesizer *touchSynthX;
@property (nonatomic, strong) VWWNormalizedSynthesizer *touchSynthY;
@end

@implementation VWWTouchViewController

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

    self.touchSynthX = [[VWWNormalizedSynthesizer alloc]initWithFrequencyLeftMin:30 frequencyLeftMax:500 frequencyLeftNormalized:1.0
                                                               frequencyRightMin:30 frequencyRightMax:500 frequencyRightNormalized:1.0];
    self.touchSynthY = [[VWWNormalizedSynthesizer alloc]initWithFrequencyLeftMin:30 frequencyLeftMax:500 frequencyLeftNormalized:1.0
                                                               frequencyRightMin:30 frequencyRightMax:500 frequencyRightNormalized:1.0];

    self.touchSynthX.muted = YES;
    self.touchSynthY.muted = YES;
    [self.touchSynthX start];
    [self.touchSynthY start];
    self.touchView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private methods
-(void)updateFrequenciesWithArray:(NSArray*)array{
    for(NSDictionary *dictionary in array){
        NSNumber *x = dictionary[VWWTouchViewXKey];
        NSNumber *y = dictionary[VWWTouchViewYKey];
        self.touchSynthX.frequencyLeftNormalized = x.floatValue;
        self.touchSynthX.frequencyRightNormalized = x.floatValue;
        self.touchSynthY.frequencyLeftNormalized = y.floatValue;
        self.touchSynthY.frequencyRightNormalized = y.floatValue;
    }

}


#pragma mark IBActions
- (IBAction)settingsButtonTouchUpInside:(id)sender {
    [self performSegueWithIdentifier:VWWSegueTouchToGroups sender:self];
}




#pragma mark VWWTouchViewDelegate
-(void)touchViewDelegate:(VWWTouchView*)sender touchesBeganWithArray:(NSArray*)array{
    self.touchSynthX.muted = NO;
    self.touchSynthY.muted = NO;
    [self updateFrequenciesWithArray:array];
}

-(void)touchViewDelegate:(VWWTouchView*)sender touchesMovedWithArray:(NSArray*)array{
    [self updateFrequenciesWithArray:array];
}

-(void)touchViewDelegate:(VWWTouchView*)sender touchesEndedWithArray:(NSArray*)array{
    [self updateFrequenciesWithArray:array];
    self.touchSynthX.muted = YES;
    self.touchSynthY.muted = YES;
}

@end
