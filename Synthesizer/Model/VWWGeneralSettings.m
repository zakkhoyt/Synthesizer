//
//  VWWGeneralSettings.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/17/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWGeneralSettings.h"
#import "VWWSynthesizerKeys.h"

const float VWWGeneralSettingsFrequencyMin = 20.0;
const float VWWGeneralSettingsFrequencyMax = 2000.0;
const float VWWGeneralSettingsFrequencyNormalized = 1.0;
const float VWWGeneralSettingsAmplitude = 1.0;

@implementation VWWGeneralSettings
+(VWWGeneralSettings*)sharedInstance{
    static VWWGeneralSettings *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = self.new;
    });
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
        self.frequencyMin = VWWGeneralSettingsFrequencyMin;
        self.frequencyMax = VWWGeneralSettingsFrequencyMax;
        self.frequencyNormalized = VWWGeneralSettingsFrequencyNormalized;
        self.amplitude = VWWGeneralSettingsAmplitude;
    }
    return self;
}


-(id)initWithDictionary:(NSDictionary*)dictionary{
    VWW_LOG_TODO_TASK(@"Write unit test");
    self = [super init];
    if(self){
        NSNumber *frequencyMin = dictionary[VWWGeneralSettingsFrequencyMinKey];
        self.frequencyMin = frequencyMin.floatValue;
        
        NSNumber *frequencyMax = dictionary[VWWGeneralSettingsFrequencyMaxKey];
        self.frequencyMax = frequencyMax.floatValue;
        
        NSNumber *frequencyNormalized = dictionary[VWWGeneralSettingsFrequencyNormalizedKey];
        self.frequencyNormalized = frequencyNormalized.floatValue;
        
        NSNumber *amplitude = dictionary[VWWGeneralSettingsAmplitudeKey];
        self.amplitude = amplitude.floatValue;
        
    }
    return self;
}

-(NSDictionary*)dictionaryRepresentation{
    VWW_LOG_TODO_TASK(@"Write unit test");
    NSDictionary *dictionary = @{VWWGeneralSettingsFrequencyMinKey : @(self.frequencyMin),
                                 VWWGeneralSettingsFrequencyMaxKey : @(self.frequencyMax),
                                 VWWGeneralSettingsFrequencyNormalizedKey : @(self.frequencyNormalized),
                                 VWWGeneralSettingsAmplitudeKey : @(self.amplitude)};
    return dictionary;
}




@end
