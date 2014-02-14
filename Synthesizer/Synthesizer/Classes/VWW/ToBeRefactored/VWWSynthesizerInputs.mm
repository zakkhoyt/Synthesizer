
//  VWWSynthesizerInputs.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 12/28/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizerInputs.h"
#import "VWWSynthesizerFileSystem.h"

@interface VWWSynthesizerInputs ()
@property (nonatomic, strong) NSMutableDictionary* inputs;
@end

@implementation VWWSynthesizerInputs

+(VWWSynthesizerInputs *)sharedInstance{
    static VWWSynthesizerInputs* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VWWSynthesizerInputs alloc]init];
    });
    return instance;
}
+(void)saveConfigFile{
    [[self sharedInstance]saveFile];
}
+(void)resetConfigAndSave{
    VWWSynthesizerInputs* synthesizerInputs = [VWWSynthesizerInputs sharedInstance];
    [synthesizerInputs.inputs removeAllObjects];
    [synthesizerInputs createAndSaveNewInputs];
    
    // Save the changes;
    [[self sharedInstance]saveFile];
}
+(VWWSynthesizerInput*)accelerometerInput{
    return ([self sharedInstance].inputs)[kKeyAccelerometer];
}
+(VWWSynthesizerInput*)gyroscopeInput{
    return ([self sharedInstance].inputs)[kKeyGyroscope];
}
+(VWWSynthesizerInput*)magnetometerInput{
    return ([self sharedInstance].inputs)[kKeyMagnetometer];
}
+(VWWSynthesizerInput*)touchscreenInput{
    return ([self sharedInstance].inputs)[kKeyTouchScreen];
}

-(id)init{
    self = [super init];
    if(self){
        [self initializeClass];
    }
    return self;
}

-(void)initializeClass{
    _inputs = [[NSMutableDictionary alloc]init];
        
    // If the config file exists, load it. If not, go ahead and write our default values as a file and move on.
    if([VWWSynthesizerFileSystem configFileExists]){
        [self loadFile];
    }
    else{
        [self createAndSaveNewInputs];
    }
}

-(void)createAndSaveNewInputs{
    VWWSynthesizerInput* touchInput = [[VWWSynthesizerInput alloc]initWithType:VWWInputTypeTouch];
    VWWSynthesizerInput* accelerometerInput = [[VWWSynthesizerInput alloc]initWithType:VWWInputTypeAccelerometer];
    VWWSynthesizerInput* gyroscopeInput = [[VWWSynthesizerInput alloc]initWithType:VWWInputTypeGyroscope];
    VWWSynthesizerInput* magnetometerInput = [[VWWSynthesizerInput alloc]initWithType:VWWInputTypeMagnetometer];
    
    (self.inputs)[touchInput.description] = touchInput;
    (self.inputs)[accelerometerInput.description] = accelerometerInput;
    (self.inputs)[gyroscopeInput.description] = gyroscopeInput;
    (self.inputs)[magnetometerInput.description] = magnetometerInput;
    
    [self saveFile];
}


-(NSString*)jsonRepresentation{
    NSMutableArray* inputs = [[NSMutableArray alloc]init];
    for(NSString* key in [self.inputs allKeys]){
        VWWSynthesizerInput* input = (self.inputs)[key];
        [inputs addObject:input.jsonRepresentation];
        
    }
    
    NSError* error = nil;
    NSData* outData = [NSJSONSerialization dataWithJSONObject:inputs options:NSJSONReadingMutableContainers error:&error];
    NSString* outDataString = [[NSString alloc]initWithBytes:[outData bytes] length:outData.length encoding:NSUTF8StringEncoding];
    return outDataString;
}



-(void)saveFile{
    NSString* fileString = self.jsonRepresentation;
    if([VWWSynthesizerFileSystem writeFile:fileString] == NO){
        VWW_LOG_INFO(@"Error writing config file");
    }
}

// Read from file and populate data structures
-(void)loadFile{
    NSString* contents = [VWWSynthesizerFileSystem readFile];
    if(contents == nil){
        return;
    }

    VWW_LOG_INFO(@"parsing json...");

    NSData* data = [contents dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    if (!jsonArray || jsonArray.count == 0) {
        VWW_LOG_INFO(@"Error parsing JSON: %@", error);
        return;
    }
    
    for(NSDictionary* dict in jsonArray) {
        VWWSynthesizerInput* input = [[VWWSynthesizerInput alloc]initWithDictionary:dict];
        if((self.inputs)[input.description]){
            [self.inputs removeObjectForKey:input.description];
        }
        (self.inputs)[input.description] = input;
    }

    VWW_LOG_INFO(@"self json = %@", self.jsonRepresentation);
}

@end
