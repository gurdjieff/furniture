//
//  FirstViewTwoController.h
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface FirstViewTwoController : BaseViewController
<UITableViewDataSource, UITableViewDelegate, downLoadDelegate>
{
    UITableView * mpTableView;
    NSDictionary * mpInfoDic;
    NSMutableArray * mpDataAry;

}
@property(nonatomic, retain) NSDictionary * infoDic;
@end
