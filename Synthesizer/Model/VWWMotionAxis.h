//
//  VWWMotionAxis.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/21/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWMotionAxis : NSObject
@property (nonatomic) float min;
@property (nonatomic) float current;
@property (nonatomic) float currentNormalized;
@property (nonatomic) float max;
@property (nonatomic) float sensitivity;
@end
