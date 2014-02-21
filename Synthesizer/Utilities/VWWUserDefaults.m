//
//  VWWUserDefaults.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/17/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWUserDefaults.h"

static NSString *VWWUserDefaultsHasShownWelcomeScreenKey = @"has_shown_welcome_screen";
static NSString *VWWUserDefaultsAccelerometersMinMaxValuesKey = @"accelerometer_min_max_values";
static NSString *VWWUserDefaultsGyroscopesMinMaxValuesKey = @"gyroscopes_min_max_values";
static NSString *VWWUserDefaultsMagnetometersMinMaxValuesKey = @"magnetometers_min_max_values";
@implementation VWWUserDefaults


+(BOOL)hasShownWelcomeScreen{
    return [[NSUserDefaults standardUserDefaults] boolForKey:VWWUserDefaultsHasShownWelcomeScreenKey];
}
+(void)setHasShownWelcomeScreen:(BOOL)hasShownWelcomeScreen{
    [[NSUserDefaults standardUserDefaults] setBool:hasShownWelcomeScreen forKey:VWWUserDefaultsHasShownWelcomeScreenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+(void)setAccelerometersMinMaxValues:(NSDictionary*)minMaxValues{
    
}
+(void)setGyroscopesMinMaxValues:(NSDictionary*)minMaxValues{
    
}
+(void)setMagnetometersMinMaxValues:(NSDictionary*)minMaxValues{
    
}

@end
