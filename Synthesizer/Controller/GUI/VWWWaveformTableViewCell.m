//
//  VWWWaveformTableViewCell.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/19/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWWaveformTableViewCell.h"
#import "VWWSynthesizerTypes.h"

@interface VWWWaveformTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *wavetypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *wavetypeLabel;

@end

@implementation VWWWaveformTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setWavetype:(VWWWaveType)wavetype{
    _wavetype = wavetype;
    
    
    if(_wavetype == VWWWaveTypeSine){
        self.wavetypeImageView.image = [UIImage imageNamed:@"sine"];
        self.wavetypeLabel.text = @"Sine";
    } else if(_wavetype == VWWWaveTypeSquare){
        self.wavetypeImageView.image = [UIImage imageNamed:@"square"];
        self.wavetypeLabel.text = @"Square";
    } else if(_wavetype == VWWWaveTypeTriangle){
        self.wavetypeImageView.image = [UIImage imageNamed:@"triangle"];
        self.wavetypeLabel.text = @"Triangle";
    } else if(_wavetype == VWWWaveTypeSawtooth){
        self.wavetypeImageView.image = [UIImage imageNamed:@"sawtooth"];
        self.wavetypeLabel.text = @"Sawtooth";
    } else {
        self.wavetypeImageView.image = nil;
        self.wavetypeLabel.text = @"None";
    }
    
    
    
}
@end
