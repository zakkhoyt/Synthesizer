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
    float _frequencyLeftNormalized;
    float _frequencyLeft;

    float _frequencyRightNormalized;
    float _frequencyRight;
}
@property (nonatomic, strong) VWWSynthesizerC *synthesizer;
@end

@implementation VWWNormalizedSynthesizer



+(VWWNormalizedSynthesizer*)sharedInstance{
    static VWWNormalizedSynthesizer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        instance = [[VWWNormalizedSynthesizer alloc]initWithFrequencyLeftMin:30 frequencyLeftMax:2000 frequencyLeftNormalized:0.3
                                                            frequencyRightMin:30 frequencyRightMax:2000 frequencyRightNormalized:0.3];
    });
    return instance;
}


-(id)initWithFrequencyLeftMin:(float)frequencyLeftMin frequencyLeftMax:(float)frequencyLeftMax frequencyLeftNormalized:(float)frequencyLeftNormalized
            frequencyRightMin:(float)frequencyRightMin frequencyRightMax:(float)frequencyRightMax frequencyRightNormalized:(float)frequencyRightNormalized{
    self = [super init];
    if(self){
        _frequencyLeftMin = frequencyLeftMin;
        _frequencyLeftMax = frequencyLeftMax;
        _frequencyLeftNormalized = frequencyLeftNormalized;
        _frequencyLeft = [self calculateFrequencyLeftNormalized];
        _frequencyRightMin = frequencyRightMin;
        _frequencyRightMax = frequencyRightMax;
        _frequencyRightNormalized = frequencyRightNormalized;
        _frequencyRight = [self calculateFrequencyRightNormalized];

        _synthesizer = [[VWWSynthesizerC alloc]initWithAmplitude:1.0 frequencyLeft:_frequencyLeft frequencyRight:_frequencyRight];
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

-(float)calculateFrequencyLeftNormalized{
    return ((_frequencyLeftMax - _frequencyLeftMin) * _frequencyLeftNormalized ) + _frequencyLeftMin;
}
-(void)setFrequencyLeftNormalized:(float)frequencyLeftNormalized{
    @synchronized(self){
        _frequencyLeftNormalized = frequencyLeftNormalized;
        _frequencyLeft = [self calculateFrequencyLeftNormalized];
        self.synthesizer.frequencyLeft = _frequencyLeft;
    }
}

-(float)frequencyLeftNormalized{
    @synchronized(self){
        return _frequencyLeftNormalized;
    }
}

-(float)calculateFrequencyRightNormalized{
    return ((_frequencyRightMax - _frequencyRightMin) * _frequencyRightNormalized ) + _frequencyRightMin;
}
-(void)setFrequencyRightNormalized:(float)frequencyRightNormalized{
    @synchronized(self){
        _frequencyRightNormalized = frequencyRightNormalized;
        _frequencyRight = [self calculateFrequencyRightNormalized];
        self.synthesizer.frequencyRight = _frequencyRight;
    }
}

-(float)frequencyRightNormalized{
    @synchronized(self){
        return _frequencyRightNormalized;
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
        
        NSNumber *frequencyLeftMin = dictionary[VWWSynthesizerFrequencyLeftMinKey];
        self.frequencyLeftMin = frequencyLeftMin.floatValue;
        NSNumber *frequencyLeftMax = dictionary[VWWSynthesizerFrequencyLeftMaxKey];
        self.frequencyLeftMax = frequencyLeftMax.floatValue;
        NSNumber *frequencyLeftNormalized = dictionary[VWWSynthesizerFrequencyLeftNormalizedKey];
        self.frequencyLeftNormalized = frequencyLeftNormalized.floatValue;
        float frequencyLeft = [self calculateFrequencyLeftNormalized];

        NSNumber *frequencyRightMin = dictionary[VWWSynthesizerFrequencyRightMinKey];
        self.frequencyRightMin = frequencyRightMin.floatValue;
        NSNumber *frequencyRightMax = dictionary[VWWSynthesizerFrequencyRightMaxKey];
        self.frequencyRightMax = frequencyRightMax.floatValue;
        NSNumber *frequencyRightNormalized = dictionary[VWWSynthesizerFrequencyRightNormalizedKey];
        self.frequencyRightNormalized = frequencyRightNormalized.floatValue;
        float frequencyRight = [self calculateFrequencyRightNormalized];

        
        self.synthesizer = [[VWWSynthesizerC alloc]initWithAmplitude:amplitude.floatValue frequencyLeft:frequencyLeft frequencyRight:frequencyRight];
        
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
                                 VWWSynthesizerFrequencyLeftMinKey : @(self.frequencyLeftMin),
                                 VWWSynthesizerFrequencyLeftMaxKey : @(self.frequencyLeftMax),
                                 VWWSynthesizerFrequencyLeftNormalizedKey : @(self.frequencyLeftNormalized),
                                 VWWSynthesizerFrequencyRightMinKey : @(self.frequencyRightMin),
                                 VWWSynthesizerFrequencyRightMaxKey : @(self.frequencyRightMax),
                                 VWWSynthesizerFrequencyRightNormalizedKey : @(self.frequencyRightNormalized),

                                 VWWSynthesizerWaveTypeKey : @(self.synthesizer.waveType),
                                 VWWSynthesizerEffectTypeKey : @(self.synthesizer.effectType),
                                 VWWSynthesizerKeyTypeKey : @(self.synthesizer.keyType),
                                 VWWSynthesizerSinPhaseKey : @(self.synthesizer.sinPhase),
                                 VWWSynthesizerThetaKey : @(self.synthesizer.theta)};
    return dictionary;
}

@end
