//
//  FirstTableViewCell.m
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "Common.h"

@implementation FirstTableViewCell

-(void)addsubviews
{
    mpBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 59)];
    mpBackImageView.image = [UIImage imageNamed:@"cellBack.png"];
    [self.contentView addSubview:mpBackImageView];
    
//    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 60)];
//    lpView.backgroundColor = cellBackColor;
//    lpView.userInteractionEnabled = NO;
//    [self.contentView addSubview:lpView];
    
    float start = 80.0f;
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(start, 0, (1024-60)/2-start-100, 60)];
    mpLabel.backgroundColor = [UIColor clearColor];
    mpLabel.font = [UIFont systemFontOfSize:20];
    mpLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel];
    
    mpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 60)];
    mpLabel2.backgroundColor = [UIColor clearColor];
    mpLabel2.font = [UIFont systemFontOfSize:20];
    mpLabel2.textAlignment = NSTextAlignmentCenter;

    mpLabel2.textColor = [UIColor grayColor];
    [self.contentView addSubview:mpLabel2];
    
    
    mpIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [self.contentView addSubview:mpIconImageView];
    
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake((1024-60)/2-90, 15, 50, 30)];
    mpImageView.hidden = YES;
    [self.contentView addSubview:mpImageView];
    
    mpImageViewSeperate = [[UIImageView alloc] init];
    mpImageViewSeperate.backgroundColor = cellSeparateColor;
    mpImageViewSeperate.frame=CGRectMake(0, 59, (1024-60)/2, 1);
    [self.contentView addSubview:mpImageViewSeperate];
    
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
        useBackImage = YES;
        [self addsubviews];
        // Initialization code
    }
    return self;
}

//-(void)mp

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (!useBackImage) {
        mpBackImageView.hidden = YES;
        return;
    }
    if (selected) {
        mpBackImageView.image = [UIImage imageNamed:@"cellBackDeep.png"];
    } else {
        mpBackImageView.image = [UIImage imageNamed:@"cellBack.png"];
    }


    // Configure the view for the selected state
}

@end
