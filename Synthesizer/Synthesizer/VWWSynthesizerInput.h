//
//  VWWSynthesizerInput.h
//  Theremin
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWSynthesizerInputAxis.h"
#import "VWWSynthesizerTypes.h"

@interface VWWSynthesizerInput : NSObject
@property (nonatomic, strong) VWWSynthesizerInputAxis* x;
@property (nonatomic, strong) VWWSynthesizerInputAxis* y;
@property (nonatomic, strong) VWWSynthesizerInputAxis* z;
@property (nonatomic) InputType inputType;
@property (nonatomic) bool muted;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(id)initWithType:(InputType)type;
-(NSDictionary*)jsonRepresentation;
-(NSString*)description;
@end
