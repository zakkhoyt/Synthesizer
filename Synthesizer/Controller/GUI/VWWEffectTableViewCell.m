//
//  VWWEffectTableViewCell.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/19/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWEffectTableViewCell.h"

@interface VWWEffectTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *effectTypeLabel;

@end


@implementation VWWEffectTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEffectType:(VWWEffectType)effectType{
    _effectType = effectType;
    if(_effectType == VWWEffectTypeNone){
        self.effectTypeLabel.text = @"None";
    } else if(_effectType == VWWEffectTypeAutoTune){
        self.effectTypeLabel.text = @"Autotune";
    }
}

@end
