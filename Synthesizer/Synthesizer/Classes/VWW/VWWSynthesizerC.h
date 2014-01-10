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

-(void)setFrequency:(float)newFrequency;
-(float)frequency;

@property VWWWaveType waveType;
@property VWWEffectType effectType;
@property double sinPhase;
@property double theta;
@property (readonly) bool isRunning;
@property VWWKeyType keyType;

-(id)initWithAmplitude:(float)amplitude andFrequency:(float)frequency;
- (void)start;
- (void)stop;
@end
