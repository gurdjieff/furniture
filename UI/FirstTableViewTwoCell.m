//
//  FirstTableViewTwoCell.m
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FirstTableViewTwoCell.h"
#import "Common.h"

@implementation FirstTableViewTwoCell
-(void)addsubviews
{
    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 60)];
    lpView.backgroundColor = cellBackColor;
    lpView.userInteractionEnabled = NO;
    [self.contentView addSubview:lpView];
        
    UIImageView* lpImageView=[[UIImageView alloc]
                              initWithFrame:CGRectMake(0, 59, (1024-60)/2, 1)];
    lpImageView.backgroundColor = cellSeparateColor;
    [self.contentView addSubview:lpImageView];
    
    float start = 60.0f;
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(start, 0, (1024-60)/2-start-100, 60)];
    mpLabel.backgroundColor = [UIColor clearColor];
    mpLabel.font = [UIFont boldSystemFontOfSize:20];
    mpLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel];
    
    mpIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [self.contentView addSubview:mpIconImageView];
    
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake((1024-60)/2-90, 15, 50, 30)];
    mpImageView.hidden = YES;
    [self.contentView addSubview:mpImageView];
    
    alreadPay = [[UILabel alloc] initWithFrame:CGRectMake((1024-60)/2-100, 0, 100, 60)];
    alreadPay.backgroundColor = [UIColor clearColor];
    alreadPay.text = @"付费";
    alreadPay.font = [UIFont systemFontOfSize:16];
    alreadPay.textAlignment = NSTextAlignmentCenter;
    alreadPay.textColor = [UIColor redColor];
    alreadPay.hidden = YES;
    [self.contentView addSubview:alreadPay];

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addsubviews];
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
