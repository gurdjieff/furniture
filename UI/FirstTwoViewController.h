//
//  FirstTwoViewController.h
//  ExaminationIpad
//
//  Created by gurdjieff on 13-9-15.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"

@interface FirstTwoViewController : BaseViewController
<downLoadDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITableView * mpTableView;
    UITableView * mpTableViewRight;

    int miSelectIndex;
    NSDictionary * mpInfoDic;
    NSMutableDictionary * mpSecondDataDic;
    int selectIndex;

@public
    NSMutableArray * mpDataAry;
}
@property(nonatomic, retain) NSString * theTitle;
@property(nonatomic, retain) NSString * ParentIDStr;
@property(nonatomic, retain) NSDictionary * infoDic;


@end
