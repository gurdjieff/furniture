//
//  CampusInfoViewCtr.h
//  ExaminationIpad
//
//  Created by gurdjieff on 13-8-17.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"

@interface CampusInfoViewCtr : BaseViewController
<downLoadDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITableView * mpTableView;
    NSString * _theTitle;
    UIWebView * mpWebView;

//    UITableView * mpTableViewRight;
@public
    NSMutableArray * mpDataAry;
    NSMutableDictionary * mpSecondDataDic;
    int selectIndex;
}
@property(nonatomic,retain) NSString * theTitle;


@end
