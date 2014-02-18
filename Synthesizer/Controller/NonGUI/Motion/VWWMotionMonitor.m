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

const float kMagnetometerXMax = 80.0f;
const float kMagnetometerYMax = 30.0f;
const float kMagnetometerZMax = 30.0f;


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

    CMAccelerometerHandler accelerometerHandler = ^(CMAccelerometerData *accelerometerData, NSError *error) {

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
            _accelerometers.y.max = accelerometerData.acceleration.y;
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

//        // Send new frequencie to the synth channels
//        VWWThereminInput* accelerometer = [VWWThereminInputs accelerometerInput];
//        {
//            float centerFreq = (accelerometer.x.frequencyMax - accelerometer.x.frequencyMin) / 2.0;
//            float maxDrift = (accelerometer.x.frequencyMax - centerFreq) * kSensitivityOffset;
//            float driftFactor = _devices.accelerometer.x.currentNormalized * accelerometer.x.sensitivity;
//            float drift = maxDrift * driftFactor;
//            float newFrequency = centerFreq + drift;
//            accelerometer.x.frequency = newFrequency;
////            NSLog(@"X normalized:%f newFreq:%f", _devices.accelerometer.x.currentNormalized, newFrequency);/
////            NSLog(@"X normalized:%f", _devices.accelerometer.x.currentNormalized);
//
//        }
//        {
//            float centerFreq = (accelerometer.y.frequencyMax - accelerometer.y.frequencyMin) / 2.0;
//            float maxDrift = (accelerometer.y.frequencyMax - centerFreq) * kSensitivityOffset;
//            float driftFactor = _devices.accelerometer.y.currentNormalized * accelerometer.y.sensitivity;
//            float drift = maxDrift * driftFactor;
//            float newFrequency = centerFreq + drift;
//            accelerometer.y.frequency = newFrequency;
////            NSLog(@"Y normalized:%f newFreq:%f", _devices.accelerometer.y.currentNormalized, newFrequency);
////            NSLog(@"Y normalized:%f", _devices.accelerometer.y.currentNormalized);
//        }
//        {
//            float centerFreq = (accelerometer.z.frequencyMax - accelerometer.z.frequencyMin) / 2.0;
//            float maxDrift = (accelerometer.z.frequencyMax - centerFreq) * kSensitivityOffset;
//            float driftFactor = _devices.accelerometer.z.currentNormalized * accelerometer.z.sensitivity;
//            float drift = maxDrift * driftFactor;
//            float newFrequency = centerFreq + drift;
//            accelerometer.z.frequency = newFrequency;
//            //            NSLog(@"Z normalized:%f newFreq:%f", _devices.accelerometer.z.currentNormalized, newFrequency);
////            NSLog(@"Z normalized:%f", _devices.accelerometer.z.currentNormalized);
//        }
        
        // Update UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate vwwMotionMonitor:self accelerometerUpdated:self.accelerometers];
        });
    };

    [self.motion startAccelerometerUpdatesToQueue:accelerometerQueue withHandler:[accelerometerHandler copy]];
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


-(void)startMagnetometer{
    if(self.magnetometerRunning == YES) return;
    
    self.motion.magnetometerUpdateInterval = 1/30.0f;
    
    NSOperationQueue* magnetometerQueue = [[NSOperationQueue alloc] init];
    
    CMMagnetometerHandler magnetometerHandler = ^(CMMagnetometerData *magnetometerData, NSError *error) {
        
        // X Axis
        // Magnetometer value is currently in the range of
        // (-kMagnetometerXMax .. kMagnetometerXMax)
        // Convert to value in range
        // (0 .. 2*kMagnetometerXMax)
        float value = magnetometerData.magneticField.x + kAccelerometerXMax;
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
        value = magnetometerData.magneticField.z + kMagnetometerZMax;
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
        
//        // Send new frequencie to the synth channels
//        VWWThereminInput* magnetometer = [VWWThereminInputs magnetometerInput];
//        {
//            float centerFreq = (magnetometer.x.frequencyMax - magnetometer.x.frequencyMin) / 2.0;
//            float maxDrift = (magnetometer.x.frequencyMax - centerFreq) * kSensitivityOffset;
//            float driftFactor = _devices.magnetometer.x.currentNormalized * magnetometer.x.sensitivity;
//            float drift = maxDrift * driftFactor;
//            float newFrequency = centerFreq + drift;
//            magnetometer.x.frequency = newFrequency;
//            NSLog(@"X normalized:%f newFreq:%f", _devices.magnetometer.x.currentNormalized, newFrequency);
//        }
//        {
//            float centerFreq = (magnetometer.y.frequencyMax - magnetometer.y.frequencyMin) / 2.0;
//            float maxDrift = (magnetometer.y.frequencyMax - centerFreq) * kSensitivityOffset;
//            float driftFactor = _devices.magnetometer.y.currentNormalized * magnetometer.y.sensitivity;
//            float drift = maxDrift * driftFactor;
//            float newFrequency = centerFreq + drift;
//            magnetometer.y.frequency = newFrequency;
//            NSLog(@"Y normalized:%f newFreq:%f", _devices.magnetometer.y.currentNormalized, newFrequency);
//        }
//        {
//            float centerFreq = (magnetometer.z.frequencyMax - magnetometer.z.frequencyMin) / 2.0;
//            float maxDrift = (magnetometer.z.frequencyMax - centerFreq) * kSensitivityOffset;
//            float driftFactor = _devices.magnetometer.z.currentNormalized * magnetometer.z.sensitivity;
//            float drift = maxDrift * driftFactor;
//            float newFrequency = centerFreq + drift;
//            magnetometer.z.frequency = newFrequency;
//            NSLog(@"Z normalized:%f newFreq:%f", _devices.magnetometer.z.currentNormalized, newFrequency);
//        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate vwwMotionMonitor:self magnetometerUpdated:_magnetometers];
        });
    };
    
    [self.motion startMagnetometerUpdatesToQueue:magnetometerQueue withHandler:[magnetometerHandler copy]];
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

-(void)startGyroscopes{
    if(self.gyrosRunning == YES) return;
    
    self.motion.gyroUpdateInterval = 1/30.0f;
    
    NSOperationQueue* gyroQueue = [[NSOperationQueue alloc] init];
    
    CMGyroHandler gyroHandler = ^(CMGyroData *gyroData, NSError *error) {
        
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
        
        
//        // Send new frequencie to the synth channels
//        VWWThereminInput* gyroscope = [VWWThereminInputs gyroscopeInput];
//        {
//            float centerFreq = (gyroscope.x.frequencyMax - gyroscope.x.frequencyMin) / 2.0;
//            float maxDrift = (gyroscope.x.frequencyMax - centerFreq) * kSensitivityOffset;
//            float driftFactor = _devices.gyro.x.currentNormalized * gyroscope.x.sensitivity;
//            float drift = maxDrift * driftFactor;
//            float newFrequency = centerFreq + drift;
//            gyroscope.x.frequency = newFrequency;
//            NSLog(@"X normalized:%f newFreq:%f", _devices.gyro.x.currentNormalized, newFrequency);
//        }
//        {
//            float centerFreq = (gyroscope.y.frequencyMax - gyroscope.y.frequencyMin) / 2.0;
//            float maxDrift = (gyroscope.y.frequencyMax - centerFreq) * kSensitivityOffset;
//            float driftFactor = _devices.gyro.y.currentNormalized * gyroscope.y.sensitivity;
//            float drift = maxDrift * driftFactor;
//            float newFrequency = centerFreq + drift;
//            gyroscope.y.frequency = newFrequency;
//            NSLog(@"Y normalized:%f newFreq:%f", _devices.gyro.y.currentNormalized, newFrequency);
//        }
//        {
//            float centerFreq = (gyroscope.z.frequencyMax - gyroscope.z.frequencyMin) / 2.0;
//            float maxDrift = (gyroscope.z.frequencyMax - centerFreq) * kSensitivityOffset;
//            float driftFactor = _devices.gyro.z.currentNormalized * gyroscope.z.sensitivity;
//            float drift = maxDrift * driftFactor;
//            float newFrequency = centerFreq + drift;
//            gyroscope.z.frequency = newFrequency;
//            NSLog(@"Z normalized:%f newFreq:%f", _devices.gyro.z.currentNormalized, newFrequency);
//        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate vwwMotionMonitor:self gyroUpdated:_gyroroscopes];
        });
    };
    
    [self.motion startGyroUpdatesToQueue:gyroQueue withHandler:[gyroHandler copy]];
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
//
//-(NSString*)description:(MotionDevice)device{
//    return [NSString stringWithFormat:@"(min, current, max):\n"
//         "X; %f < %f < %f\n"
//         "Y; %f < %f < %f\n"
//         "Z; %f < %f < %f\n",
//         device.x.min,
//         device.x.current,
//         device.x.max,
//         device.y.min,
//         device.y.current,
//         device.y.max,
//         device.z.min,
//         device.z.current,
//         device.z.max];
//}

@end


