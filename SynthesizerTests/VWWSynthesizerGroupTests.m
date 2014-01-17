//
//  VWWSynthesizerGroupTests.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/10/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VWWSynthesizerGroup.h"

@interface VWWSynthesizerGroupTests : XCTestCase

@end

@implementation VWWSynthesizerGroupTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testInitAndRun{
    float x = 0.3, y = 0.3, z = 0.3;
//    VWWSynthesizerGroup *group = [[VWWSynthesizerGroup alloc]initWithXFrequencyMin:20 xFrequencyMax:200 xFrequencyNormalized:x
//                                                                     yFrequencyMin:500 yFrequencyMax:3000 yFrequencyNormalized:y
//                                                                     zFrequencyMin:3000 zFrequencyMax:10000 zFrequencyNormalized:z];
    
    VWWSynthesizerGroup *group = [[VWWSynthesizerGroup alloc]initWithXFrequencyLeftMin:20 xFrequencyLeftMax:200 xFrequencyLeftNormalized:x
                                                                    xFrequencyRightMin:20 xFrequencyRightMax:200 xFrequencyRightNormalized:x
                                                                     yFrequencyLeftMin:500 yFrequencyLeftMax:3000 yFrequencyLeftNormalized:y
                                                                    yFrequencyRightMin:500 yFrequencyRightMax:3000 yFrequencyRightNormalized:y
                                                                     zFrequencyLeftMin:3000 zFrequencyLeftMax:10000 zFrequencyLeftNormalized:z
                                                                    zFrequencyRightMin:3000 zFrequencyRightMax:10000 zFrequencyRightNormalized:z];

    
    [group start];
    
    for(NSInteger i = 0; i < 1000; i++){
        x += 0.01;
        y += 0.02;
        z += 0.03;
        if(x > 1.0) x = 0.0;
        if(y > 1.0) y = 0.0;
        if(z > 1.0) z = 0.0;
        group.xSynthesizer.frequencyLeftNormalized = x;
        group.xSynthesizer.frequencyRightNormalized = x;
        group.ySynthesizer.frequencyLeftNormalized = y;
        group.ySynthesizer.frequencyRightNormalized = y;
        group.zSynthesizer.frequencyLeftNormalized = z;
        group.zSynthesizer.frequencyRightNormalized = z;
        usleep(10 * 1000);
    }
    
    
    
    usleep(1 * 1000 * 1000);
    
}

@end
