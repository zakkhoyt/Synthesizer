//
//  VWWBonjourClientController.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/17/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VWWBonjourClientController;

@protocol VWWBonjourClientControllerDelegate <NSObject>

-(void)bonjourClientControllerDidStartBrowsing:(VWWBonjourClientController*)sender;
-(void)bonjourClientController:(VWWBonjourClientController*)sender didStopBrowsingWithError:(NSError*)error;
-(void)bonjourClientController:(VWWBonjourClientController*)sender didDiscoverServices:(NSArray*)services;
@end

@interface VWWBonjourClientController : NSObject

+(VWWBonjourClientController*)sharedInstance;
-(void)startBrowsing;
-(void)stopBrowsing;
-(void)connectToServiceAtIndex:(NSInteger)index;
-(void)sendCommand:(NSString*)command;
@property (strong, nonatomic, readonly) NSMutableArray *services;
@property (nonatomic, weak) id <VWWBonjourClientControllerDelegate> delegate;
@end
