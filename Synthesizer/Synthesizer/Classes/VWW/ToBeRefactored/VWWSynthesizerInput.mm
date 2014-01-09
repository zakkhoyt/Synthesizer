//
//  VWWSynthesizerInput.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizerInput.h"
#import "VWWSynthesizerDefaults.h"
// Keys for read/writing hash sets
static __attribute ((unused)) NSString* kKeyAccelerometer = @"accelerometer";
static __attribute ((unused)) NSString* kKeyGyroscope = @"gyroscope";
static __attribute ((unused)) NSString* kKeyMagnetometer = @"magnetometer";
static __attribute ((unused)) NSString* kKeyTouchScreen = @"touchscreen";
static __attribute ((unused)) NSString* kKeyNone = @"none";
static __attribute ((unused)) NSString* kKeyType = @"type";
static __attribute ((unused)) NSString* kKeyX = @"x";
static __attribute ((unused)) NSString* kKeyY = @"y";
static __attribute ((unused)) NSString* kKeyZ = @"z";
static __attribute ((unused)) NSString* kKeyMuted = @"muted";

@interface VWWSynthesizerInput ()
@end

@implementation VWWSynthesizerInput

-(id)initWithType:(VWWInputType)type{
    self = [super init];
    if(self){
        _inputType = type;
        [self enableTouchScreenByDefault];
        _x = [[VWWSynthesizerInputAxis alloc]init];
        _y = [[VWWSynthesizerInputAxis alloc]init];
        _z = [[VWWSynthesizerInputAxis alloc]init];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        if(dictionary){
            NSString* type = dictionary[kKeyType];
            _inputType = [self inputTypeFromString:type];
            [self enableTouchScreenByDefault];
            NSDictionary* xDict = dictionary[kKeyX];
            _x = [[VWWSynthesizerInputAxis alloc]initWithDictionary:xDict];
            NSDictionary* yDict = dictionary[kKeyY];
            _y = [[VWWSynthesizerInputAxis alloc]initWithDictionary:yDict];
            NSDictionary* zDict = dictionary[kKeyZ];
            _z = [[VWWSynthesizerInputAxis alloc]initWithDictionary:zDict];
            _muted = dictionary[kKeyMuted];
        }
        else{
            // Defaults
            _inputType = VWW_INPUT_TYPE;
            [self enableTouchScreenByDefault];
            _x = [[VWWSynthesizerInputAxis alloc]init];
            _y = [[VWWSynthesizerInputAxis alloc]init];
            _z = [[VWWSynthesizerInputAxis alloc]init];
            
            // muted
            if(_inputType == VWWInputTypeTouch){
                _muted = NO;
            }
            else{
                _muted = YES;
            }
            

        }
    }
    return self;
}

-(NSDictionary*)jsonRepresentation{
    NSMutableDictionary* jsonDict = [NSMutableDictionary new];
    [jsonDict setValue:self.x.jsonRepresentation forKey:kKeyX];
    [jsonDict setValue:self.y.jsonRepresentation forKey:kKeyY];
    [jsonDict setValue:self.z.jsonRepresentation forKey:kKeyZ];
    [jsonDict setValue:[self stringForVWWInputType] forKey:kKeyType];
    [jsonDict setValue:self.muted ? @"1" : @"0" forKey:kKeyMuted];
    return jsonDict;
}

-(void)enableTouchScreenByDefault{
    if(_inputType == VWWInputTypeTouch){
        self.muted = NO;
    }
    else{
        self.muted = YES;
    }
}

-(NSString*)stringForVWWInputType{
    switch (self.inputType) {
        case VWWInputTypeAccelerometer:
            return kKeyAccelerometer;
        case VWWInputTypeGyroscope:
            return kKeyGyroscope;
        case VWWInputTypeMagnetometer:
            return kKeyMagnetometer;
        case VWWInputTypeTouch:
            return kKeyTouchScreen;
        case VWWInputTypeNone:
        default:
            return kKeyNone;
    }
}

-(VWWInputType)inputTypeFromString:(NSString*)typeString{
    if([typeString isEqualToString:kKeyAccelerometer]){
        return VWWInputTypeAccelerometer;
    }
    else if([typeString isEqualToString:kKeyGyroscope]){
        return VWWInputTypeGyroscope;
    }
    else if([typeString isEqualToString:kKeyMagnetometer]){
        return VWWInputTypeMagnetometer;
    }
    else if([typeString isEqualToString:kKeyTouchScreen]){
        return VWWInputTypeTouch;
    }
    else /* if([typeString isEqualToString:kKeyNone]) */ {
        return VWWInputTypeNone;
    }
}

-(NSString*)description{
    return [self stringForVWWInputType];
}


-(void)setMuted:(bool)newMuted{
    if(_muted == newMuted) return;

    _muted = newMuted;
    if(_muted){
        _x.muted = YES;
        _y.muted = YES;
        _z.muted = YES;
    }
    else{
        _x.muted = NO;
        _y.muted = NO;
        _z.muted = self.inputType == VWWInputTypeTouch ? YES : NO; // Mute touch Z always
    }
}

//-(bool)muted{
//    if(_x.muted == NO ||
//        _y.muted == NO ||
//       _z.muted == NO){
//        return NO;
//    }
//    return YES;
//}

@end
