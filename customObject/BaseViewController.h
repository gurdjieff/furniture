//
//  BaseViewController.h
//  Examination
//
//  Created by gurd on 13-6-23.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "UIView+ViewFrameGeometry.h"

@interface BaseViewController : UIViewController
{
    NSOperationQueue * mpOperationQueue;
    UIImageView * mpNavitateViewTop;
    UIImageView * mpNavitateViewBottom;


    UILabel * mpTitleLabel;
    @public
    UIView * mpBaseView;

}


-(void)addLeftButton;
-(void)topNavigatorAddRightBtn;
-(void)rightBtnClick;


@end
