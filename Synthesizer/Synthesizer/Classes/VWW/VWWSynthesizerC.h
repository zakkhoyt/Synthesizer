//
//  VWWSynthesizerC.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 7/29/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#include "CAStreamBasicDescription.h"
#import "VWWSynthesizerTypes.h"

@interface VWWSynthesizerC : NSObject

@property float amplitude;
@property bool muted;


-(float)frequencyLeft;
-(void)setFrequencyLeft:(float)newFrequencyLeft;
-(float)frequencyRight;
-(void)setFrequencyRight:(float)newFrequencyRight;

@property VWWWaveType waveType;
@property VWWEffectType effectType;
@property double sinPhase;
@property double theta;
@property double theta2;
@property (readonly) bool isRunning;
@property VWWKeyType keyType;

-(id)initWithAmplitude:(float)amplitude frequencyLeft:(float)frequencyLeft frequencyRight:(float)frequencyRight;
- (void)start;
- (void)stop;
@end
