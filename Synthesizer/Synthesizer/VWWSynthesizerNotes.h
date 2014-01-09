//
//  VWWSynthesizerNotes.h
//  Theremin
//
//  Created by Zakk Hoyt on 8/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWSynthesizerTypes.h"

//typedef enum{
//    kNoteKeyChromatic = 0,
//    kNoteKeyAMinor,
//    kNoteKeyAMajor,
//    kNoteKeyBMinor,
//    kNoteKeyBMajor,
//    kNoteKeyCMajor,
//    kNoteKeyDMinor,
//    kNoteKeyDMajor,
//    kNoteKeyEMinor,
//    kNoteKeyEMajor,
//    kNoteKeyFMajor,
//    kNoteKeyGMinor,
//    kNoteKeyGMajor,
//} NoteKey;

@interface VWWSynthesizerNotes : NSObject
+(VWWSynthesizerNotes *)sharedInstance;
+(float)getClosestNoteForFrequency:(float)frequency;
+(float)getClosestNoteForFrequency:(float)frequency inKey:(NoteKey)key;
@end
