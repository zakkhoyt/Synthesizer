//
//  VWWTouchView.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWTouchView.h"


@implementation VWWTouchView


#pragma mark UIView overrides
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touches:touches withEvent:event];
    NSArray *array = [self touches:touches withEvent:event];
    [self.delegate touchViewDelegate:self touchesBeganWithArray:array];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touches:touches withEvent:event];
    NSArray *array = [self touches:touches withEvent:event];
    [self.delegate touchViewDelegate:self touchesMovedWithArray:array];

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touches:touches withEvent:event];
    NSArray *array = [self touches:touches withEvent:event];
    [self.delegate touchViewDelegate:self touchesEndedWithArray:array];
}


#pragma mark Private methods
-(NSArray*)touches:(NSSet *)touches withEvent:(UIEvent *)event{
    NSMutableArray *xyArray = [@[]mutableCopy];
    for(UITouch *touch in touches.allObjects){
        CGPoint point = [touch locationInView:self];
        float x = point.x / self.bounds.size.width;
        float y = 1.0 - (point.y / self.bounds.size.height);
        NSLog(@"touch at normalized point %.2f,%.2f", x, y);
        NSDictionary *dictionary = @{VWWTouchViewXKey : @(x),
                                     VWWTouchViewYKey : @(y)};
        [xyArray addObject:dictionary];
    }
    return xyArray;
}

@end
