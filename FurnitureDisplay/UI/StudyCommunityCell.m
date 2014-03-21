//
//  StudyCommunityCell.m
//  ExaminationIpad
//
//  Created by gurd on 13-9-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "StudyCommunityCell.h"
#import "BaseViewController.h"

@implementation StudyCommunityCell

-(void)addsubviews
{
    mpBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 59)];
    mpBackImageView.image = [UIImage imageNamed:@"cellBack.png"];
    [self.contentView addSubview:mpBackImageView];

    float start = 60.0f;
    float width = (appFrameWidth-60)/2;
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [self.contentView addSubview:mpImageView];
    
    mpLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(start, 5, 140, 20)];
    mpLabel1.backgroundColor = [UIColor clearColor];
    mpLabel1.font = [UIFont boldSystemFontOfSize:18];
    mpLabel1.textColor = yellowColor;
    [self.contentView addSubview:mpLabel1];
    
    mpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(width-180, 5, 160, 20)];
//    mpLabel2.textAlignment = NSTextAlignmentRight;
    mpLabel2.backgroundColor = [UIColor clearColor];
    mpLabel2.font = [UIFont systemFontOfSize:14];
    mpLabel2.textColor = [UIColor grayColor];
    [self.contentView addSubview:mpLabel2];
    
    mpLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, width-80, 65)];
    mpLabel3.backgroundColor = [UIColor clearColor];
    mpLabel3.font = labelFont;
    mpLabel3.numberOfLines = 0;
    mpLabel3.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel3];
    
    mpLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(width-180, mpLabel3.buttom, 160, 20)];
//    mpLabel4.textAlignment = NSTextAlignmentRight;
    mpLabel4.backgroundColor = [UIColor clearColor];
    mpLabel4.font = [UIFont systemFontOfSize:14];
    mpLabel4.textColor = [UIColor grayColor];
    mpLabel4.hidden = YES;
    [self.contentView addSubview:mpLabel4];
    
    mpLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, width-80, 65)];
    mpLabel5.backgroundColor = [UIColor clearColor];
    mpLabel5.font = labelFont;
    mpLabel5.numberOfLines = 0;
    mpLabel5.textColor = [UIColor grayColor];
    [self.contentView addSubview:mpLabel5];


    mpImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(160, 10, 19, 19)];
    mpImageView1.image = [UIImage imageNamed:@"clock.png"];
    [self.contentView addSubview:mpImageView1];

    mpImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(300, 10, 19, 19)];
    mpImageView2.image = [UIImage imageNamed:@"eye.png"];
    [self.contentView addSubview:mpImageView2];

    mpImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(400, 10, 19, 19 )];
    mpImageView3.image = [UIImage imageNamed:@"comment.png"];
    [self.contentView addSubview:mpImageView3];

    
    UIImageView* lpImageView=[[UIImageView alloc]
                              initWithImage:[UIImage imageNamed:@"separatorWhite.png"]];
    lpImageView.frame=CGRectMake(0, 0, width, 1);
    [self.contentView addSubview:lpImageView];
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
    if (!useBackImage) {
        mpBackImageView.hidden = YES;
        return;
    }
    if (selected) {
        mpBackImageView.image = [UIImage imageNamed:@"cellBackDeep.png"];
    } else {
        mpBackImageView.image = [UIImage imageNamed:@"cellBack.png"];
    }
}

@end
