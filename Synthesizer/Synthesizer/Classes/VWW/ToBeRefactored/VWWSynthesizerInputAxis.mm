//
//  VWWSynthesizerInputAxis.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizerInputAxis.h"
#import "VWWSynthesizer.h"
#import "VWWSynthesizerTypes.h"
#import "VWWSynthesizerDefaults.h"

// Keys for read/writing hash sets
static __attribute ((unused)) NSString* kKeyFMax = @"fmax";
static __attribute ((unused)) NSString* kKeyFMin = @"fmin";
static __attribute ((unused)) NSString* kKeyEffect = @"effect";
static __attribute ((unused)) NSString* kKeySensitivity = @"sensitivity";
static __attribute ((unused)) NSString* kKeyWaveType = @"wavetype";
static __attribute ((unused)) NSString* kKeySin = @"sin";
static __attribute ((unused)) NSString* kKeySquare = @"square";
static __attribute ((unused)) NSString* kKeyTriangle = @"triangle";
static __attribute ((unused)) NSString* kKeySawtooth = @"sawtooth";
static __attribute ((unused)) NSString* kKeyAutotune = @"autotune";
static __attribute ((unused)) NSString* kKeyLinearize = @"linearize";
static __attribute ((unused)) NSString* kKeyThrottle = @"throttle";
static __attribute ((unused)) NSString* kKeyAmplitude = @"amplitude";
static __attribute ((unused)) NSString* kKeyMuted = @"muted";
static __attribute ((unused)) NSString* kKeyNone = @"none";


@interface VWWSynthesizerInputAxis ()
@property (nonatomic, strong) VWWSynthesizer* synthesizer; 
@end

@implementation VWWSynthesizerInputAxis
-(id)init{
    self = [super init];
    if(self){
        _frequencyMax = VWW_FREQUENCY_MAX;
        _frequencyMin = VWW_FREQUENCY_MIN;
        _waveType = VWW_WAVETYPE;
        _sensitivity = VWW_SENSITIVITY;
        _effectType = VWW_EFFECT;
        _amplitude = VWW_AMPLITUDE;
        _muted = VWW_MUTED;

        _frequency = _frequencyMax;
        _synthesizer = [[VWWSynthesizer alloc]initWithAmplitude:_amplitude andFrequency:_frequency];
        [_synthesizer setWaveType:_waveType];
        _synthesizer.effectType = _effectType;
        _synthesizer.muted = _muted;
        [_synthesizer start];
    }
    return self;
}

-(void)stop{
    [self.synthesizer stop];
}
-(void)start{
    [self.synthesizer start];
}
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self){
        if(dictionary){
            NSNumber* fMaxNumber = dictionary[kKeyFMax];
            _frequencyMax = fMaxNumber.floatValue;
            NSNumber* fMinNumber = dictionary[kKeyFMin];
            _frequencyMin = fMinNumber.floatValue;
            NSString* effectString = dictionary[kKeyEffect];
            _effectType = [self effectFromString:effectString];
            NSNumber* sensitivityNumber = dictionary[kKeySensitivity];
            _sensitivity = sensitivityNumber.floatValue;
            NSString* wavetypeString = dictionary[kKeyWaveType];
            _waveType = [self  waveformFromString:wavetypeString];
            NSNumber* amplitudeNumber = dictionary[kKeyAmplitude];
            _amplitude = amplitudeNumber.floatValue;
            NSNumber* mutedNumber = dictionary[kKeyMuted];
            _muted = mutedNumber.floatValue > 0;
        }
        else{
            _frequencyMax = VWW_FREQUENCY_MAX;
            _frequencyMin = VWW_FREQUENCY_MIN;
            _waveType = VWW_WAVETYPE;
            _sensitivity = VWW_SENSITIVITY;
            _effectType = VWW_EFFECT;
            _amplitude = VWW_AMPLITUDE;
            _muted = VWW_MUTED;
        }
    
        _frequency = _frequencyMax;
        _synthesizer = [[VWWSynthesizer alloc]initWithAmplitude:_amplitude andFrequency:_frequency];
        _synthesizer.waveType = _waveType;
        _synthesizer.effectType = _effectType;
        _synthesizer.muted = _muted;
        [_synthesizer start];
    }
    return self;
}

-(NSDictionary*)jsonRepresentation{
    NSMutableDictionary* jsonDict = [NSMutableDictionary new];
    [jsonDict setValue:@(self.frequencyMax) forKey:kKeyFMax];
    [jsonDict setValue:@(self.frequencyMin) forKey:kKeyFMin];
    [jsonDict setValue:[self stringForEffect] forKey:kKeyEffect];
    [jsonDict setValue:@(self.sensitivity) forKey:kKeySensitivity];
    [jsonDict setValue:[self stringForWaveform] forKey:kKeyWaveType];
    [jsonDict setValue:@(self.amplitude) forKey:kKeyAmplitude];
    [jsonDict setValue:@(_muted ? 1 : 0) forKey:kKeyMuted];
    return jsonDict;
}

-(NSString*)stringForWaveform{
    switch (self.waveType) {
        case VWWWaveTypeSine:
            return kKeySin;
        case VWWWaveTypeSquare:
            return kKeySquare;
        case VWWWaveTypeTriangle:
            return kKeyTriangle;
        case VWWWaveTypeSawtooth:
            return kKeySawtooth;
        case VWWWaveTypeNone:
        default:
            return kKeyNone;
    }
}

-(VWWWaveType)waveformFromString:(NSString*)waveString{
    if([waveString isEqualToString:kKeySin]){
        return VWWWaveTypeSine;
    }
    else if([waveString isEqualToString:kKeySquare]){
        return VWWWaveTypeSquare;
    }
    else if([waveString isEqualToString:kKeyTriangle]){
        return VWWWaveTypeTriangle;
    }
    else if([waveString isEqualToString:kKeySawtooth]){
        return VWWWaveTypeSawtooth;
    }
    else /* if([waveString isEqualToString:kKeyNone]) */ {
        return VWWWaveTypeNone;
    }
}

-(NSString*)stringForEffect{
    switch(self.effectType){
        case VWWEffectTypeAutoTune:
            return kKeyAutotune;
        case VWWEffectTypeLinearize:
            return kKeyLinearize;
        case VWWEffectTypeThrottle:
            return kKeyThrottle;
        case VWWEffectTypeNone:
        default:
            return kKeyNone;
    }
}
-(VWWEffectType)effectFromString:(NSString*)effectString{
    if([effectString isEqualToString:kKeyAutotune]){
        return VWWEffectTypeAutoTune;
    }
    else if([effectString isEqualToString:kKeyLinearize]){
        return VWWEffectTypeLinearize;
    }
    else if([effectString isEqualToString:kKeyThrottle]){
        return VWWEffectTypeThrottle;
    }
    else /* if([effectString isEqualToString:kKeyNone]) */ {
        return VWWEffectTypeNone;
    }
}



-(void)setFrequency:(float)newFrequency{
    _frequency = newFrequency;
    self.synthesizer.frequency = _frequency;
}


-(void)setAmplitude:(float)newAmplitude{
    _amplitude = newAmplitude;
    self.synthesizer.amplitude = _amplitude;
}

-(void)setVWWEffectType:(VWWEffectType)newVWWEffectType{
    _effectType = newVWWEffectType;
    self.synthesizer.effectType = _effectType;
}

-(void)setVWWWaveType:(VWWWaveType)newWaveType{
    _waveType = newWaveType;
    self.synthesizer.waveType = _waveType;
}

-(void)setMuted:(bool)newMuted{
    _muted = newMuted;
    self.synthesizer.muted = _muted;
}
@end
