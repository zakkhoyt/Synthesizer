//
//  VWWSynthesizer.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWSynthesizerTypes.h"

@interface VWWSynthesizer : NSObject
@property float amplitude;
@property bool muted;
@property float frequency;
@property WaveType waveType;
@property EffectType effectType;
@property (readonly) double sinPhase;
@property (readonly) double theta;

/** Returns default instance with amplitude of 1.0 @440Hz 
 */
+(VWWSynthesizer*)sharedInstance;

/** Create a new instance
 * @param amplitude 0.0 .. 1.0
 * @param frequency in Hz
 */
-(id)initWithAmplitude:(float)amplitude andFrequency:(float)frequency;

/** Starts the synthesizer 
 */
- (void)start;

/** Stops the synthesizer 
 */
- (void)stop;

/** Return the amplitude 
 */
-(float)amplitude;
/** Set the amplitude
 * @param amplitude 0.0 .. 1.0
 */
-(void)setAmplitude:(float)amplitude;

-(bool)muted;
-(void)setMuted:(bool)muted;

-(float)frequency;
-(void)setFrequency:(float)frequency;

-(WaveType)waveType;
-(void)setWaveType:(WaveType)waveType;

-(EffectType)effectType;
-(void)setEffectType:(EffectType)effectType;

-(double)sinPhase;
-(double)theta;

@end
