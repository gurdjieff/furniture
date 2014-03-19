//
//  StudyCommunityCell.h
//  ExaminationIpad
//
//  Created by gurd on 13-9-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define commentFont [UIFont systemFontOfSize:17]
#define maxiHigh 200.0f


#define labelFont [UIFont systemFontOfSize:17]
@interface StudyCommunityCell : UITableViewCell
{
@public
    UIImageView * mpImageView;
    UILabel * mpLabel1;
    UILabel * mpLabel2;
    UILabel * mpLabel3;
    UILabel * mpLabel4;
    UILabel * mpLabel5;
    UIImageView* mpBackImageView;
    UIImageView* mpImageView1;
    UIImageView* mpImageView2;
    UIImageView* mpImageView3;

    BOOL useBackImage;
}
@end
