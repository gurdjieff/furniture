//
//  CampusTableCell.h
//  ExaminationIpad
//
//  Created by gurdjieff on 13-8-17.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampusTableCell : UITableViewCell
{
    UIImageView* mpBackImageView;
@public
    UIImageView * mpImageView;
    UILabel * mpLabel;
    UIImageView* mpImageViewSeperate;
    BOOL useBackImage;
}

@end
