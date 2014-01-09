//
//  VWWSynthesizerEffectNoteKey.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/7/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizerEffectNoteKey.h"

static __attribute ((unused)) NSString* kKeyKey = @"key";
static __attribute ((unused)) NSString* kKeyAMinor = @"aminor";
static __attribute ((unused)) NSString* kKeyAMajor = @"amajor";
static __attribute ((unused)) NSString* kKeyBMinor = @"bminor";
static __attribute ((unused)) NSString* kKeyBMajor = @"bmajor";
static __attribute ((unused)) NSString* kKeyCMajor = @"cmajor";
static __attribute ((unused)) NSString* kKeyDMinor = @"dminor";
static __attribute ((unused)) NSString* kKeyDMajor = @"dmajor";
static __attribute ((unused)) NSString* kKeyEMinor = @"eminor";
static __attribute ((unused)) NSString* kKeyEMajor = @"emajor";
static __attribute ((unused)) NSString* kKeyFMajor = @"fmajor";
static __attribute ((unused)) NSString* kKeyGMinor = @"gminor";
static __attribute ((unused)) NSString* kKeyGMajor = @"gmajor";
static __attribute ((unused)) NSString* kKeyChromatic = @"chromatic";

@implementation VWWSynthesizerEffectNoteKey
-(NSString*)stringForKey{
    switch(self.key){
        case VWWKeyTypeAMinor:
            return kKeyAMinor;
        case VWWKeyTypeAMajor:
            return kKeyAMajor;
        case VWWKeyTypeBMinor:
            return kKeyBMinor;
        case VWWKeyTypeBMajor:
            return kKeyBMajor;
        case VWWKeyTypeCMajor:
            return kKeyCMajor;
        case VWWKeyTypeDMinor:
            return kKeyDMinor;
        case VWWKeyTypeDMajor:
            return kKeyDMajor;
        case VWWKeyTypeEMinor:
            return kKeyEMinor;
        case VWWKeyTypeEMajor:
            return kKeyEMajor;
        case VWWKeyTypeFMajor:
            return kKeyFMajor;
        case VWWKeyTypeGMinor:
            return kKeyAMinor;
        case VWWKeyTypeGMajor:
            return kKeyAMajor;
        case VWWKeyTypeChromatic:
        default:
            return kKeyChromatic;
    }
}
-(VWWKeyType)keyFromString:(NSString*)keyString{
    if([keyString isEqualToString:kKeyAMinor]){
        return VWWKeyTypeAMinor;
    }
    else if([keyString isEqualToString:kKeyAMajor]){
        return VWWKeyTypeAMajor;
    }
    else if([keyString isEqualToString:kKeyBMinor]){
        return VWWKeyTypeBMinor;
    }
    else if([keyString isEqualToString:kKeyBMajor]){
        return VWWKeyTypeBMajor;
    }
    else if([keyString isEqualToString:kKeyCMajor]){
        return VWWKeyTypeCMajor;
    }
    else if([keyString isEqualToString:kKeyDMinor]){
        return VWWKeyTypeDMinor;
    }
    else if([keyString isEqualToString:kKeyDMajor]){
        return VWWKeyTypeDMajor;
    }
    else if([keyString isEqualToString:kKeyEMinor]){
        return VWWKeyTypeEMinor;
    }
    else if([keyString isEqualToString:kKeyEMajor]){
        return VWWKeyTypeEMajor;
    }
    else if([keyString isEqualToString:kKeyFMajor]){
        return VWWKeyTypeFMajor;
    }
    else if([keyString isEqualToString:kKeyGMinor]){
        return VWWKeyTypeGMinor;
    }
    else if([keyString isEqualToString:kKeyGMajor]){
        return VWWKeyTypeGMajor;
    }
    else /* if([keyString isEqualToString:kKeyChromatic]) */ {
        return VWWKeyTypeChromatic;
    }
}

@end
