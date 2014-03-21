//
//  FirstTableViewCell.h
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCell : UITableViewCell
{
    UIImageView* mpBackImageView;
    @public
    UIImageView * mpImageView;
    UILabel * mpLabel;
    UILabel * mpLabel2;
    UIImageView* mpImageViewSeperate;
    BOOL useBackImage;
    UILabel * alreadPay;
    UIImageView * mpIconImageView;

}
@end
