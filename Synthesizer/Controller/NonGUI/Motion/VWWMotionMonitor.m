//
//  VWWMotionMonitor.m
//  Theremin
//
//  Created by Zakk Hoyt on 7/31/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
#import <CoreMotion/CoreMotion.h>
#import "VWWMotionMonitor.h"
//#import "VWWThereminInputs.h"

const float kSensitivityOffset = 2.0;

const float kAccelerometerXMax = 2.0;
const float kAccelerometerYMax = 2.0;
const float kAccelerometerZMax = 2.0;

const float kGyroXMax = 20.0;
const float kGyroYMax = 20.0;
const float kGyroZMax = 20.0;

//const float kMagnetometerXMax = 80.0f;
//const float kMagnetometerYMax = 30.0f;
//const float kMagnetometerZMax = 30.0f;

const float kMagnetometerXMax = 300.0f;
const float kMagnetometerYMax = 300.0f;
const float kMagnetometerZMax = 300.0f;



@interface VWWMotionMonitor ()
@property (nonatomic, strong) CMMotionManager* motion;
//@property Devices devices;
@property MotionDevice accelerometers;
@property MotionDevice gyroroscopes;
@property MotionDevice magnetometers;

@property (nonatomic) bool accelerometerRunning;
@property (nonatomic) bool magnetometerRunning;
@property (nonatomic) bool gyrosRunning;
@end

@implementation VWWMotionMonitor

-(id)init{
    self = [super init];
    if(self){
        _accelerometerRunning = NO;
        _magnetometerRunning = NO;
        _gyrosRunning = NO;

        memset(&_accelerometers, 0, sizeof(MotionDevice));
        memset(&_gyroroscopes, 0, sizeof(MotionDevice));
        memset(&_magnetometers, 0, sizeof(MotionDevice));
        self.motion = [[CMMotionManager alloc]init];
        
    }
    return self;
}

-(void)startAccelerometer{
    if(self.accelerometerRunning == YES) return;
    self.motion.accelerometerUpdateInterval = 1/300.0f;
    NSOperationQueue* accelerometerQueue = [[NSOperationQueue alloc] init];
    [self.motion startAccelerometerUpdatesToQueue:accelerometerQueue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        
        // X Axis
        // Accelerometer value is currently in the range of
        // (-kAccelerometerXMax .. kAccelerometerXMax)
        // Convert to value in range
        // (0 .. 2*kAccelerometerXMax)
        float value = accelerometerData.acceleration.x + kAccelerometerXMax;
        // then range
        // (0.0 .. 1.0)
        float normalize = (float)2.0*kAccelerometerXMax;
        value /= normalize;
        // Clip
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        // Set _device values
        _accelerometers.x.current = accelerometerData.acceleration.x;
        _accelerometers.x.currentNormalized = value;
        
        
        // Y Axis
        value = accelerometerData.acceleration.y + kAccelerometerYMax;
        normalize = (float)2.0*kAccelerometerYMax;
        value /= normalize;
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        _accelerometers.y.current = accelerometerData.acceleration.y;
        _accelerometers.y.currentNormalized = value;
        
        // Z Axis
        value = accelerometerData.acceleration.z + kAccelerometerZMax;
        normalize = (float)2.0*kAccelerometerZMax;
        value /= normalize;
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        _accelerometers.z.current = accelerometerData.acceleration.z;
        _accelerometers.z.currentNormalized = value;
        
        
        
        // Set device min and max values
        if(accelerometerData.acceleration.x < _accelerometers.x.min){
            _accelerometers.x.min = accelerometerData.acceleration.x;
        }
        if(accelerometerData.acceleration.x > _accelerometers.x.max){
            _accelerometers.x.max = accelerometerData.acceleration.x;
        }
        if(accelerometerData.acceleration.y < _accelerometers.y.min){
            _accelerometers.y.min = accelerometerData.acceleration.y;
        }
        if(accelerometerData.acceleration.y > _accelerometers.y.max){
            _accelerometers.y.max = accelerometerData.acceleration.y;
        }
        if(accelerometerData.acceleration.z < _accelerometers.z.min){
            _accelerometers.z.min = accelerometerData.acceleration.z;
        }
        if(accelerometerData.acceleration.z > _accelerometers.z.max){
            _accelerometers.z.max = accelerometerData.acceleration.z;
        }
        
        // Update UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate vwwMotionMonitor:self accelerometerUpdated:self.accelerometers];
        });
    }];
    self.accelerometerRunning = YES;
    NSLog(@"Started Accelerometer");
}
    

-(void)stopAccelerometer{
    if(self.accelerometerRunning == NO) return;
    [self.motion stopAccelerometerUpdates];
    memset(&_accelerometers, 0, sizeof(MotionDevice));
    self.accelerometerRunning = NO;
    NSLog(@"Stopped Accelerometer");
}

-(void)startGyroscopes{
    if(self.gyrosRunning == YES) return;
    self.motion.gyroUpdateInterval = 1/30.0f;
    NSOperationQueue* gyroQueue = [[NSOperationQueue alloc] init];
    [self.motion startGyroUpdatesToQueue:gyroQueue withHandler:^(CMGyroData *gyroData, NSError *error) {
        
        // X Axis
        // Gyro value is currently in the range of
        // (-kGyroXMax .. kGyroXMax)
        // Convert to value in range
        // (0 .. 2*kGyroXMax)
        float value = gyroData.rotationRate.x + kGyroXMax;
        // then range
        // (0.0 .. 1.0)
        float normalize = (float)2.0*kGyroXMax;
        value /= normalize;
        // Clip
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        // Set _device values
        _gyroroscopes.x.current = gyroData.rotationRate.x;
        _gyroroscopes.x.currentNormalized = value;
        
        
        // Y Axis
        value = gyroData.rotationRate.y + kGyroYMax;
        normalize = (float)2.0*kGyroYMax;
        value /= normalize;
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        _gyroroscopes.y.current = gyroData.rotationRate.y;
        _gyroroscopes.y.currentNormalized = value;
        
        // Z Axis
        value = gyroData.rotationRate.z + kGyroZMax;
        normalize = (float)2.0*kGyroZMax;
        value /= normalize;
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        _gyroroscopes.z.current = gyroData.rotationRate.z;
        _gyroroscopes.z.currentNormalized = value;
        
        
        
        // Set device min and max values
        if(gyroData.rotationRate.x < _gyroroscopes.x.min){
            _gyroroscopes.x.min = gyroData.rotationRate.x;
        }
        if(gyroData.rotationRate.x > _gyroroscopes.x.max){
            _gyroroscopes.x.max = gyroData.rotationRate.x;
        }
        if(gyroData.rotationRate.y < _gyroroscopes.y.min){
            _gyroroscopes.y.min = gyroData.rotationRate.y;
        }
        if(gyroData.rotationRate.y > _gyroroscopes.y.max){
            _gyroroscopes.y.max = gyroData.rotationRate.y;
        }
        if(gyroData.rotationRate.z < _gyroroscopes.z.min){
            _gyroroscopes.z.min = gyroData.rotationRate.z;
        }
        if(gyroData.rotationRate.z > _gyroroscopes.z.max){
            _gyroroscopes.z.max = gyroData.rotationRate.z;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate vwwMotionMonitor:self gyroUpdated:_gyroroscopes];
        });
    }];
    self.gyrosRunning = YES;
    NSLog(@"Started Gyros");
    
}
-(void)stopGyroscopes{
    if(self.gyrosRunning == NO) return;
    
    [self.motion stopGyroUpdates];
    memset(&_gyroroscopes, 0, sizeof(MotionDevice));
    self.gyrosRunning = NO;
    NSLog(@"Stopped Gyros");
}

-(void)startMagnetometer{
    if(self.magnetometerRunning == YES) return;
    self.motion.magnetometerUpdateInterval = 1/30.0f;
    NSOperationQueue* magnetometerQueue = [[NSOperationQueue alloc] init];
    [self.motion startMagnetometerUpdatesToQueue:magnetometerQueue withHandler:^(CMMagnetometerData *magnetometerData, NSError *error) {
        
        // X Axis
        // Magnetometer value is currently in the range of
        // (-kMagnetometerXMax .. kMagnetometerXMax)
        // Convert to value in range
        // (0 .. 2*kMagnetometerXMax)
        float value = magnetometerData.magneticField.x + kMagnetometerXMax;
        // then range
        // (0.0 .. 1.0)
        float normalize = (float)2.0*kMagnetometerXMax;
        value /= normalize;
        // Clip
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        // Set _device values
        _magnetometers.x.current = magnetometerData.magneticField.x;
        _magnetometers.x.currentNormalized = value;
        
        
        // Y Axis
        value = magnetometerData.magneticField.y + kMagnetometerYMax;
        normalize = (float)2.0*kMagnetometerYMax;
        value /= normalize;
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        _magnetometers.y.current = magnetometerData.magneticField.y;
        _magnetometers.y.currentNormalized = value;
        
        // Z Axis
        float absZ = magnetometerData.magneticField.z;
        if(absZ < 0) absZ *= -1.0;
        value = absZ + kMagnetometerZMax;
        normalize = (float)2.0*kMagnetometerZMax;
        value /= normalize;
        if(value < 0.0) value = 0;
        if(value > 1.0) value = 1.0;
        _magnetometers.z.current = magnetometerData.magneticField.z;
        _magnetometers.z.currentNormalized = value;
        
        
        
        // Set device min and max values
        if(magnetometerData.magneticField.x < _magnetometers.x.min){
            _magnetometers.x.min = magnetometerData.magneticField.x;
        }
        if(magnetometerData.magneticField.x > _magnetometers.x.max){
            _magnetometers.x.max = magnetometerData.magneticField.x;
        }
        if(magnetometerData.magneticField.y < _magnetometers.y.min){
            _magnetometers.y.min = magnetometerData.magneticField.y;
        }
        if(magnetometerData.magneticField.y > _magnetometers.y.max){
            _magnetometers.y.max = magnetometerData.magneticField.y;
        }
        if(magnetometerData.magneticField.z < _magnetometers.z.min){
            _magnetometers.z.min = magnetometerData.magneticField.z;
        }
        if(magnetometerData.magneticField.z > _magnetometers.z.max){
            _magnetometers.z.max = magnetometerData.magneticField.z;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate vwwMotionMonitor:self magnetometerUpdated:_magnetometers];
        });
    }];
    self.magnetometerRunning = YES;
    NSLog(@"Started Magnetometer");
    
}
-(void)stopMagnetometer{
    if(self.magnetometerRunning == NO) return;
    
    [self.motion stopMagnetometerUpdates];
    memset(&_magnetometers, 0, sizeof(MotionDevice));
    self.magnetometerRunning = NO;
    NSLog(@"Stopped Magnetometer");
}


@end


