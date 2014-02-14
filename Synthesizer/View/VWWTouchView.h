//
//  VWWTouchView.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *VWWTouchViewXKey = @"x";
static NSString *VWWTouchViewYKey = @"y";

@class VWWTouchView;

@protocol VWWTouchViewDelegate <NSObject>
-(void)touchViewDelegate:(VWWTouchView*)sender touchesBeganWithArray:(NSArray*)array;
-(void)touchViewDelegate:(VWWTouchView*)sender touchesMovedWithArray:(NSArray*)array;
-(void)touchViewDelegate:(VWWTouchView*)sender touchesEndedWithArray:(NSArray*)array;
@end

@interface VWWTouchView : UIView
-(void)setEmitterPositionFromTouch:(UITouch*)t;
-(void)setIsEmitting:(BOOL)isEmitting;

@property (nonatomic, weak) id <VWWTouchViewDelegate> delegate;
@end
