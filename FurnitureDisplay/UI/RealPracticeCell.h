//
//  RealPracticeCell.h
//  ExaminationIpad
//
//  Created by gurd on 13-8-15.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RealPracticeCell : UITableViewCell
{
@public
    UIImageView* mpBackImageView;
    UIImageView * mpImageView;
    UIButton * mpStateBtn;

    UILabel * mpLabel;
    UIImageView* mpImageViewSeperate;
}
-(void)resetLabel;

@end
