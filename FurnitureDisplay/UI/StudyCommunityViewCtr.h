//
//  StudyCommunityViewCtr.h
//  Examination
//
//  Created by gurd on 13-7-30.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiAccount.h"

@interface StudyCommunityViewCtr : BaseViewController
<UITableViewDataSource, UITableViewDelegate, downLoadDelegate>
{
    UITableView * mpTableView;
    UITextView * mpTextView;
    UILabel * mpLabel;
    NSDictionary * mpInfoDic;
    NSMutableArray * mpDataAry;
    UIImageView * mpFootView;
    CGPoint center;
}
@property(nonatomic, retain) NSDictionary * infoDic;
@property(nonatomic,assign) theStyle  ctrStyle;


@end
