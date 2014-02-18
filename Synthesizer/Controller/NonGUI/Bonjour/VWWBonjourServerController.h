//
//  VWWBonjourServerController.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/14/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>


@class VWWBonjourServerController;

@protocol VWWBonjourServerControllerDelegate <NSObject>
-(void)bonjourControllerDidStartBroadcasting:(VWWBonjourServerController*)sender;
-(void)bonjourController:(VWWBonjourServerController*)sender didPublishService:(NSNetService*)service;
-(void)bonjourController:(VWWBonjourServerController*)sender didConnectToClient:(NSNetService*)service;
-(void)bonjourController:(VWWBonjourServerController*)sender didRecieveCommand:(NSString*)command;
-(void)bonjourController:(VWWBonjourServerController*)sender service:(NSNetService*)service errorOccurred:(NSError*)error;
@end

@interface VWWBonjourServerController : NSObject
+(VWWBonjourServerController*)sharedInstance;
-(void)startBroadcast;
@property (nonatomic, weak) id <VWWBonjourServerControllerDelegate> delegate;
@end
