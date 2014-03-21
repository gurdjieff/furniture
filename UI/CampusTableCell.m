//
//  CampusTableCell.m
//  ExaminationIpad
//
//  Created by gurdjieff on 13-8-17.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "CampusTableCell.h"

@implementation CampusTableCell

-(void)addsubviews
{
    mpBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, (1024-60)/2-60, 60)];
    mpBackImageView.image = [UIImage imageNamed:@"cellBack.png"];
    [self.contentView addSubview:mpBackImageView];
    
//    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 60)];
//    lpView.backgroundColor = cellBackColor;
//    lpView.userInteractionEnabled = NO;
//    [self.contentView addSubview:lpView];
    
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 70)];
    mpLabel.textAlignment = NSTextAlignmentCenter;
    mpLabel.backgroundColor = [UIColor clearColor];
    mpLabel.font = [UIFont boldSystemFontOfSize:20];
    mpLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:mpLabel];
    
    
//    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
//    [self.contentView addSubview:mpImageView];
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
        mpBackImageView.image = [UIImage imageNamed:@"comapusCellG.png"];
    } else {
        mpBackImageView.image = [UIImage imageNamed:@"campusCellW.png"];
    }// Configure the view for the selected state
}

@end
