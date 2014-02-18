//
//  VWWSynthesizersController.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/18/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWSynthesizerGroup.h"


@interface VWWSynthesizersController : NSObject

+(VWWSynthesizersController*)sharedInstance;

@property (nonatomic, strong) VWWSynthesizerGroup *touchscreenGroup;
@property (nonatomic, strong) VWWSynthesizerGroup *accelerometersGroup;
@property (nonatomic, strong) VWWSynthesizerGroup *gyroscopesGroup;
@property (nonatomic, strong) VWWSynthesizerGroup *magnetometersGroup;

@end
