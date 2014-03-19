//
//  CommentCell.h
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>
#define commentFont [UIFont systemFontOfSize:17]
#define maxiHigh 100.0f

@interface CommentCell : UITableViewCell
{
    @public
    UIImageView * mpImageView;
    UILabel * mpLabel1;
    UILabel * mpLabel2;
    UILabel * mpLabel3;
}

@end
