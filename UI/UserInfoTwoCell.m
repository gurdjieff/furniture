//
//  UserInfoTwoCell.m
//  ExaminationIpad
//
//  Created by gurdjieff on 13-9-15.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "UserInfoTwoCell.h"

@implementation UserInfoTwoCell

-(void)addSubviews
{
    UIColor * color =[UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1];
    self.backgroundColor = color;
    
    float start = 10.0f;
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(start, 5, 80, 30)];
    mpLabel.backgroundColor = [UIColor clearColor];
    mpLabel.font = [UIFont systemFontOfSize:18];
    [mpLabel setBackgroundColor:[UIColor clearColor]];
    [mpLabel setTextAlignment:UITextAlignmentCenter];
    [mpLabel setTextColor:[UIColor colorWithRed:69.0/255 green:53.0/255 blue:61.0/255 alpha:1]];
    [self.contentView addSubview:mpLabel];
    
    mpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(100,5, 278, 30)];
    mpLabel2.backgroundColor = [UIColor clearColor];
    mpLabel2.font = [UIFont systemFontOfSize:18];
    mpLabel2.textColor = [UIColor darkGrayColor];
    [mpLabel2 setBackgroundColor:[UIColor clearColor]];
    [mpLabel2 setTextAlignment:UITextAlignmentRight];
    [mpLabel setTextColor:[UIColor colorWithRed:69.0/255 green:53.0/255 blue:61.0/255 alpha:1]];
    [self.contentView addSubview:mpLabel2];

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
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
