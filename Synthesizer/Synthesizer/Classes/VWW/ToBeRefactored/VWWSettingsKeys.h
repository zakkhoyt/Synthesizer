//
//  VWWSettingsKeys.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 9/21/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#ifndef Theremin_VWWSettingsKeys_h
#define Theremin_VWWSettingsKeys_h

#import "VWWSynthesizerTypes.h"

typedef void (^VWWSynthesizerFrequencyBlock)(float frequencyMax, float frequencyMin);
typedef void (^VWWSynthesizerAmplitudeBlock)(float amplitude);
typedef void (^VWWSynthesizerSensitivityBlock)(float sensitivity);
typedef void (^VWWSynthesizerWaveformBlock)(VWWWaveType waveType);
typedef void (^VWWSynthesizerEffectBlock)(VWWEffectType effectType);


static NSString* kConfigFileName = @"theremin.cfg";

static NSString *kTouchScreenKey = @"Touch Screen";
static NSString *kAccelerometerKey = @"Accelerometer";
static NSString *kMagnetometerKey = @"Magnetometer";
static NSString *kGyroscopesKey = @"Gyrosscope";
static NSString *kGeneralKey = @"General Settings";


static NSString *kXAxisKey = @"X Axis";
static NSString *kYAxisKey = @"Y Axis";
static NSString *kZAxisKey = @"Z Axis";


static NSString *kFrequencyKey = @"Frequency";
static NSString *kAmplitudeKey = @"Amplitude";
static NSString *kWaveformKey = @"Waveform";
static NSString *kSensitivityKey = @"Sensitivity";
static NSString *kEffectKey = @"Effect";
static NSString *kKeyKey = @"Key";
#endif

