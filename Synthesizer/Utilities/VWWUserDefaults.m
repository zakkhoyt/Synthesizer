//
//  VWWUserDefaults.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/17/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWUserDefaults.h"

static NSString *VWWUserDefaultsHasShownWelcomeScreenKey = @"has_shown_welcome_screen";
static NSString *VWWUserDefaultsTouchScreenKey = @"touch_screen";
static NSString *VWWUserDefaultsAccelerometersKey = @"accelerometers";
static NSString *VWWUserDefaultsGyroscopesKey = @"gyroscopes";
static NSString *VWWUserDefaultsMagnetometersKey = @"magnetometers";

//static NSString *VWWUserDefaultsKey = @"";
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


+(void)setTouchscreenSettings:(NSDictionary*)dictionary{
    [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:VWWUserDefaultsTouchScreenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSDictionary*)touchscreenSettings{
    return [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultsTouchScreenKey];
}

+(void)setAccelerometersSettings:(NSDictionary*)dictionary{
    [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:VWWUserDefaultsAccelerometersKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSDictionary*)accelerometersSettings{
    return [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultsAccelerometersKey];
}

+(void)setGyroscopesSettings:(NSDictionary*)dictionary{
    [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:VWWUserDefaultsGyroscopesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSDictionary*)gyroscopesSettings{
    return [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultsGyroscopesKey];
}

+(void)setMagnetometersSettings:(NSDictionary*)dictionary{
    [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:VWWUserDefaultsMagnetometersKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSDictionary*)magnetometersSettings{
    return [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultsMagnetometersKey];
}



+(void)setAccelerometersMinMaxValues:(NSDictionary*)minMaxValues{
    [[NSUserDefaults standardUserDefaults] setObject:minMaxValues forKey:VWWUserDefaultsAccelerometersMinMaxValuesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSDictionary*)accelerometersMinMaxValues{
    return [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultsAccelerometersMinMaxValuesKey];
}


+(void)setGyroscopesMinMaxValues:(NSDictionary*)minMaxValues{
    [[NSUserDefaults standardUserDefaults] setObject:minMaxValues forKey:VWWUserDefaultsGyroscopesMinMaxValuesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSDictionary*)gyroscopesMinMaxValues{
    return [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultsGyroscopesMinMaxValuesKey];
}

+(void)setMagnetometersMinMaxValues:(NSDictionary*)minMaxValues{
    [[NSUserDefaults standardUserDefaults] setObject:minMaxValues forKey:VWWUserDefaultsMagnetometersMinMaxValuesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSDictionary*)magnetometersMinMaxValues{
    return [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultsMagnetometersMinMaxValuesKey];
}
@end
