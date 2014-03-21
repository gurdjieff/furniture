//
//  CommentCell.m
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "CommentCell.h"
#import "Common.h"
#import "BaseViewController.h"

@implementation CommentCell
-(void)addsubviews
{
    float start = 60.0f;
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    [self.contentView addSubview:mpImageView];
    
    mpLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(start, 5, 140, 20)];
    mpLabel1.backgroundColor = [UIColor clearColor];
    mpLabel1.font = [UIFont boldSystemFontOfSize:18];
    mpLabel1.textColor = yellowColor;
    [self.contentView addSubview:mpLabel1];
    
    mpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(appFrameWidth-60-180, 5, 160, 20)];
    mpLabel2.textAlignment = NSTextAlignmentRight;
    mpLabel2.backgroundColor = [UIColor clearColor];
    mpLabel2.font = [UIFont boldSystemFontOfSize:14];
    mpLabel2.textColor = [UIColor grayColor];
    [self.contentView addSubview:mpLabel2];
    
    mpLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, appFrameWidth-60-80, 65)];
    mpLabel3.backgroundColor = [UIColor clearColor];
    mpLabel3.font = commentFont;
    mpLabel3.numberOfLines = 0;
    mpLabel3.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel3];
    
    UIImageView* lpImageView=[[UIImageView alloc]
                              initWithImage:[UIImage imageNamed:@"separatorWhite.png"]];
    lpImageView.frame=CGRectMake(0, 0, appFrameWidth-60, 1);
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

    // Configure the view for the selected state
}

@end
