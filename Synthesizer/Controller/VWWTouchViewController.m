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
    self.touchSynthX = [[VWWNormalizedSynthesizer alloc]initWithFrequencyMin:30 frequencyMax:500 frequencyNormalized:0.5];
    self.touchSynthY = [[VWWNormalizedSynthesizer alloc]initWithFrequencyMin:30 frequencyMax:500 frequencyNormalized:0.5];
    self.touchSynthX.muted = YES;
    self.touchSynthY.muted = YES;
    [self.touchSynthX start];
    [self.touchSynthY start];
    self.touchView.delegate = self;
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
        self.touchSynthX.frequencyNormalized = x.floatValue;
        self.touchSynthY.frequencyNormalized = y.floatValue;
    }

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
