//
//  CustomTabBarViewCtr.h
//  Examination
//
//  Created by gurd on 13-6-23.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarViewCtr : UITabBarController
{
    UIView * mpMenuView;
    UIView * mpMenuView1;
    UIView * mpMenuView2;
    UIView * mpMenuView3;
    UIView * mpMenuView4;
}

+(CustomTabBarViewCtr *)shareTabBarViewCtr;
@end
