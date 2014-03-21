//
//  JiHuaOneViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"

@interface JiHuaOneViewController : BaseViewController
{
    NSString * theTitle;
    float screenWidth;
    float screenHeight;

}
@property(nonatomic,retain) NSString * theTitle;
@property (nonatomic,retain)NSDictionary * infoDic;
@end
