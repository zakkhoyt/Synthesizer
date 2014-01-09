//
//  VWWSynthesizerDefaults.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#ifndef Synthesizer_VWWSynthesizerDefaults_h
#define Synthesizer_VWWSynthesizerDefaults_h

// Temporary in order to not render for release 1.0
#define VWW_SKIP_RENDERING_CALL     1
#define VWW_FREQUENCY_MAX           1000.0
#define VWW_FREQUENCY_MIN           20.0
#define VWW_WAVETYPE                VWWWaveTypeSine
#define VWW_SENSITIVITY             1.0
#define VWW_EFFECT                  VWWEffectTypeNone
#define VWW_INPUT_TYPE              VWWInputTypeTouch
#define VWW_AMPLITUDE               1.0
#define VWW_NOTE_KEY                VWWKeyTypeChromatic
#define VWW_MUTED                   YES
#define VWW_SHOW_INFO_SCREENS       1
#define VWW_MAX_CHANNELS            1
#define VWW_DISMISS_INFO_DURATION   0.5

#endif
