//
//  CustomBtnOne.m
//  ExaminationIpad
//
//  Created by gurd on 13-8-15.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "CustomBtnOne.h"
#import "Common.h"
#import "BaseViewController.h"

@implementation CustomBtnOne
@synthesize label = mpLabel;
@synthesize imageView = mpImageView;

-(void)addSubviews
{
    CGSize size = self.frame.size;
    float width = size.width;
    float heigh = size.height;

    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, width-12, heigh-80)];
    [self addSubview:mpImageView];
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, mpImageView.buttom, width, 80)];
    mpLabel.textAlignment = NSTextAlignmentCenter;
    mpLabel.font = [UIFont boldSystemFontOfSize:22];
    mpLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:mpLabel];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self addSubviews];
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
