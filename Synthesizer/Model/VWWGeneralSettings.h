//
//  VWWGeneralSettings.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/17/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWGeneralSettings : NSObject
+(VWWGeneralSettings*)sharedInstance;

// Default settings
@property (nonatomic) float frequencyMax;
@property (nonatomic) float frequencyMin;
@property (nonatomic) float frequencyNormalized;
@property (nonatomic) float amplitude;


//// Stored settings for synthesizers


//{
//    "x_axis" =     {
//        amplitude = 1;
//        "effect_type" = 0;
//        "frequency_max" = 2000;
//        "frequency_min" = 20;
//        "frequency_normalized" = 1;
//        "is_running" = 1;
//        "key_type" = 0;
//        muted = 1;
//        "sin_phase" = 0;
//        theta = 0;
//        "wave_type" = 0;
//    };
//    "y_axis" =     {
//        amplitude = 1;
//        "effect_type" = 0;
//        "frequency_max" = 2000;
//        "frequency_min" = 20;
//        "frequency_normalized" = 1;
//        "is_running" = 1;
//        "key_type" = 0;
//        muted = 1;
//        "sin_phase" = 0;
//        theta = 0;
//        "wave_type" = 0;
//    };
//    "z_axis" =     {
//        amplitude = 1;
//        "effect_type" = 0;
//        "frequency_max" = 2000;
//        "frequency_min" = 20;
//        "frequency_normalized" = 1;
//        "is_running" = 1;
//        "key_type" = 0;
//        muted = 1;
//        "sin_phase" = 0;
//        theta = 0;
//        "wave_type" = 0;
//    };
//}

//{
//    "x_axis" =     {
//        amplitude = 1;
//        "effect_type" = 0;
//        "frequency_max" = 2000;
//        "frequency_min" = 20;
//        "frequency_normalized" = 1;
//        "is_running" = 1;
//        "key_type" = 0;
//        muted = 1;
//        "sin_phase" = 0;
//        theta = 0;
//        "wave_type" = 0;
//    };
//    "y_axis" =     {
//        amplitude = 1;
//        "effect_type" = 0;
//        "frequency_max" = 2000;
//        "frequency_min" = 20;
//        "frequency_normalized" = 1;
//        "is_running" = 1;
//        "key_type" = 0;
//        muted = 1;
//        "sin_phase" = 0;
//        theta = 0;
//        "wave_type" = 0;
//    };
//    "z_axis" =     {
//        amplitude = 1;
//        "effect_type" = 0;
//        "frequency_max" = 2000;
//        "frequency_min" = 20;
//        "frequency_normalized" = 1;
//        "is_running" = 1;
//        "key_type" = 0;
//        muted = 1;
//        "sin_phase" = 0;
//        theta = 0;
//        "wave_type" = 0;
//    };
//}
//
//{
//    "x_axis" =     {
//        amplitude = 1;
//        "effect_type" = 0;
//        "frequency_max" = 2000;
//        "frequency_min" = 20;
//        "frequency_normalized" = 1;
//        "is_running" = 1;
//        "key_type" = 0;
//        muted = 1;
//        "sin_phase" = 0;
//        theta = 0;
//        "wave_type" = 0;
//    };
//    "y_axis" =     {
//        amplitude = 1;
//        "effect_type" = 0;
//        "frequency_max" = 2000;
//        "frequency_min" = 20;
//        "frequency_normalized" = 1;
//        "is_running" = 1;
//        "key_type" = 0;
//        muted = 1;
//        "sin_phase" = 0;
//        theta = 0;
//        "wave_type" = 0;
//    };
//    "z_axis" =     {
//        amplitude = 1;
//        "effect_type" = 0;
//        "frequency_max" = 2000;
//        "frequency_min" = 20;
//        "frequency_normalized" = 1;
//        "is_running" = 1;
//        "key_type" = 0;
//        muted = 1;
//        "sin_phase" = 0;
//        theta = 0;
//        "wave_type" = 0;
//    };
//}



//// Stored settins for motion sensors
//
//Accel
//    x
//        min
//        max
//        sensitivity
//Gyro
//    x

@end
