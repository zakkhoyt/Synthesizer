//
//  VWWSynthesizer.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizer.h"
#import "VWWSynthesizerC.h"

@interface VWWSynthesizer ()

@property (nonatomic, strong) VWWSynthesizerC *synthesizer;
@end

@implementation VWWSynthesizer

+(VWWSynthesizer*)sharedInstance{
    static VWWSynthesizer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VWWSynthesizer alloc]initWithAmplitude:1.0 andFrequency:440];
    });
    return instance;
}


-(id)initWithAmplitude:(float)amplitude andFrequency:(float)frequency{
    self = [super init];
    if(self){
        _synthesizer = [[VWWSynthesizerC alloc]initWithAmplitude:amplitude andFrequency:frequency];
    }
    return self;
}

- (void)start{
    [_synthesizer start];
}
- (void)stop{
    [_synthesizer stop];
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

-(void)setFrequency:(float)frequency{
    @synchronized(self){
        self.synthesizer.frequency = frequency;
    }
}
-(float)frequency{
    @synchronized(self){
        return self.synthesizer.frequency;
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
