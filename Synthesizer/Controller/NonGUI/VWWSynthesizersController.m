//
//  VWWSynthesizersController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/18/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizersController.h"
#import "VWWGeneralSettings.h"
#import "VWWMotionMonitor.h"


@interface VWWSynthesizersController () <VWWMotionMonitorDelegate>
@property (nonatomic, strong) VWWMotionMonitor *motionMonitor;
@end


@implementation VWWSynthesizersController
+(VWWSynthesizersController*)sharedInstance{
    static VWWSynthesizersController *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
        [self setupSynthesizers];
        [self setupMotionMonitor];
    }
    return self;
}



#pragma mark Private methods

-(void)setupSynthesizers{
    // We will create 11 synthesizers here:
    // 2 for the touchscreen (x, y)
    // 3 for the accelerometers (x, y, z)
    // 3 for the gyroscopes (x, y, z)
    // 3 for the magnetometers (x, y, z)
    // Each group will be initialized with the default settings (stored in NSUserDefaults), all axis muted, then started.
    // All that is required for each to make noise is to unmute an axis
    
    // Touchscreeen
    VWWGeneralSettings *generalSettings = [VWWGeneralSettings sharedInstance];
    self.touchscreenGroup = [[VWWSynthesizerGroup alloc]initWithAmplitudeX:generalSettings.amplitude xFrequencyMin:generalSettings.frequencyMin xFrequencyMax:generalSettings.frequencyMax xFrequencyNormalized:generalSettings.frequencyNormalized
                                                                amplitudeY:generalSettings.amplitude yFrequencyMin:generalSettings.frequencyMin yFrequencyMax:generalSettings.frequencyMax yFrequencyNormalized:generalSettings.frequencyNormalized
                                                                amplitudeZ:generalSettings.amplitude zFrequencyMin:generalSettings.frequencyMin zFrequencyMax:generalSettings.frequencyMax zFrequencyNormalized:generalSettings.frequencyNormalized];
    self.touchscreenGroup.muted = YES;
    [self.touchscreenGroup start];
    
    // Accelerometers
    self.accelerometersGroup = [[VWWSynthesizerGroup alloc]initWithAmplitudeX:generalSettings.amplitude xFrequencyMin:generalSettings.frequencyMin xFrequencyMax:generalSettings.frequencyMax xFrequencyNormalized:generalSettings.frequencyNormalized
                                                                   amplitudeY:generalSettings.amplitude yFrequencyMin:generalSettings.frequencyMin yFrequencyMax:generalSettings.frequencyMax yFrequencyNormalized:generalSettings.frequencyNormalized
                                                                   amplitudeZ:generalSettings.amplitude zFrequencyMin:generalSettings.frequencyMin zFrequencyMax:generalSettings.frequencyMax zFrequencyNormalized:generalSettings.frequencyNormalized];
    self.accelerometersGroup.muted = YES;
    [self.accelerometersGroup start];
    
    // Gyroscopes
    self.gyroscopesGroup = [[VWWSynthesizerGroup alloc]initWithAmplitudeX:generalSettings.amplitude xFrequencyMin:generalSettings.frequencyMin xFrequencyMax:generalSettings.frequencyMax xFrequencyNormalized:generalSettings.frequencyNormalized
                                                               amplitudeY:generalSettings.amplitude yFrequencyMin:generalSettings.frequencyMin yFrequencyMax:generalSettings.frequencyMax yFrequencyNormalized:generalSettings.frequencyNormalized
                                                               amplitudeZ:generalSettings.amplitude zFrequencyMin:generalSettings.frequencyMin zFrequencyMax:generalSettings.frequencyMax zFrequencyNormalized:generalSettings.frequencyNormalized];
    self.gyroscopesGroup.muted = YES;
    [self.gyroscopesGroup start];
    
    
    // Magnetometers
    self.magnetometersGroup = [[VWWSynthesizerGroup alloc]initWithAmplitudeX:generalSettings.amplitude xFrequencyMin:generalSettings.frequencyMin xFrequencyMax:generalSettings.frequencyMax xFrequencyNormalized:generalSettings.frequencyNormalized
                                                                  amplitudeY:generalSettings.amplitude yFrequencyMin:generalSettings.frequencyMin yFrequencyMax:generalSettings.frequencyMax yFrequencyNormalized:generalSettings.frequencyNormalized
                                                                  amplitudeZ:generalSettings.amplitude zFrequencyMin:generalSettings.frequencyMin zFrequencyMax:generalSettings.frequencyMax zFrequencyNormalized:generalSettings.frequencyNormalized];
    self.magnetometersGroup.muted = YES;
    [self.magnetometersGroup start];
}


-(void)setupMotionMonitor{
    self.motionMonitor = [[VWWMotionMonitor alloc]init];
    self.motionMonitor.delegate = self;
    [self.motionMonitor startAccelerometer];
    //    [self.motionMonitor startGyroscopes];
    //    [self.motionMonitor startMagnetometer];
    
}


#pragma mark VWWMotionMonitorDelegate
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender accelerometerUpdated:(MotionDevice)device{
    self.accelerometersGroup.xSynthesizer.frequencyNormalized = device.x.currentNormalized;
    self.accelerometersGroup.ySynthesizer.frequencyNormalized = device.y.currentNormalized;
    
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
    self.accelerometersGroup.xSynthesizer.frequencyNormalized = device.x.currentNormalized;
    self.accelerometersGroup.ySynthesizer.frequencyNormalized = device.y.currentNormalized;
    
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
    self.accelerometersGroup.xSynthesizer.frequencyNormalized = device.x.currentNormalized;
    self.accelerometersGroup.ySynthesizer.frequencyNormalized = device.y.currentNormalized;
    
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
