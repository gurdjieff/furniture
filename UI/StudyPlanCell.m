//
//  StudyPlanCell.m
//  ExaminationIpad
//
//  Created by gurd on 13-11-12.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "StudyPlanCell.h"
#import <QuartzCore/QuartzCore.h>
#import "Common.h"
#import "BaseViewController.h"

@implementation StudyPlanCell

-(void)addsubviews
{
    mpBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, (1024-60)/2-20, 90)];
//    mpBackImageView.image = [UIImage imageNamed:@"cellBack.png"];
    mpBackImageView.backgroundColor = [UIColor whiteColor];
    mpBackImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    mpBackImageView.layer.borderWidth = 1;
    mpBackImageView.layer.cornerRadius = 8;

    [self.contentView addSubview:mpBackImageView];
    
    
    //    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 60)];
    //    lpView.backgroundColor = cellBackColor;
    //    lpView.userInteractionEnabled = NO;
    //    [self.contentView addSubview:lpView];
    
    
    float start = 20.0f;
    
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(start, 15, 30, 30)];
    [self.contentView addSubview:mpImageView];
    
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(mpImageView.right + 5, 20, (1024-60)/2-100, 40)];
    mpLabel.backgroundColor = [UIColor clearColor];
    mpLabel.font = [UIFont boldSystemFontOfSize:20];
    mpLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel];
    
    mpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(150, mpLabel.buttom, (1024-60)/2-200, 20)];
    mpLabel2.backgroundColor = [UIColor clearColor];
    mpLabel2.font = [UIFont boldSystemFontOfSize:18];
    mpLabel2.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:mpLabel2];
    
    mpTextField = [[UITextField alloc] initWithFrame:CGRectMake(mpImageView.right + 100, 45, 280, 40)];
    mpTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    mpTextField.backgroundColor = [UIColor whiteColor];
    mpTextField.hidden = YES;
//    mpTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:mpTextField];
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
