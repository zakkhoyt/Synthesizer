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
  
----- Example Synthesizer use
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



