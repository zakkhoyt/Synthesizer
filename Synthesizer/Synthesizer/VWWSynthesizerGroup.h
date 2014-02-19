//
//  VWWSynthesizerGroup.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/10/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWNormalizedSynthesizer.h"



@interface VWWSynthesizerGroup : NSObject
@property (nonatomic, strong) VWWNormalizedSynthesizer *xSynthesizer;
@property (nonatomic, strong) VWWNormalizedSynthesizer *ySynthesizer;
@property (nonatomic, strong) VWWNormalizedSynthesizer *zSynthesizer;

-(id)initWithAmplitudeX:(float)amplitudeX xFrequencyMin:(float)xFrequencyMin xFrequencyMax:(float)xFrequencyMax xFrequencyNormalized:(float)xFrequencyNormalized
             amplitudeY:(float)amplitudeY yFrequencyMin:(float)yFrequencyMin yFrequencyMax:(float)yFrequencyMax yFrequencyNormalized:(float)yFrequencyNormalized
             amplitudeZ:(float)amplitudeZ zFrequencyMin:(float)zFrequencyMin zFrequencyMax:(float)zFrequencyMax zFrequencyNormalized:(float)zFrequencyNormalized;

/**
 * Starts all synthesizers in group
 */
- (void)start;

/**
 * Stops all synthesizers in group
 */
- (void)stop;

/**
 * All synthesizers in groups in synthesizer are running
 */
-(bool)isRunning;

/**
 * All synthesizers in group are muted
 */
-(bool)muted;

/**
 * Set muted for all synthesizers in group
 * @param muted if you don't want the tone to be audible
 */
-(void)setMuted:(bool)muted;

@end


@interface VWWSynthesizerGroup (Dictionary)
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

