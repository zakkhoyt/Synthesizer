//
//  VWWSynthesizerTypes.h
//  Theremin
//
//  Created by Zakk Hoyt on 1/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#ifndef Theremin_VWWSynthesizerTypes_h
#define Theremin_VWWSynthesizerTypes_h

// Temporary in order to not render for release 1.0
#define VWW_SKIP_RENDERING_CALL     1

#define VWW_FREQUENCY_MAX           1000.0
#define VWW_FREQUENCY_MIN           20.0
#define VWW_WAVETYPE                kWaveSin
#define VWW_SENSITIVITY             1.0
#define VWW_EFFECT                  kEffectNone
#define VWW_INPUT_TYPE              kInputTouch
#define VWW_AMPLITUDE               1.0
#define VWW_NOTE_KEY                kNoteKeyChromatic
#define VWW_MUTED                   YES
#define VWW_SHOW_INFO_SCREENS       1
#define VWW_MAX_CHANNELS            1
#define VWW_DISMISS_INFO_DURATION   0.5



typedef enum{
    kWaveNone = 0,
    kWaveSin,
    kWaveSquare,
    kWaveTriangle,
    kWaveSawtooth,
} WaveType;

typedef enum{
    kInputNone = 0x00,
    kInputTouch,
    kInputAccelerometer,
    kInputGyros,
    kInputMagnetometer,
} InputType;

// Use bitwise so we can apply multiple settings to one channel
typedef enum{
    kEffectNone = 0x00,
    kEffectAutoTune = 0x01,
    kEffectLinearize = 0x02,
    kEffectThrottle = 0x04,
} EffectType;

typedef enum{
    kNoteKeyChromatic = 0,
    kNoteKeyAMinor,
    kNoteKeyAMajor,
    kNoteKeyBMinor,
    kNoteKeyBMajor,
    kNoteKeyCMajor,
    kNoteKeyDMinor,
    kNoteKeyDMajor,
    kNoteKeyEMinor,
    kNoteKeyEMajor,
    kNoteKeyFMajor,
    kNoteKeyGMinor,
    kNoteKeyGMajor,
} NoteKey;

#endif
