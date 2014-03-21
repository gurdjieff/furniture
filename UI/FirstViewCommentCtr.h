//
//  FirstViewCommentCtr.h
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiAccount.h"




@interface FirstViewCommentCtr : BaseViewController
<UITableViewDataSource, UITableViewDelegate, downLoadDelegate>
{
    UITableView * mpTableView;
    UIImageView * mpFootView;
    UIImageView * mpFootView2;
    UITextView * mpTextView;
    UILabel * mpLabel;
    NSDictionary * mpInfoDic;
    NSMutableArray * mpDataAry;
}
@property(nonatomic, retain) NSDictionary * infoDic;
@property(nonatomic, retain) NSString * theTitle;
@property(nonatomic,assign) theStyle  ctrStyle;
@end
