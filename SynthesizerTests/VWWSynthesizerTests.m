//
//  SynthesizerTests.m
//  SynthesizerTests
//
//  Created by Zakk Hoyt on 1/9/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//
//  These unit tests don't automatically test anything.
//  They need a human to read and listen

#import <XCTest/XCTest.h>
#import "NSTimer+Blocks.h"
#import "VWWSynthesizer.h"

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
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 frequencyLeft:440 frequencyRight:2000];
    [synth start];
    usleep(1 * 1000 * 1000);
    
    [synth stop];
    synth = nil;
    
    usleep(2 * 1000 * 1000);
}


-(void)testMultipleSynths{
    NSLog(@"Testing Multiple Synthesizers");
    VWWSynthesizer *synth1 = [[VWWSynthesizer alloc]initWithAmplitude:1.0 frequencyLeft:440 frequencyRight:2000];
    [synth1 start];
    
    VWWSynthesizer *synth2 = [[VWWSynthesizer alloc]initWithAmplitude:1.0 frequencyLeft:880 frequencyRight:4000];
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
    
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 frequencyLeft:440 frequencyRight:880];
    [synth start];
    
    usleep(500 * 1000);
    
    
    synth.frequencyLeft = 23;
    synth.frequencyRight = 343;
    usleep(500 * 1000);
    synth.frequencyLeft = 55;
    synth.frequencyLeft = 2463;
    usleep(500 * 1000);
    synth.frequencyLeft = 110;
    synth.frequencyLeft = 459;
    usleep(500 * 1000);
    synth.frequencyLeft = 220;
    synth.frequencyLeft = 9762;
    usleep(500 * 1000);
    synth.frequencyLeft = 660;
    synth.frequencyLeft = 235;
    usleep(500 * 1000);
    synth.frequencyLeft = 2309;
    synth.frequencyLeft = 2358;
    usleep(500 * 1000);
    synth.frequencyLeft = 4000;
    synth.frequencyLeft = 812;
    usleep(500 * 1000);
    synth.frequencyLeft = 8030;
    synth.frequencyLeft = 353;
    usleep(500 * 1000);
    synth.frequencyLeft = 10000;
    synth.frequencyLeft = 40;
    usleep(500 * 1000);
    synth.frequencyLeft = 12300;
    
    synth.frequencyLeft = 4646;
    usleep(500 * 1000);
    synth.frequencyLeft = 14300;
    synth.frequencyLeft = 546;
    usleep(500 * 1000);
    synth.frequencyLeft = 16300;
    synth.frequencyLeft = 2377;
    usleep(500 * 1000);
    synth.frequencyLeft = 18300;
    synth.frequencyLeft = 974;
    usleep(500 * 1000);
    
    [synth stop];
    synth = nil;
    usleep(2 * 1000 * 1000);
}

-(void)testSynthAmplitude{
    
    NSLog(@"Testing amplitude");
    
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 frequencyLeft:440 frequencyRight:880];
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
    
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 frequencyLeft:440 frequencyRight:880];
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

-(void)testSynthVWWWaveTypeSawtooth{
    NSLog(@"Testing wave type");
    
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 frequencyLeft:440 frequencyRight:880];
    [synth start];
    
    usleep(500 * 1000);
    
    synth.waveType = VWWWaveTypeSquare;
    usleep(500 * 1000);
    synth.waveType = VWWWaveTypeTriangle;
    usleep(500 * 1000);
    synth.waveType = VWWWaveTypeSawtooth;
    usleep(500 * 1000);
    
    [synth stop];
    synth = nil;
    usleep(2 * 1000 * 1000);
}


-(void)testSynthVWWEffectType{
    
    NSLog(@"Testing effect type");
    
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 frequencyLeft:440 frequencyRight:880];
    [synth start];
    
    // Produces 4 tones
    usleep(500 * 1000);
    synth.frequencyLeft = 450;
    synth.frequencyRight = 450;
    usleep(500 * 1000);
    synth.frequencyLeft = 460;
    synth.frequencyRight = 460;
    usleep(500 * 1000);
    synth.frequencyLeft = 470;
    synth.frequencyRight = 470;
    usleep(500 * 1000);
    synth.frequencyLeft = 480;
    synth.frequencyRight = 480;
    usleep(500 * 1000);
    
    
    
    synth.effectType = VWWEffectTypeAutoTune;
    
    // Produces 4 tones
    usleep(500 * 1000);
    synth.frequencyLeft = 450;
    synth.frequencyRight = 450;
    usleep(500 * 1000);
    synth.frequencyLeft = 460;
    synth.frequencyRight = 460;
    usleep(500 * 1000);
    synth.frequencyLeft = 470;
    synth.frequencyRight = 470;
    usleep(500 * 1000);
    synth.frequencyLeft = 480;
    synth.frequencyRight = 480;
    usleep(500 * 1000);
    
    [synth stop];
    synth = nil;
    usleep(2 * 1000 * 1000);
}

-(void)testSynthIncreasingFrequency{
    NSLog(@"Testing frequency increase ");
    NSInteger f = 20;
    VWWSynthesizer *synth = [[VWWSynthesizer alloc]initWithAmplitude:1.0 frequencyLeft:440 frequencyRight:880];
    [synth start];
    
    for(NSInteger i = 20; i < 100; i++){
        usleep(10 * 1000);
        f+=20;
        synth.frequencyLeft = f;
        synth.frequencyRight = f;
    }
    
    [synth stop];
    synth = nil;
    usleep(2 * 1000 * 1000);

}


-(void)testSynthDictionaryExportImport{
    NSLog(@"Testing dictionary export and import");
    VWWSynthesizer *synth1 = [[VWWSynthesizer alloc]initWithAmplitude:1.0 frequencyLeft:440 frequencyRight:880];
    synth1.waveType = VWWWaveTypeSquare;
    synth1.effectType = VWWEffectTypeAutoTune;
    synth1.amplitude = 0.5;
    [synth1 start];
    usleep(1 * 1000 * 1000);
    [synth1 stop];
    NSLog(@"Exporting sythesizer to dictionary");
    NSDictionary *dictionaryExport = [synth1 dictionaryRepresentation];
    [[NSUserDefaults standardUserDefaults] setObject:dictionaryExport forKey:@"synth"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    synth1 = nil;
    
    usleep(1 * 1000 * 1000);

    NSLog(@"Creating new synth from dictionary");
    NSDictionary *dictionaryImport = [[NSUserDefaults standardUserDefaults]objectForKey:@"synth"];
    VWWSynthesizer *synth2 = [[VWWSynthesizer alloc]initWithDictionary:dictionaryImport];
    [synth2 start];
    usleep(1 * 1000 * 1000);
    [synth2 stop];
    synth2 = nil;
    
}

@end
