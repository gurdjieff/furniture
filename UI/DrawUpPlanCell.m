//
//  DrawUpPlanCell.m
//  Examination
//
//  Created by Zhang Bo on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "DrawUpPlanCell.h"

@implementation DrawUpPlanCell
@synthesize leftLabel = _leftLabel;
@synthesize rightLabel = _rightLabel;
@synthesize cellStyle = _cellStyle;
@synthesize rightTextField = _rightTextField;
@synthesize delegate = _delegate;
@synthesize isGetSource = _isGetSource;



- (void)dealloc
{
    _delegate = nil;
    [_rightTextField release];
    [_leftLabel release];
    [_rightLabel release];
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
        [_leftLabel setFrame:CGRectMake(10, 5, 100, 30)];
        [[self contentView] addSubview:_leftLabel];
                
        CGRect btnframe = CGRectMake(120, 5, 190, 30);

        _rightLabel =[[UILabel alloc] init];
        [_rightLabel setFont:[UIFont systemFontOfSize:13]];
        [_rightLabel setTextColor:[UIColor grayColor]];
        [_rightLabel setBackgroundColor:[UIColor clearColor]];
        [_rightLabel setTextAlignment:UITextAlignmentLeft];
        [_rightLabel setFrame:btnframe];
        [[self contentView] addSubview:_rightLabel];
        
             
        _rightTextField =[[UITextField alloc] init];
        [_rightTextField setFont:[UIFont systemFontOfSize:18]];
        [_rightTextField setTextColor:[UIColor blackColor]];
        [_rightTextField setBackgroundColor:[UIColor whiteColor]];
        [_rightTextField setTextAlignment:UITextAlignmentLeft];
        [_rightTextField setFrame:btnframe];
        [[self contentView] addSubview:_rightTextField];
        
        comboboxBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [comboboxBtn setFrame:btnframe];
        [[self contentView] addSubview:comboboxBtn];

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)drawRect:(CGRect)rect
{
    
    
   
    
    
    if (_cellStyle == 0)
    {
        [comboboxBtn setFrame:CGRectZero];
    }else
    {
        
        [comboboxBtn addTarget:self action:@selector(appearPicker:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
    if (_cellStyle==1) {
        
        if(_isGetSource)
        {
            CGRect frame = CGRectMake(120, 5, 190, 30);
            [_rightTextField setFrame:frame];
            [_rightLabel setFrame:CGRectMake(120, 32, 190, 30)];
            
        }
        else
        {
            
            CGRect frame = CGRectMake(120, 5, 190, 30);
            [_rightLabel setFrame:frame];
            [_rightTextField setFrame:frame];
            
        }
    }
    
   
    
}




-(void)appearPicker:(id)sender
{
    NSLog(@"%s",__func__);
    
    
    
    
    if (_delegate != nil
        && [_delegate respondsToSelector:@selector(WillAppeare:)])
    {
        [_delegate WillAppeare:_cellStyle];
    }

}


@end
