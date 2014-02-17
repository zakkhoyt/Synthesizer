//
//  VWWSynthesizerKeys.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#ifndef Synthesizer_VWWSynthesizerKeys_h
#define Synthesizer_VWWSynthesizerKeys_h

// For VWWGeneralSettings
static NSString *VWWGeneralSettingsFrequencyMaxKey = @"general_frequency_max";
static NSString *VWWGeneralSettingsFrequencyMinKey = @"general_frequency_min";
static NSString *VWWGeneralSettingsFrequencyNormalizedKey = @"general_frequency_normalized";
static NSString *VWWGeneralSettingsAmplitudeKey = @"general_amplitude";



// For VWWSynthesizer
static NSString *VWWSynthesizerIsRunningKey = @"is_running";
static NSString *VWWSynthesizerAmplitudeKey = @"amplitude";
static NSString *VWWSynthesizerMutedKey = @"muted";
static NSString *VWWSynthesizerFrequencyKey = @"frequency";
static NSString *VWWSynthesizerWaveTypeKey = @"wave_type";
static NSString *VWWSynthesizerEffectTypeKey = @"effect_type";
static NSString *VWWSynthesizerKeyTypeKey = @"key_type";
static NSString *VWWSynthesizerSinPhaseKey = @"sin_phase";
static NSString *VWWSynthesizerThetaKey = @"theta";

// For VWWNormalizedSynthesizer
static NSString *VWWSynthesizerFrequencyMinKey = @"frequency_min";
static NSString *VWWSynthesizerFrequencyMaxKey = @"frequency_max";
static NSString *VWWSynthesizerFrequencyNormalizedKey = @"frequency_normalized";

// For VWWSynthesizerGroup
static NSString *VWWSynthesizerGroupTouchScreenKey = @"touch_screen";
static NSString *VWWSynthesizerGroupAccelerometerKey = @"accelerometer";
static NSString *VWWSynthesizerGroupMagnetometerKey = @"magnetometer";
static NSString *VWWSynthesizerGroupGyroscopesKey = @"gyroscope";
static NSString *VWWSynthesizerGroupXAxisKey = @"x_axis";
static NSString *VWWSynthesizerGroupYAxisKey = @"y_axis";
static NSString *VWWSynthesizerGroupZAxisKey = @"z_axis";
#endif
