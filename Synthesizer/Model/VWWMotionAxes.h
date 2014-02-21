//
//  VWWMotionAxes.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/21/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWMotionAxis.h"

@interface VWWMotionAxes : NSObject
@property (nonatomic, strong) VWWMotionAxis *x;
@property (nonatomic, strong) VWWMotionAxis *y;
@property (nonatomic, strong) VWWMotionAxis *z;
@end
