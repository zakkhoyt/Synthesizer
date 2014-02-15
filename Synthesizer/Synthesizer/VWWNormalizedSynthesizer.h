//
//  VWWNormalizedSynthesizer.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//  This class is just a wrapper around the C based VWWSynthesizerC.
//  It was written so that classes that use it will not have to have the .mm extension.

#import <Foundation/Foundation.h>
#import "VWWSynthesizerTypes.h"

@interface VWWNormalizedSynthesizer : NSObject

/**
 * Returns default instance with amplitude of 1.0 and a frequency of 440
 */
+(VWWNormalizedSynthesizer*)sharedInstance;

/**
 * Create a new instance
 * @param frequencyMin float from 30 - 20000
 * @param frequencyMax float from 30 - 20000
 * @param frequencyNormalized value from 0.0 - 1.0
 */
-(id)initWithAmplitude:(float)amplitude
          frequencyMin:(float)frequencyMin
          frequencyMax:(float)frequencyMax
   frequencyNormalized:(float)frequencyNormalized;

/**
 * Starts the synthesizer
 */
- (void)start;

/**
 * Stops the synthesizer
 */
- (void)stop;

/**
 * Return isRunning
 */
-(bool)isRunning;


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

///**
// * Return the frequency
// */
//-(float)frequency;
///**
// * Set the frequency in Hz
// * @param frequency typcially audible between 30 and 20000
// */
//-(void)setFrequency:(float)frequency;

@property float frequencyMin;
@property float frequencyMax;
@property float frequencyNormalized;


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
 * Return the keyType
 */
-(VWWKeyType)keyType;

/**
 * Set the key type
 * @param keyType such as chromatic, C Major, etc...
 */
-(void)setKeyType:(VWWKeyType)keyType;

/**
 * Return the sine phase
 */
-(double)sinPhase;


/**
 * Return the theta of the waveform
 */
-(double)theta;





@end


@interface VWWNormalizedSynthesizer (Dictionary)

/**
 * Create a new instance with a settings dictionary
 * @param dictionary an NSDictionary that was previously exported from this category
 */
-(id)initWithDictionary:(NSDictionary*)dictionary;

/**
 * Export synthesizer settings/state as an NSDiciontary. This can be written to NSUserDefaults or serialized as JSON for easy storage.
 * Pass into initWithDictionary to resume in current state.
 */
-(NSDictionary*)dictionaryRepresentation;

@end

