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


-(id)initWithXFrequencyLeftMin:(float)xFrequencyLeftMin xFrequencyLeftMax:(float)xFrequencyLeftMax xFrequencyLeftNormalized:(float)xFrequencyLeftNormalized
            xFrequencyRightMin:(float)xFrequencyRightMin xFrequencyRightMax:(float)xFrequencyRightMax xFrequencyRightNormalized:(float)xFrequencyRightNormalized
             yFrequencyLeftMin:(float)yFrequencyLeftMin yFrequencyLeftMax:(float)yFrequencyLeftMax yFrequencyLeftNormalized:(float)yFrequencyLeftNormalized
            yFrequencyRightMin:(float)yFrequencyRightMin yFrequencyRightMax:(float)yFrequencyRightMax yFrequencyRightNormalized:(float)yFrequencyRightNormalized
             zFrequencyLeftMin:(float)zFrequencyLeftMin zFrequencyLeftMax:(float)zFrequencyLeftMax zFrequencyLeftNormalized:(float)zFrequencyLeftNormalized
            zFrequencyRightMin:(float)zFrequencyRightMin zFrequencyRightMax:(float)zFrequencyRightMax zFrequencyRightNormalized:(float)zFrequencyRightNormalized;


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


/**
 * Return
 */
-(float)sensitivity;

/**
 * Set
 * @param
 */
-(void)setSensitivity:(float)sensitivity;

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

