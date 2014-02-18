//
//  VWWSynthesizerSettingsTableViewController.h
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/17/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWNormalizedSynthesizer.h"

@interface VWWSynthesizerSettingsTableViewController : UITableViewController
@property (nonatomic, strong) VWWNormalizedSynthesizer *normalizedSynthesizer;
@end
