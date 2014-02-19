//
//  VWWWelcomeViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/17/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWWelcomeViewController.h"

static NSString *VWWSegueWelcomeToTouch = @"VWWSegueWelcomeToTouch";

@interface VWWWelcomeViewController ()

@end

@implementation VWWWelcomeViewController

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
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    if([VWWUserDefaults hasShownWelcomeScreen]){
        [self performSegueWithIdentifier:VWWSegueWelcomeToTouch sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneButtonTouchUpInside:(id)sender {
    [VWWUserDefaults setHasShownWelcomeScreen:YES];
    [self performSegueWithIdentifier:VWWSegueWelcomeToTouch sender:self];
}

@end
