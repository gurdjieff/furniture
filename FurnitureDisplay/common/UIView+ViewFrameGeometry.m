//
//  UIView+ViewFrameGeometry.m
//  Examination
//
//  Created by gurd on 13-8-1.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "UIView+ViewFrameGeometry.h"

@implementation UIView (ViewFrameGeometry)
-(CGFloat)buttom
{
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)left
{
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setTop:(CGFloat)Top
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, Top, frame.size.width, frame.size.height);
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
}



//-(CGFloat)
@end
