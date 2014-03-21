//
//  MistakeProblemCell.m
//  ExaminationIpad
//
//  Created by gurdjieff on 13-8-17.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "MistakeProblemCell.h"
#import "Common.h"

@implementation MistakeProblemCell

-(void)addsubviews
{
//    mpBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 59)];
//    mpBackImageView.image = [UIImage imageNamed:@"cellBack.png"];
//    [self.contentView addSubview:mpBackImageView];
    
    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (1024-60), 60)];
    lpView.backgroundColor = cellBackColor;
    lpView.userInteractionEnabled = NO;
    [self.contentView addSubview:lpView];
    
    
    float start = 40.0f;
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(start, 0, (1024-60)-start, 60)];
    mpLabel.backgroundColor = [UIColor clearColor];
    mpLabel.font = [UIFont boldSystemFontOfSize:20];
    mpLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel];
    
    mpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(1024-60-230, 0, 200, 60)];
    mpLabel2.backgroundColor = [UIColor clearColor];
    mpLabel2.textAlignment = NSTextAlignmentRight;
    mpLabel2.font = [UIFont boldSystemFontOfSize:20];
    mpLabel2.textColor = yellowColor;
    [self.contentView addSubview:mpLabel2];
    
    mpLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(1024-60-400, 0, 300, 60)];
    mpLabel3.backgroundColor = [UIColor clearColor];
    mpLabel3.textAlignment = NSTextAlignmentRight;
    mpLabel3.font = [UIFont boldSystemFontOfSize:20];
    mpLabel3.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:mpLabel3];
    
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    [self.contentView addSubview:mpImageView];
    
    mpImageViewSeperate = [[UIImageView alloc] init];
    mpImageViewSeperate.backgroundColor = cellSeparateColor;
    mpImageViewSeperate.frame=CGRectMake(0, 59, (1024-60), 1);
    [self.contentView addSubview:mpImageViewSeperate];
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
