//
//  VWWFileSystem.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 12/30/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizerFileSystem.h"
#import "VWWSettingsKeys.h"
#import "VWWSynthesizerTypes.h"

@implementation VWWSynthesizerFileSystem

+(bool)configFileExists{
    NSString *docsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [docsDirectory stringByAppendingPathComponent:kConfigFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

+(NSString*)readFile{
    NSString *docsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [docsDirectory stringByAppendingPathComponent:kConfigFileName];

    if([VWWSynthesizerFileSystem configFileExists] == NO){
        return nil;
    }
    
    NSError* error = nil;
    NSString* contents = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    return contents;
}

+(bool)writeFile:(NSString*)contents{
    NSData* data = [contents dataUsingEncoding:NSUTF8StringEncoding];
    NSString *docsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [docsDirectory stringByAppendingPathComponent:kConfigFileName];
    [data writeToFile:path atomically:YES];
    return [VWWSynthesizerFileSystem configFileExists];
}

@end
