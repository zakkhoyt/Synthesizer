//
//  VWWNormalizedSynthesizer.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWNormalizedSynthesizer.h"
#import "VWWSynthesizerC.h"
#import "VWWSynthesizerKeys.h"


@interface VWWNormalizedSynthesizer (){
    float _frequencyNormalized;
    float _frequency;
}
@property (nonatomic, strong) VWWSynthesizerC *synthesizer;
@end

@implementation VWWNormalizedSynthesizer



+(VWWNormalizedSynthesizer*)sharedInstance{
    static VWWNormalizedSynthesizer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VWWNormalizedSynthesizer alloc]initWithAmplitude:1.0
                                                         frequencyMin:30
                                                         frequencyMax:2000
                                                  frequencyNormalized:0.3];
    });
    return instance;
}


-(id)initWithAmplitude:(float)amplitude
          frequencyMin:(float)frequencyMin
          frequencyMax:(float)frequencyMax
   frequencyNormalized:(float)frequencyNormalized{

    self = [super init];
    if(self){
        _frequencyMin = frequencyMin;
        _frequencyMax = frequencyMax;
        _frequencyNormalized = frequencyNormalized;
        _frequency = [self calculateFrequencyNormalized];

        _synthesizer = [[VWWSynthesizerC alloc]initWithAmplitude:amplitude andFrequency:_frequency];
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

-(float)calculateFrequencyNormalized{
    return ((_frequencyMax - _frequencyMin) * _frequencyNormalized ) + _frequencyMin;
}
-(void)setFrequencyNormalized:(float)frequencyNormalized{
    @synchronized(self){
        _frequencyNormalized = frequencyNormalized;
        _frequency = [self calculateFrequencyNormalized];
        self.synthesizer.frequency = _frequency;
    }
}

-(float)frequencyNormalized{
    @synchronized(self){
        return _frequencyNormalized;
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

@implementation VWWNormalizedSynthesizer (Dictionary)
-(id)initWithDictionary:(NSDictionary*)dictionary{
    self = [super init];
    if(self){
        NSNumber *amplitude = dictionary[VWWSynthesizerAmplitudeKey];
        NSNumber *frequencyMin = dictionary[VWWSynthesizerFrequencyMinKey];
        self.frequencyMin = frequencyMin.floatValue;
        NSNumber *frequencyMax = dictionary[VWWSynthesizerFrequencyMaxKey];
        self.frequencyMax = frequencyMax.floatValue;
        NSNumber *frequencyNormalized = dictionary[VWWSynthesizerFrequencyNormalizedKey];
        self.frequencyNormalized = frequencyNormalized.floatValue;
        float frequency = [self calculateFrequencyNormalized];

        
        self.synthesizer = [[VWWSynthesizerC alloc]initWithAmplitude:amplitude.floatValue andFrequency:frequency];
        
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
                                 VWWSynthesizerFrequencyMinKey : @(self.frequencyMin),
                                 VWWSynthesizerFrequencyMaxKey : @(self.frequencyMax),
                                 VWWSynthesizerFrequencyNormalizedKey : @(self.frequencyNormalized),
                                 VWWSynthesizerWaveTypeKey : @(self.synthesizer.waveType),
                                 VWWSynthesizerEffectTypeKey : @(self.synthesizer.effectType),
                                 VWWSynthesizerKeyTypeKey : @(self.synthesizer.keyType),
                                 VWWSynthesizerSinPhaseKey : @(self.synthesizer.sinPhase),
                                 VWWSynthesizerThetaKey : @(self.synthesizer.theta)};
    return dictionary;
}

@end
