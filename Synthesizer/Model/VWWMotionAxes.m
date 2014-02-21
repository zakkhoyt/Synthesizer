//
//  VWWMotionAxes.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/21/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWMotionAxes.h"
#import "VWWMotionAxis.h"
@implementation VWWMotionAxes

-(id)init{
    self = [super init];
    if(self){
        _x = [[VWWMotionAxis alloc]init];
        _y = [[VWWMotionAxis alloc]init];
        _z = [[VWWMotionAxis alloc]init];
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary*)dictionary{
    self = [super init];
    if(self){
        
    }
    return self;
}
@end
