//
//  VWWTouchViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWTouchViewController.h"
#import "VWWTouchView.h"
#import "VWWNormalizedSynthesizer.h"


static NSString *VWWSegueTouchToSettings = @"VWWSegueTouchToSettings";

@interface VWWTouchViewController () <VWWTouchViewDelegate>
@property (weak, nonatomic) IBOutlet VWWTouchView *touchView;
@property (nonatomic, strong) VWWNormalizedSynthesizer *touchSynthX;
@property (nonatomic, strong) VWWNormalizedSynthesizer *touchSynthY;
@end

@implementation VWWTouchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.touchSynthX = [[VWWNormalizedSynthesizer alloc]initWithAmplitude:1.0 frequencyMin:30 frequencyMax:500 frequencyNormalized:0.5];
    self.touchSynthY = [[VWWNormalizedSynthesizer alloc]initWithAmplitude:1.0 frequencyMin:30 frequencyMax:500 frequencyNormalized:0.5];
    self.touchSynthX.muted = YES;
    self.touchSynthY.muted = YES;
    [self.touchSynthX start];
    [self.touchSynthY start];
    self.touchView.delegate = self;
    
    [self addGestureRecognizers];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:VWWSegueTouchToSettings]){
//        
//    }
//}

#pragma mark Private methods


-(void)addGestureRecognizers{
    // Gesture recognizer
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureHandler:)];
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureHandler:)];
    [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];
    
    UITapGestureRecognizer *twoFingerTripleTapGestureHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerTripleTapGestureHandler:)];
    twoFingerTripleTapGestureHandler.numberOfTapsRequired = 3;
    twoFingerTripleTapGestureHandler.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:twoFingerTripleTapGestureHandler];
    
    [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
}



-(void)singleTapGestureHandler:(UIGestureRecognizer*)gestureRecognizer{
    VWW_LOG_INFO(@"Single Tap");

}

-(void)doubleTapGestureHandler:(UIGestureRecognizer*)gestureRecognizer{
    VWW_LOG_INFO(@"Double Tap");
}

- (void)twoFingerTripleTapGestureHandler:(UITapGestureRecognizer*)recognizer {
    VWW_LOG_INFO(@"Settings tap");
    [self performSegueWithIdentifier:VWWSegueTouchToSettings sender:self];
}


-(void)updateFrequenciesWithArray:(NSArray*)array{
    for(NSDictionary *dictionary in array){
        NSNumber *x = dictionary[VWWTouchViewXKey];
        NSNumber *y = dictionary[VWWTouchViewYKey];
        self.touchSynthX.frequencyNormalized = x.floatValue;
        self.touchSynthY.frequencyNormalized = y.floatValue;
    }

}

#pragma mark VWWTouchViewDelegate
-(void)touchViewDelegate:(VWWTouchView*)sender touchesBeganWithArray:(NSArray*)array{
    self.touchSynthX.muted = NO;
    self.touchSynthY.muted = NO;
    [self updateFrequenciesWithArray:array];
}

-(void)touchViewDelegate:(VWWTouchView*)sender touchesMovedWithArray:(NSArray*)array{
    [self updateFrequenciesWithArray:array];
}

-(void)touchViewDelegate:(VWWTouchView*)sender touchesEndedWithArray:(NSArray*)array{
    [self updateFrequenciesWithArray:array];
    self.touchSynthX.muted = YES;
    self.touchSynthY.muted = YES;
}

@end
