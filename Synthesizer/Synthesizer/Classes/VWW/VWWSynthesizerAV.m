//
//  VWWSynthesizerAV.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/16/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWSynthesizerAV.h"
#import <AVFoundation/AVFoundation.h>

@implementation VWWSynthesizerAV




//-(void)t{
//    AudioChannelLayout channelLayout;
//    memset(&channelLayout, 0, sizeof(AudioChannelLayout));
//    channelLayout.mChannelLayoutTag = kAudioChannelLayoutTag_Stereo;
//    
//    AVAssetWriter *assetWriter = [[AVAssetWriter assetWriterWithURL:exportURL
//                                                           fileType:AVFileTypeMPEG4
//                                   
//                                                              error:&assetError] retain];
//    
//    NSDictionary *outputSettings = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    [ NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
//                                    [ NSNumber numberWithInt: 2 ], AVNumberOfChannelsKey,
//                                    [ NSNumber numberWithFloat: 44100.0 ], AVSampleRateKey,
//                                    [NSData dataWithBytes:&channelLayout length:sizeof(AudioChannelLayout)], AVChannelLayoutKey,
//                                    [ NSNumber numberWithInt: 128000 ], AVEncoderBitRateKey,nil];
//}
@end
