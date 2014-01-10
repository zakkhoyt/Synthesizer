//
//  README.txt
//  Synthesizer
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//


----- Requirements
* Add the Synthesizer folder to your project
* Link to the folling frameworks:
  - AudioToolbox
  - CoreAudio
  
----- Example standard synthesizer use
----- Specify a frequency directly
To create a simple synth channel:

#import "VWWSynthesizer.h"

// Create synth and start
-(void)viewDidLoad{
    [super viewDidLoad];

    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 andFrequency:440.0];
    [synth start];
}

// Cleanup
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

    [synth stop];
    synth = nil;
}


----- Example normalized synthesizer use
----- This operates just like the standard synthesizer except instead of specifying a frequency, you set fMin, fMax, and then a fNormalized from 0.0 - 1.0
To create a simple synth channel:

#import "VWWNormalizedSynthesizer.h"

// Create synth and start
-(void)viewDidLoad{
    [super viewDidLoad];

    VWWNormalizedSynthesizer *synth = [[VWWNormalizedSynthesizer alloc]initWithFrequencyMin:30 frequencyMax:2000 frequencyNormalized:0.4];
    [synth start];
}

// Cleanup
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

    [synth stop];
    synth = nil;
}


----- Both types of synthesizers remainin parameters and operations are identical 


