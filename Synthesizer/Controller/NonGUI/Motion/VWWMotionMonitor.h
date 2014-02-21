//
//  VWW_ThereminMotionMonitor.h
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>


@class VWWMotionAxis;
@class VWWMotionAxes;
@class VWWMotionMonitor;

@protocol VWWMotionMonitorDelegate <NSObject>
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender accelerometerUpdated:(VWWMotionAxes*)device;
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender magnetometerUpdated:(VWWMotionAxes*)device;
-(void)vwwMotionMonitor:(VWWMotionMonitor*)sender gyroUpdated:(VWWMotionAxes*)device;
@end

@interface VWWMotionMonitor : NSObject
@property (nonatomic, weak) id <VWWMotionMonitorDelegate> delegate;
-(void)startAccelerometer;
-(void)stopAccelerometer;
-(void)startMagnetometer;
-(void)stopMagnetometer;
-(void)startGyroscopes;
-(void)stopGyroscopes;
@end


