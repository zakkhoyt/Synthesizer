//
//  VWWSynthesizer.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWSynthesizerTypes.h"

/**
 * This is the class you will use to create a single synthesizer and manage it's properties manually 
 */
@interface VWWSynthesizer : NSObject

/** 
 * Returns default instance with amplitude of 1.0 and a frequency of 440
 */
+(VWWSynthesizer*)sharedInstance;

/** 
 * Create a new instance
 * @param amplitude between 0.0 - 1.0
 * @param frequency in Hz between 30 - 20000
 */
-(id)initWithAmplitude:(float)amplitude andFrequency:(float)frequency;

/**
 * Starts the synthesizer
 */
- (void)start;

/**
 * Stops the synthesizer
 */
- (void)stop;

/**
 * Return the amplitude
 */
-(float)amplitude;

/**
 * Set the amplitude
 * @param amplitude Set the amplitude to a value from 0.0 - 1.0
 */
-(void)setAmplitude:(float)amplitude;

/**
 * Return muted
 */
-(bool)muted;
/**
 * Set muted
 * @param muted if you don't want the tone to be audible
 */

-(void)setMuted:(bool)muted;

/**
 * Return the frequency
 */
-(float)frequency;

/**
 * Set the frequency in Hz
 * @param frequency typcially audible between 30 and 20000
 */
-(void)setFrequency:(float)frequency;

/**
 * Return the waveType
 */
-(VWWWaveType)waveType;

/**
 * Set the wave type
 * @param waveType Sine, Square, Sawtooth, Triangle
 */
-(void)setWaveType:(VWWWaveType)waveType;

/**
 * Return the effectType
 */
-(VWWEffectType)effectType;

/**
 * Set the effect type
 * @param effectType such as AutoTune (snap to closest tone)
 */
-(void)setEffectType:(VWWEffectType)effectType;

/**
 * Return the sine phase
 */
-(double)sinPhase;

/**
 * Return the theta of the waveform
 */
-(double)theta;

@end
