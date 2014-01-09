//
//  VWWSynthesizerInputs.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWSynthesizerInput.h"


// TODO: These are defined elsewhere in the app.
// We really don't want two instances 
static __attribute ((unused)) NSString* kKeyAccelerometer = @"accelerometer";
static __attribute ((unused)) NSString* kKeyGyroscope = @"gyroscope";
static __attribute ((unused)) NSString* kKeyMagnetometer = @"magnetometer";
static __attribute ((unused)) NSString* kKeyTouchScreen = @"touchscreen";

@interface VWWSynthesizerInputs : NSObject
+(VWWSynthesizerInputs *)sharedInstance;
+(VWWSynthesizerInput*)accelerometerInput;
+(VWWSynthesizerInput*)gyroscopeInput;
+(VWWSynthesizerInput*)magnetometerInput;
+(VWWSynthesizerInput*)touchscreenInput;
+(void)resetConfigAndSave;
+(void)saveConfigFile;
@end
