//
//  SynthesizerTests.m
//  SynthesizerTests
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSTimer+Blocks.h"

#import "VWWSynthesizer.h"


//#import "VWWSynthesizerInput.h"
//#import "VWWSynthesizerInputs.h"

@interface SynthesizerTests : XCTestCase

@end

@implementation SynthesizerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testSynthInitAndRun{

    NSLog(@"Testing Init and Run");
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 andFrequency:440.0];
    [synth start];
    usleep(1 * 1000 * 1000);
    
    [synth stop];
    synth = nil;
    
    usleep(2 * 1000 * 1000);
}


-(void)testMultipleSynths{
    NSLog(@"Testing Multiple Synthesizers");
    VWWSynthesizer *synth1 = [[VWWSynthesizer alloc]initWithAmplitude:1.0 andFrequency:440];
    [synth1 start];
    
    VWWSynthesizer *synth2 = [[VWWSynthesizer alloc]initWithAmplitude:1.0 andFrequency:2000];
    [synth2 start];
    
    usleep(1 * 1000 * 1000);
    
    [synth1 stop];
    [synth2 stop];
    
    synth1 = nil;
    synth2 = nil;
    usleep(2 * 1000 * 1000);
}



-(void)testSynthFrequency{
    NSLog(@"Testing frequency");
    
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 andFrequency:440.0];
    [synth start];
    
    usleep(500 * 1000);
    
    
    synth.frequency = 23;
    usleep(500 * 1000);
    synth.frequency = 55;
    usleep(500 * 1000);
    synth.frequency = 110;
    usleep(500 * 1000);
    synth.frequency = 220;
    usleep(500 * 1000);
    synth.frequency = 660;
    usleep(500 * 1000);
    synth.frequency = 2309;
    usleep(500 * 1000);
    synth.frequency = 4000;
    usleep(500 * 1000);
    synth.frequency = 8030;
    usleep(500 * 1000);
    synth.frequency = 10000;
    usleep(500 * 1000);
    synth.frequency = 12300;
    usleep(500 * 1000);
    synth.frequency = 14300;
    usleep(500 * 1000);
    synth.frequency = 16300;
    usleep(500 * 1000);
    synth.frequency = 18300;
    usleep(500 * 1000);
    
    [synth stop];
    synth = nil;
    usleep(2 * 1000 * 1000);
}

-(void)testSynthAmplitude{
    
    NSLog(@"Testing amplitude");
    
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 andFrequency:440.0];
    [synth start];

    usleep(500 * 1000);

    synth.amplitude = 0.8;
    usleep(500 * 1000);
    synth.amplitude = 0.6;
    usleep(500 * 1000);
    synth.amplitude = 0.4;
    usleep(500 * 1000);
    synth.amplitude = 0.2;
    usleep(500 * 1000);
    synth.amplitude = 0.0;
    usleep(500 * 1000);
    synth.amplitude = 1.0;
    usleep(500 * 1000);

    [synth stop];
    synth = nil;
    usleep(2 * 1000 * 1000);
}


-(void)testSynthMute{
    
    NSLog(@"Testing mute");
    
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 andFrequency:440.0];
    [synth start];
    
    usleep(500 * 1000);
    
    synth.muted = YES;
    usleep(500 * 1000);
    synth.muted = NO;
    usleep(500 * 1000);
    synth.muted = YES;
    usleep(500 * 1000);
    synth.muted = NO;
    usleep(500 * 1000);
    synth.muted = YES;
    usleep(500 * 1000);
    synth.muted = NO;
    usleep(500 * 1000);

    
    [synth stop];
    synth = nil;
    usleep(2 * 1000 * 1000);
}

-(void)testSynthWaveType{
    NSLog(@"Testing wave type");
    
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 andFrequency:440.0];
    [synth start];
    
    usleep(500 * 1000);
    
    synth.waveType = kWaveSquare;
    usleep(500 * 1000);
    synth.waveType = kWaveTriangle;
    usleep(500 * 1000);
    synth.waveType = kWaveSawtooth;
    usleep(500 * 1000);
    
    [synth stop];
    synth = nil;
    usleep(2 * 1000 * 1000);
}


-(void)testSynthEffectType{
    
    NSLog(@"Testing effect type");
    
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 andFrequency:440.0];
    [synth start];
    
    // Produces 4 tones
    usleep(500 * 1000);
    synth.frequency = 450;
    usleep(500 * 1000);
    synth.frequency = 460;
    usleep(500 * 1000);
    synth.frequency = 470;
    usleep(500 * 1000);
    synth.frequency = 480;
    usleep(500 * 1000);
    
    
    
    synth.effectType = kEffectAutoTune;
    
    // Produces only 2 tones as they are mapped to the nearest note
    usleep(500 * 1000);
    synth.frequency = 450;
    usleep(500 * 1000);
    synth.frequency = 460;
    usleep(500 * 1000);
    synth.frequency = 470;
    usleep(500 * 1000);
    synth.frequency = 480;
    usleep(500 * 1000);
    
    [synth stop];
    synth = nil;
    usleep(2 * 1000 * 1000);
}



@end
