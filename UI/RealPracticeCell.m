//
//  RealPracticeCell.m
//  ExaminationIpad
//
//  Created by gurd on 13-8-15.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "RealPracticeCell.h"
#import "Common.h"

@implementation RealPracticeCell

-(void)addsubviews
{
    mpBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 59)];
    mpBackImageView.image = [UIImage imageNamed:@"cellBack.png"];
    [self.contentView addSubview:mpBackImageView];

//    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 60)];
//    lpView.backgroundColor = cellBackColor;
//    lpView.userInteractionEnabled = NO;
//    [self.contentView addSubview:lpView];
    
    
    float start = 20.0f;
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(start, 0, (1024-60)/2-start-50, 60)];
    mpLabel.backgroundColor = [UIColor clearColor];
    mpLabel.font = [UIFont boldSystemFontOfSize:20];
    mpLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel];
    
    
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    [self.contentView addSubview:mpImageView];
    
    mpStateBtn = [[UIButton alloc] initWithFrame:CGRectMake((1024-60)/2-120, 10, 80, 40)];
    [self.contentView addSubview:mpStateBtn];
    mpStateBtn.hidden = YES;
    mpStateBtn.userInteractionEnabled = NO;

    
    mpImageViewSeperate = [[UIImageView alloc] init];
    mpImageViewSeperate.backgroundColor = cellSeparateColor;
    mpImageViewSeperate.frame=CGRectMake(0, 59, (1024-60)/2, 1);
    [self.contentView addSubview:mpImageViewSeperate];
}

-(void)resetLabel
{
    float start = 80.0f;
    mpLabel.frame = CGRectMake(start, 0, (1024-60)/2-start-40, 60);
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
    
    if (selected) {
        mpBackImageView.image = [UIImage imageNamed:@"cellBackDeep.png"];
    } else {
        mpBackImageView.image = [UIImage imageNamed:@"cellBack.png"];
    }// Configure the view for the selected state
}

@end
