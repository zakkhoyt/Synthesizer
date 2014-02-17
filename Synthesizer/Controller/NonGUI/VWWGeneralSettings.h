//
//  VWWGeneralSettings.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/17/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWGeneralSettings : NSObject
+(VWWGeneralSettings*)sharedInstance;

@property (nonatomic) float frequencyMax;
@property (nonatomic) float frequencyMin;
@property (nonatomic) float frequencyNormalized;
@property (nonatomic) float amplitude;
@end
