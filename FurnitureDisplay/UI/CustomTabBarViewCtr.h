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
    UIView * mpView;
}

+(CustomTabBarViewCtr *)shareTabBarViewCtr;
@end