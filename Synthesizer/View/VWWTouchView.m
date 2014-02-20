//
//  VWWTouchView.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWTouchView.h"
#import <QuartzCore/QuartzCore.h>



@interface VWWTouchView ()
@property (nonatomic, strong) CAEmitterLayer* fireEmitter;
@end

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

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        //set ref to the layer
        self.fireEmitter = (CAEmitterLayer*)self.layer; //2
        //configure the emitter layer
        self.fireEmitter.emitterPosition = CGPointMake(-50, -50);
        self.fireEmitter.emitterSize = CGSizeMake(10, 10);
        
        CAEmitterCell* fire = [CAEmitterCell emitterCell];
        fire.birthRate = 5.0;
        fire.lifetime = 1.0;
        fire.lifetimeRange = 0;
        fire.color = [[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.4] CGColor];
        fire.contents = (id)[[UIImage imageNamed:@"atom"] CGImage];
        [fire setName:@"fire"];
        
        fire.velocity = 10;
        fire.velocityRange = 20;
        fire.emissionRange = M_PI_2;
        
        fire.scaleSpeed = 0.3;
        fire.spin = 1.0;
        fire.spinRange = M_PI;
        
        
        fire.xAcceleration = 0.5;
        fire.yAcceleration = -0.2;
        self.fireEmitter.renderMode = kCAEmitterLayerAdditive;
        self.fireEmitter.emitterCells = [NSArray arrayWithObject:fire];
        
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
    [self setEmitterPositionFromTouch: [touches anyObject]];
    [self setIsEmitting:YES];

    
    
    [self touches:touches withEvent:event];
    NSArray *array = [self touches:touches withEvent:event];
    [self.delegate touchViewDelegate:self touchesBeganWithArray:array];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setEmitterPositionFromTouch: [touches anyObject]];
    
    [self touches:touches withEvent:event];
    NSArray *array = [self touches:touches withEvent:event];
    [self.delegate touchViewDelegate:self touchesMovedWithArray:array];

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setIsEmitting:NO];
    
    [self touches:touches withEvent:event];
    NSArray *array = [self touches:touches withEvent:event];
    [self.delegate touchViewDelegate:self touchesEndedWithArray:array];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setIsEmitting:NO];
    
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
        VWW_LOG_INFO(@"touch at normalized point %.2f,%.2f", x, y);
        NSDictionary *dictionary = @{VWWTouchViewXKey : @(x),
                                     VWWTouchViewYKey : @(y)};
        [xyArray addObject:dictionary];
    }
    return xyArray;
}


+ (Class) layerClass //3
{
    //configure the UIView to have emitter layer
    return [CAEmitterLayer class];
}

-(void)setEmitterPositionFromTouch: (UITouch*)t
{
    //change the emitter's position
    self.fireEmitter.emitterPosition = [t locationInView:self];
}

-(void)setIsEmitting:(BOOL)isEmitting
{
    //turn on/off the emitting of particles
    [self.fireEmitter setValue:[NSNumber numberWithInt:isEmitting?200:0] forKeyPath:@"emitterCells.fire.birthRate"];
}

@end
