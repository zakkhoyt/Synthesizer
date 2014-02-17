//
//  VWWTouchViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWTouchViewController.h"
#import "VWWTouchView.h"
#import "VWWSynthesizerGroup.h"
#import "VWWGeneralSettings.h"

static NSString *VWWSegueTouchToSettings = @"VWWSegueTouchToSettings";

@interface VWWTouchViewController () <VWWTouchViewDelegate>
@property (weak, nonatomic) IBOutlet VWWTouchView *touchView;
@property (nonatomic, strong) VWWSynthesizerGroup *group;
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
    
    VWWGeneralSettings *generalSettings = [VWWGeneralSettings sharedInstance];
    self.group = [[VWWSynthesizerGroup alloc]initWithAmplitudeX:generalSettings.amplitude xFrequencyMin:generalSettings.frequencyMin xFrequencyMax:generalSettings.frequencyMax xFrequencyNormalized:generalSettings.frequencyNormalized
                                                     amplitudeY:generalSettings.amplitude yFrequencyMin:generalSettings.frequencyMin yFrequencyMax:generalSettings.frequencyMax yFrequencyNormalized:generalSettings.frequencyNormalized
                                                     amplitudeZ:generalSettings.amplitude zFrequencyMin:generalSettings.frequencyMin zFrequencyMax:generalSettings.frequencyMax zFrequencyNormalized:generalSettings.frequencyNormalized];
    
    self.group.muted = YES;
    [self.group start];
                  
    self.touchView.delegate = self;
    
    [self addGestureRecognizers];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:VWWSegueTouchToSettings]){
//        
//    }
//}

#pragma mark Private methods


-(void)addGestureRecognizers{
    // Gesture recognizer
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureHandler:)];
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureHandler:)];
    [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];
    
    UITapGestureRecognizer *twoFingerTripleTapGestureHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerTripleTapGestureHandler:)];
    twoFingerTripleTapGestureHandler.numberOfTapsRequired = 3;
    twoFingerTripleTapGestureHandler.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:twoFingerTripleTapGestureHandler];
    
    [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
}



-(void)singleTapGestureHandler:(UIGestureRecognizer*)gestureRecognizer{
    VWW_LOG_INFO(@"Single Tap");

}

-(void)doubleTapGestureHandler:(UIGestureRecognizer*)gestureRecognizer{
    VWW_LOG_INFO(@"Double Tap");
}

- (void)twoFingerTripleTapGestureHandler:(UITapGestureRecognizer*)recognizer {
    VWW_LOG_INFO(@"Settings tap");
    [self performSegueWithIdentifier:VWWSegueTouchToSettings sender:self];
}


-(void)updateFrequenciesWithArray:(NSArray*)array{
    for(NSDictionary *dictionary in array){
        NSNumber *x = dictionary[VWWTouchViewXKey];
        NSNumber *y = dictionary[VWWTouchViewYKey];
        self.group.xSynthesizer.frequencyNormalized = x.floatValue;
        self.group.ySynthesizer.frequencyNormalized = y.floatValue;
    }

}

#pragma mark VWWTouchViewDelegate
-(void)touchViewDelegate:(VWWTouchView*)sender touchesBeganWithArray:(NSArray*)array{
    self.group.xSynthesizer.muted = NO;
    self.group.ySynthesizer.muted = NO;
    [self updateFrequenciesWithArray:array];
}

-(void)touchViewDelegate:(VWWTouchView*)sender touchesMovedWithArray:(NSArray*)array{
    [self updateFrequenciesWithArray:array];
}

-(void)touchViewDelegate:(VWWTouchView*)sender touchesEndedWithArray:(NSArray*)array{
    [self updateFrequenciesWithArray:array];
    self.group.xSynthesizer.muted = YES;
    self.group.ySynthesizer.muted = YES;
}

@end
