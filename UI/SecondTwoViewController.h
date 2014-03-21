//
//  SecondTwoViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiAccount.h"
#import "NSString+CustomCategory.h"
#import "EGORefreshTableHeaderView.h"


@interface SecondTwoViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate,downLoadDelegate, EGORefreshTableHeaderDelegate>
{
    NSString * _theTitle;
    UITableView * mpTableView;
    UITableView * mpTableViewRight;
@public
    NSMutableArray * mpDataAry;
    NSMutableDictionary * mpSecondDataDic;
    int selectIndex;
    EGORefreshTableHeaderView * mpHeaderView;
    EGORefreshTableHeaderView * mpFooterView;
    NSMutableString * theKeyStr;
}
@property(nonatomic,assign) ListStyle LS;
@property(nonatomic,retain) NSString * theTitle;


@end
