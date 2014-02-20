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

+(void)setAccelerometersMinMaxValues:(NSDictionary*)minMaxValues;
+(void)setGyroscopesMinMaxValues:(NSDictionary*)minMaxValues;
+(void)setMagnetometersMinMaxValues:(NSDictionary*)minMaxValues;


@end
