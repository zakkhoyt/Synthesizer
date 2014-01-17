//
//  VWWSynthesizerKeys.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#ifndef Synthesizer_VWWSynthesizerKeys_h
#define Synthesizer_VWWSynthesizerKeys_h

// For VWWSynthesizer
static NSString *VWWSynthesizerIsRunningKey = @"is_running";
static NSString *VWWSynthesizerAmplitudeKey = @"amplitude";
static NSString *VWWSynthesizerMutedKey = @"muted";
static NSString *VWWSynthesizerFrequencyLeftKey = @"frequency_left";
static NSString *VWWSynthesizerFrequencyRightKey = @"frequency_right";
static NSString *VWWSynthesizerWaveTypeKey = @"wave_type";
static NSString *VWWSynthesizerEffectTypeKey = @"effect_type";
static NSString *VWWSynthesizerKeyTypeKey = @"key_type";
static NSString *VWWSynthesizerSinPhaseKey = @"sin_phase";
static NSString *VWWSynthesizerThetaKey = @"theta";

// For VWWNormalizedSynthesizer
static NSString *VWWSynthesizerFrequencyLeftMinKey = @"frequency_min_left";
static NSString *VWWSynthesizerFrequencyLeftMaxKey = @"frequency_max_left";
static NSString *VWWSynthesizerFrequencyLeftNormalizedKey = @"frequency_normalized_left";
static NSString *VWWSynthesizerFrequencyRightMinKey = @"frequency_min_right";
static NSString *VWWSynthesizerFrequencyRightMaxKey = @"frequency_max_right";
static NSString *VWWSynthesizerFrequencyRightNormalizedKey = @"frequency_normalized_right";

// For VWWSynthesizerGroup
static NSString *VWWSynthesizerGroupTouchScreenKey = @"touch_screen";
static NSString *VWWSynthesizerGroupAccelerometerKey = @"accelerometer";
static NSString *VWWSynthesizerGroupMagnetometerKey = @"magnetometer";
static NSString *VWWSynthesizerGroupGyroscopesKey = @"gyroscope";
static NSString *VWWSynthesizerGroupXAxisKey = @"x_axis";
static NSString *VWWSynthesizerGroupYAxisKey = @"y_axis";
static NSString *VWWSynthesizerGroupZAxisKey = @"z_axis";
#endif
