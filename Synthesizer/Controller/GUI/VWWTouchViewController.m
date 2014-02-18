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
#import "VWWMotionMonitor.h"

static NSString *VWWSegueTouchToSettings = @"VWWSegueTouchToSettings";

@interface VWWTouchViewController () <VWWTouchViewDelegate, VWWMotionMonitorDelegate>
@property (weak, nonatomic) IBOutlet VWWTouchView *touchView;
@property (nonatomic, strong) VWWSynthesizerGroup *touchGroup;
@property (nonatomic, strong) VWWSynthesizerGroup *accelerometerGroup;
@property (nonatomic, strong) VWWSynthesizerGroup *gyroscopeGroup;
@property (nonatomic, strong) VWWSynthesizerGroup *magnetometerGroup;
@property (nonatomic, strong) VWWMotionMonitor *motionMonitor;
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
    
    
    [self setupSynthesizers];
    
    [self setupMotionMonitor];
    
    
    
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


-(void)setupSynthesizers{
    // Touchscreeen
    VWWGeneralSettings *generalSettings = [VWWGeneralSettings sharedInstance];
    self.touchGroup = [[VWWSynthesizerGroup alloc]initWithAmplitudeX:generalSettings.amplitude xFrequencyMin:generalSettings.frequencyMin xFrequencyMax:generalSettings.frequencyMax xFrequencyNormalized:generalSettings.frequencyNormalized
                                                          amplitudeY:generalSettings.amplitude yFrequencyMin:generalSettings.frequencyMin yFrequencyMax:generalSettings.frequencyMax yFrequencyNormalized:generalSettings.frequencyNormalized
                                                          amplitudeZ:generalSettings.amplitude zFrequencyMin:generalSettings.frequencyMin zFrequencyMax:generalSettings.frequencyMax zFrequencyNormalized:generalSettings.frequencyNormalized];
    self.touchGroup.muted = YES;
    [self.touchGroup start];
    self.touchView.delegate = self;
    
    
    
    
    // Accelerometer
    self.accelerometerGroup = [[VWWSynthesizerGroup alloc]initWithAmplitudeX:generalSettings.amplitude xFrequencyMin:generalSettings.frequencyMin xFrequencyMax:generalSettings.frequencyMax xFrequencyNormalized:generalSettings.frequencyNormalized
                                                                  amplitudeY:generalSettings.amplitude yFrequencyMin:generalSettings.frequencyMin yFrequencyMax:generalSettings.frequencyMax yFrequencyNormalized:generalSettings.frequencyNormalized
                                                                  amplitudeZ:generalSettings.amplitude zFrequencyMin:generalSettings.frequencyMin zFrequencyMax:generalSettings.frequencyMax zFrequencyNormalized:generalSettings.frequencyNormalized];
    self.accelerometerGroup.xSynthesizer.muted = YES;
    self.accelerometerGroup.zSynthesizer.muted = YES;
    self.accelerometerGroup.ySynthesizer.muted = YES;
    [self.accelerometerGroup start];
    
    // Gyroscope
    self.gyroscopeGroup = [[VWWSynthesizerGroup alloc]initWithAmplitudeX:generalSettings.amplitude xFrequencyMin:generalSettings.frequencyMin xFrequencyMax:generalSettings.frequencyMax xFrequencyNormalized:generalSettings.frequencyNormalized
                                                              amplitudeY:generalSettings.amplitude yFrequencyMin:generalSettings.frequencyMin yFrequencyMax:generalSettings.frequencyMax yFrequencyNormalized:generalSettings.frequencyNormalized
                                                              amplitudeZ:generalSettings.amplitude zFrequencyMin:generalSettings.frequencyMin zFrequencyMax:generalSettings.frequencyMax zFrequencyNormalized:generalSettings.frequencyNormalized];
    self.gyroscopeGroup.xSynthesizer.muted = YES;
    self.gyroscopeGroup.zSynthesizer.muted = YES;
    self.gyroscopeGroup.ySynthesizer.muted = YES;
    [self.gyroscopeGroup start];

    
    // Magnetometer
    self.magnetometerGroup = [[VWWSynthesizerGroup alloc]initWithAmplitudeX:generalSettings.amplitude xFrequencyMin:generalSettings.frequencyMin xFrequencyMax:generalSettings.frequencyMax xFrequencyNormalized:generalSettings.frequencyNormalized
                                                                 amplitudeY:generalSettings.amplitude yFrequencyMin:generalSettings.frequencyMin yFrequencyMax:generalSettings.frequencyMax yFrequencyNormalized:generalSettings.frequencyNormalized
                                                                 amplitudeZ:generalSettings.amplitude zFrequencyMin:generalSettings.frequencyMin zFrequencyMax:generalSettings.frequencyMax zFrequencyNormalized:generalSettings.frequencyNormalized];
    self.magnetometerGroup.xSynthesizer.muted = YES;
    self.magnetometerGroup.zSynthesizer.muted = YES;
    self.magnetometerGroup.ySynthesizer.muted = YES;
    [self.magnetometerGroup start];
    
}

-(void)setupMotionMonitor{
    self.motionMonitor = [[VWWMotionMonitor alloc]init];
    self.motionMonitor.delegate = self;
//    [self.motionMonitor startAccelerometer];
//    [self.motionMonitor startGyroscopes];
    [self.motionMonitor startMagnetometer];

}


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
        self.touchGroup.xSynthesizer.frequencyNormalized = x.floatValue;
        self.touchGroup.ySynthesizer.frequencyNormalized = y.floatValue;
    }

}

#pragma mark VWWTouchViewDelegate
-(void)touchViewDelegate:(VWWTouchView*)sender touchesBeganWithArray:(NSArray*)array{
    self.touchGroup.xSynthesizer.muted = NO;
    self.touchGroup.ySynthesizer.muted = NO;
    [self updateFrequenciesWithArray:array];
}

-(void)touchViewDelegate:(VWWTouchView*)sender touchesMovedWithArray:(NSArray*)array{
    [self updateFrequenciesWithArray:array];
}

-(void)touchViewDelegate:(VWWTouchView*)sender touchesEndedWithArray:(NSArray*)array{
    [self updateFrequenciesWithArray:array];
    self.touchGroup.xSynthesizer.muted = YES;
    self.touchGroup.ySynthesizer.muted = YES;
}



#pragma mark VWWMotionMonitorDelegate
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender accelerometerUpdated:(MotionDevice)device{
    self.accelerometerGroup.xSynthesizer.frequencyNormalized = device.x.currentNormalized;
    self.accelerometerGroup.ySynthesizer.frequencyNormalized = device.y.currentNormalized;
    
    static NSInteger counter = 0;
    
    if(counter % 10 == 0){
        VWW_LOG_INFO(@"\naccelerometer.x: %f"
                     @"\naccelerometer.y: %f"
                     @"\naccelerometer.z: %f",
                     device.x.currentNormalized,
                     device.y.currentNormalized,
                     device.z.currentNormalized);
    }
    
    counter++;
    
}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender magnetometerUpdated:(MotionDevice)device{
    self.accelerometerGroup.xSynthesizer.frequencyNormalized = device.x.currentNormalized;
    self.accelerometerGroup.ySynthesizer.frequencyNormalized = device.y.currentNormalized;
    
    static NSInteger counter = 0;
    
    if(counter % 10 == 0){
        VWW_LOG_INFO(@"\nmagnetometer: %f"
                     @"\nmagnetometer: %f"
                     @"\nmagnetometer: %f",
                     device.x.currentNormalized,
                     device.y.currentNormalized,
                     device.z.currentNormalized);
    }
    
    counter++;
}
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender gyroUpdated:(MotionDevice)device{
    self.accelerometerGroup.xSynthesizer.frequencyNormalized = device.x.currentNormalized;
    self.accelerometerGroup.ySynthesizer.frequencyNormalized = device.y.currentNormalized;
    
    static NSInteger counter = 0;
    
    if(counter % 10 == 0){
        VWW_LOG_INFO(@"\ngyroscope: %f"
                     @"\ngyroscope: %f"
                     @"\ngyroscope: %f",
                     device.x.currentNormalized,
                     device.y.currentNormalized,
                     device.z.currentNormalized);
    }
    
    counter++;
}






@end
