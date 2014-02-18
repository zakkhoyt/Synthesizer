//
//  VWWSynthesizersController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/18/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizersController.h"
#import "VWWGeneralSettings.h"

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
    return self;
}


@end
