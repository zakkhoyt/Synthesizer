//
//  VWWAboutViewController.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/17/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWAboutViewController.h"
#import "MBProgressHUD.h"

@interface VWWAboutViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@end

@implementation VWWAboutViewController

-(void)viewDidLoad{
    [super viewDidLoad];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    NSString *htmlString = @"<html>"
//    @"<body bgcolor=\"#000000\" text=\"#FFFFFF\" link=\"#00FF00\">"
//    @"<h3>Motion Sensor Theremin:</h3>"
//    @"About:<br>"
//    @"The theremin (originally known as the ætherphone/etherphone or termenvox/thereminvox) is an early electronic musical instrument controlled without physical contact by the thereminist (performer). It is named after the westernized name of its Russian inventor, Léon Theremin, who patented the device in 1928.<br>"
//    @"<br>"
//    @"The instrument's controlling section usually consists of two metal antennas which sense the relative position of the thereminist's hands and control oscillators for frequency with one hand, and amplitude (volume) with the other. The electric signals from the theremin are amplified and sent to a loudspeaker.<br>"
//    @"<br>"
//    @"The Motion Sensor Theremin iOS App uses the device's motion sensors and touchscreen (instead of capacitance and antennaes) to modify the frequency of the output waveform. Inputs include touchscreen (x,y), accelerometers (x,y,z), gyroscopes (x,y,z), and the magnetometers (x,y,z). For each individual axis you can adjust max/min frequency, sensitivity, waveform, and effects.<br>"
//    @"<br>"
//    @"The synthesizer itself is very basic and is based off of the mathematical sine function. The synthisizer is available as an open source stand-alone Objective-C library for use in any project you can think of. It is included as a subdirectory in the source code for this project.<br>"
//    @"<br>"
//    @"<a href=\"https://itunes.apple.com/us/app/motion-sensor-theremin-free/id570320684?mt=8\">iTunes Page</a><br>"
//    @"<br>"
//    @"<h3>Links:</h3>"
//    @"<ul>"
//    @"<li>Author: <a href=\"http://vaporwarewolf.com/WP_Test/\">Zakk Hoyt (VaporWareWolf Software)</a></li>"
//    @"<li>Email: <a href=\"mailto:vaporwarewolf@gmail.com\">vaporwarewolf@gmail.com</a></li>"
//    @"<li>Source Code: <a href=\"https://github.com/zakkhoyt/Synthesizer\">github.com/zakkhoyt/Synthesizer</a></li>"
//    @"</ul>"
//    @"</body>"
//    @"</html>";
//    [self.webView loadHTMLString:htmlString baseURL:nil];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    self.backgroundImageView.image = [UIImage imageNamed:@"LaunchImage"];
}
@end
