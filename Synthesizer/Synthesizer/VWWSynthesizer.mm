//
//  VWWSynthesizer.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizer.h"
#import "VWWSynthesizerC.h"
#import "VWWSynthesizerKeys.h"

@interface VWWSynthesizer ()
@property (nonatomic, strong) VWWSynthesizerC *synthesizer;
@end

@implementation VWWSynthesizer

+(VWWSynthesizer*)sharedInstance{
    static VWWSynthesizer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VWWSynthesizer alloc]initWithAmplitude:1.0 frequencyLeft:440 frequencyRight:440];
    });
    return instance;
}


-(id)initWithAmplitude:(float)amplitude frequencyLeft:(float)frequencyLeft frequencyRight:(float)frequencyRight{
    self = [super init];
    if(self){
        _synthesizer = [[VWWSynthesizerC alloc]initWithAmplitude:amplitude frequencyLeft:frequencyLeft frequencyRight:frequencyRight];
    }
    return self;
}

- (void)start{
    [_synthesizer start];
}
- (void)stop{
    [_synthesizer stop];
}

-(bool)isRunning{
    @synchronized(self){
        return self.synthesizer.isRunning;
    }
}

-(void)setAmplitude:(float)amplitude{
    @synchronized(self){
        self.synthesizer.amplitude = amplitude;
    }
}
-(float)amplitude{
    @synchronized(self){
        return self.synthesizer.amplitude;
    }
}

-(void)setMuted:(bool)muted{
    @synchronized(self){
        self.synthesizer.muted = muted;
    }
}
-(bool)muted{
    @synchronized(self){
        return self.synthesizer.muted;
    }
}

-(void)setFrequencyLeft:(float)frequencyLeft{
    @synchronized(self){
        self.synthesizer.frequencyLeft = frequencyLeft;
    }
}
-(float)frequencyLeft{
    @synchronized(self){
        return self.synthesizer.frequencyLeft;
    }
}


-(void)setFrequencyRight:(float)frequencyRight{
    @synchronized(self){
        self.synthesizer.frequencyRight = frequencyRight;
    }
}
-(float)frequencyRight{
    @synchronized(self){
        return self.synthesizer.frequencyRight;
    }
}

-(void)setWaveType:(VWWWaveType)waveType{
    @synchronized(self){
        self.synthesizer.waveType = waveType;
    }
}
-(VWWWaveType)waveType{
    @synchronized(self){
        return self.synthesizer.waveType;
    }
}

-(void)setEffectType:(VWWEffectType)effectType{
    @synchronized(self){
        self.synthesizer.effectType = effectType;
    }
}
-(VWWEffectType)effectType{
    @synchronized(self){
        return self.synthesizer.effectType;
    }
}


-(void)setKeyType:(VWWKeyType)keyType{
    @synchronized(self){
        self.synthesizer.keyType = keyType;
    }
}

-(VWWKeyType)keyType{
    @synchronized(self){
        return self.synthesizer.keyType;
    }
}

-(double)sinPhase{
    @synchronized(self){
        return self.synthesizer.sinPhase;
    }
}

-(double)theta{
    @synchronized(self){
        return self.synthesizer.theta;
    }
}

@end

@implementation VWWSynthesizer (Dictionary)
-(id)initWithDictionary:(NSDictionary*)dictionary{
    self = [super init];
    if(self){
        NSNumber *amplitude = dictionary[VWWSynthesizerAmplitudeKey];
        NSNumber *frequencyLeft = dictionary[VWWSynthesizerFrequencyLeftKey];
        NSNumber *frequencyRight = dictionary[VWWSynthesizerFrequencyRightKey];
        
        self.synthesizer = [[VWWSynthesizerC alloc]initWithAmplitude:amplitude.floatValue frequencyLeft:frequencyLeft.floatValue frequencyRight:frequencyRight.floatValue];
        
        NSNumber *muted = dictionary[VWWSynthesizerMutedKey];
        self.synthesizer.muted = muted.integerValue == 0 ? NO : YES;
        
        NSNumber *waveType = dictionary[VWWSynthesizerWaveTypeKey];
        self.synthesizer.waveType = (VWWWaveType)waveType.integerValue;

        NSNumber *effectType = dictionary[VWWSynthesizerEffectTypeKey];
        self.synthesizer.effectType = (VWWEffectType)effectType.integerValue;
        
        NSNumber *keyType = dictionary[VWWSynthesizerKeyTypeKey];
        self.synthesizer.keyType = (VWWKeyType)keyType.integerValue;
        
        NSNumber *sinPhase = dictionary[VWWSynthesizerSinPhaseKey];
        self.synthesizer.sinPhase = sinPhase.doubleValue;
        
        NSNumber *theta = dictionary[VWWSynthesizerThetaKey];
        self.synthesizer.theta = theta.doubleValue;
        
        NSNumber *running = dictionary[VWWSynthesizerIsRunningKey];
        if(running.integerValue == 1){
            [self.synthesizer start];
        }
        
    }
    return self;
}

-(NSDictionary*)dictionaryRepresentation{
    NSDictionary *dictionary = @{VWWSynthesizerIsRunningKey : self.synthesizer.isRunning ? @(1) : @(0),
                                 VWWSynthesizerAmplitudeKey : @(self.synthesizer.amplitude),
                                 VWWSynthesizerMutedKey : self.synthesizer.muted ? @(1) : @(0),
                                 VWWSynthesizerFrequencyLeftKey : @(self.frequencyLeft),
                                 VWWSynthesizerWaveTypeKey : @(self.synthesizer.waveType),
                                 VWWSynthesizerEffectTypeKey : @(self.synthesizer.effectType),
                                 VWWSynthesizerKeyTypeKey : @(self.synthesizer.keyType),
                                 VWWSynthesizerSinPhaseKey : @(self.synthesizer.sinPhase),
                                 VWWSynthesizerThetaKey : @(self.synthesizer.theta)};
    return dictionary;
}

@end
