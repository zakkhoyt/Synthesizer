//
//  VWWSynthesizerNotes.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 8/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWSynthesizerTypes.h"

@interface VWWSynthesizerNotes : NSObject
+(VWWSynthesizerNotes *)sharedInstance;
+(float)getClosestNoteForFrequency:(float)frequency;
+(float)getClosestNoteForFrequency:(float)frequency inKey:(VWWKeyType)key;
@end
