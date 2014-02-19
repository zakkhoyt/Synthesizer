//
//  VWWSynthesizerTypes.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#ifndef Theremin_VWWSynthesizerTypes_h
#define Theremin_VWWSynthesizerTypes_h




typedef enum{
    VWWAxisTypeX = 0,
    VWWAxisTypeY = 1,
    VWWAxisTypeZ = 2,
} VWWAxisType;


typedef enum{
    VWWWaveTypeSine = 0,
    VWWWaveTypeSquare = 1,
    VWWWaveTypeTriangle = 2,
    VWWWaveTypeSawtooth = 3,
} VWWWaveType;

typedef enum{
    VWWInputTypeNone = 0x00,
    VWWInputTypeTouch,
    VWWInputTypeAccelerometer,
    VWWInputTypeGyroscope,
    VWWInputTypeMagnetometer,
} VWWInputType;

typedef enum{
    VWWKeyTypeChromatic = 0,
    VWWKeyTypeAMinor,
    VWWKeyTypeAMajor,
    VWWKeyTypeBMinor,
    VWWKeyTypeBMajor,
    VWWKeyTypeCMajor,
    VWWKeyTypeDMinor,
    VWWKeyTypeDMajor,
    VWWKeyTypeEMinor,
    VWWKeyTypeEMajor,
    VWWKeyTypeFMajor,
    VWWKeyTypeGMinor,
    VWWKeyTypeGMajor,
} VWWKeyType;

typedef enum{
    VWWEffectTypeNone = 0x00,
    VWWEffectTypeAutoTune = 0x01,
    VWWEffectTypeLinearize = 0x02,
    VWWEffectTypeThrottle = 0x04,
} VWWEffectType;

#endif
