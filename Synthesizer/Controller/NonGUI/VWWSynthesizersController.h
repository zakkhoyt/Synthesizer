//
//  VWWSynthesizersController.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/18/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWSynthesizerGroup.h"


static NSString *VWWSynthesizersControllerAccelerometersStatisticsString = @"accelerometersStatisticsString";
static NSString *VWWSynthesizersControllerGyroscopesStatisticsString = @"gyroscopesStatisticsString";
static NSString *VWWSynthesizersControllerMagnetoometersStatisticsString = @"magnetometersStatisticsString";

@interface VWWSynthesizersController : NSObject

+(VWWSynthesizersController*)sharedInstance;

@property (nonatomic, strong) VWWSynthesizerGroup *touchscreenGroup;
@property (nonatomic, strong) VWWSynthesizerGroup *accelerometersGroup;
@property (nonatomic, strong) VWWSynthesizerGroup *gyroscopesGroup;
@property (nonatomic, strong) VWWSynthesizerGroup *magnetometersGroup;
@property (nonatomic, strong, readonly) NSString *accelerometersStatisticsString;
@property (nonatomic, strong, readonly) NSString *gyroscopesStatisticsString;
@property (nonatomic, strong, readonly) NSString *magnetometersStatisticsString;
@end
