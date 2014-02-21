//
//  VWWUserDefaults.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/17/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWUserDefaults : NSObject
// Set the smile server URL
+(BOOL)hasShownWelcomeScreen;
+(void)setHasShownWelcomeScreen:(BOOL)hasShownWelcomeScreen;

+(void)setTouchscreenSettings:(NSDictionary*)dictionary;
+(NSDictionary*)touchscreenSettings;

+(void)setAccelerometersSettings:(NSDictionary*)dictionary;
+(NSDictionary*)accelerometersSettings;

+(void)setGyroscopesSettings:(NSDictionary*)dictionary;
+(NSDictionary*)gyroscopesSettings;

+(void)setMagnetometersSettings:(NSDictionary*)dictionary;
+(NSDictionary*)magnetometersSettings;


+(void)setAccelerometersMinMaxValues:(NSDictionary*)minMaxValues;
+(NSDictionary*)accelerometersMinMaxValues;

+(void)setGyroscopesMinMaxValues:(NSDictionary*)minMaxValues;
+(NSDictionary*)gyroscopesMinMaxValues;

+(void)setMagnetometersMinMaxValues:(NSDictionary*)minMaxValues;
+(NSDictionary*)magnetometersMinMaxValues;

@end
