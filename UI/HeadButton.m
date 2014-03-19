//
//  HeadButton.m
//  Examination
//
//  Created by gurdjieff on 13-7-27.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "HeadButton.h"
#import "Common.h"
#import "BaseViewController.h"

@implementation HeadButton

-(void)addsubviews
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 2, 60)];
    label.backgroundColor = [UIColor darkGrayColor];
//    [self addSubview:label];
    mpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 20,  28, 16)];
    mpImageView.transform = CGAffineTransformMakeRotation(-3.14/2);
    mpImageView.image = [UIImage imageNamed:@"yellowArrow.png"];
    [self addSubview:mpImageView];
    
    
    mpTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, appFrameWidth-60-60, 60)];
    mpTitle.backgroundColor = [UIColor clearColor];
    mpTitle.font = [UIFont boldSystemFontOfSize:20];
    mpTitle.textColor = yellowColor;
    mpTitle.userInteractionEnabled = NO;
    [self addSubview:mpTitle];
}

-(void)headBtnClick
{
    open = !open;
    if (!open) {
        mpImageView.transform = CGAffineTransformMakeRotation(-3.14/2);
    } else {
        mpImageView.transform = CGAffineTransformMakeRotation(0);
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor] ;
        self.frame = CGRectMake(0, 0, 320, 40);
        open = YES;
        [self addsubviews];
        mpImageView.transform = CGAffineTransformMakeRotation(0);
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
