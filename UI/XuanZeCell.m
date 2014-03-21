//
//  XuanZeCell.m
//  Examination
//
//  Created by Zhang Bo on 13-8-7.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "XuanZeCell.h"

@implementation XuanZeCell
@synthesize rightLabel = _rightLabel;
@synthesize midLabel = _midLabel;
@synthesize leftLabel = _leftLabel;

-(void)dealloc
{
    [_rightLabel release];
    [_midLabel release];
    [_leftLabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _leftLabel =[[UILabel alloc] init];
        [_leftLabel setFont:[UIFont systemFontOfSize:18]];
        [_leftLabel setTextColor:[UIColor blackColor]];
        [_leftLabel setBackgroundColor:[UIColor clearColor]];
        [_leftLabel setTextAlignment:UITextAlignmentRight];
        [_leftLabel setText:@"每天学"];
        [_leftLabel setFrame:CGRectMake(10, 5, 100, 30)];
        [[self contentView]  addSubview:_leftLabel];
        
        
        
        _midLabel =[[UILabel alloc] init];
        [_midLabel setFont:[UIFont systemFontOfSize:18]];
        [_midLabel setTextColor:[UIColor orangeColor]];
        [_midLabel setBackgroundColor:[UIColor clearColor]];
        [_midLabel setTextAlignment:UITextAlignmentCenter];
        [_midLabel setText:@""];
        [_midLabel setFrame:CGRectMake(110, 5, 50, 30)];
        [[self contentView]  addSubview:_midLabel];
        
        
        
        _rightLabel =[[UILabel alloc] init];
        [_rightLabel setFont:[UIFont systemFontOfSize:18]];
        [_rightLabel setTextColor:[UIColor blackColor]];
        [_rightLabel setBackgroundColor:[UIColor clearColor]];
        [_rightLabel setTextAlignment:UITextAlignmentLeft];
        [_rightLabel setText:@"个知识点"];
        [_rightLabel setFrame:CGRectMake(160, 5,120, 30)];
        [[self contentView]  addSubview:_rightLabel];
        
      
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
