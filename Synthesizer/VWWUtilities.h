//
//  VWWUtilities.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#ifndef Heartstream_HeartstreamUtilities_h
#define Heartstream_HeartstreamUtilities_h

#define VWW_LOG(...) NSLog(@"%@", [NSString stringWithFormat:__VA_ARGS__]);
#define VWW_LOG_INFO(...) NSLog(@"%s:%d ***** INFO: %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__]);
#define VWW_LOG_WARNING(...) NSLog(@"%s:%d ***** WARNING: %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__]);
#define VWW_LOG_ERROR(...) NSLog(@"%s:%d ***** ERROR: %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__]);

#if defined(VWW_DEBUG)
#define VWW_LOG_CRITICAL(...) NSLog(@"%s:%d ***** CRITICAL ERROR: %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__]); assert(0);
#define VWW_LOG_DEBUG(...) NSLog(@"%s:%d ***** DEBUG: %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__]);
#else 
#define VWW_LOG_CRITICAL(...) NSLog(@"%s:%d ***** CRITICAL ERROR: %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__]);
#define VWW_LOG_DEBUG(...) NSLog(@"");
#endif
#define VWW_LOG_TODO NSLog(@"%s:%d TODO: Implement", __FUNCTION__, __LINE__);
#define VWW_LOG_TODO_TASK(...) NSLog(@"%s:%d TODO: %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__]);

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )
#define IS_IPHONE_5 ( IS_IPHONE && IS_WIDESCREEN )

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#endif
