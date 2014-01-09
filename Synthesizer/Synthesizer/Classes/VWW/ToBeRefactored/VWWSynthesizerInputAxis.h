//
//  VWWSynthesizerInputAxis.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "VWWSynthesizerTypes.h"

@interface VWWSynthesizerInputAxis : NSObject
@property (nonatomic) float amplitude;
@property (nonatomic) float frequencyMax;
@property (nonatomic) float frequencyMin;
@property (nonatomic) VWWWaveType waveType;
@property (nonatomic) float sensitivity;
@property (nonatomic) VWWEffectType effectType;
@property (nonatomic) float frequency;
@property (nonatomic) bool muted;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary*)jsonRepresentation;
-(void)stop;
-(void)start;
@end
