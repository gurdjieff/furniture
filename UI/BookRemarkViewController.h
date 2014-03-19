//
//  BookRemarkViewController.h
//  ExaminationIpad
//
//  Created by gurd on 13-8-26.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"

@interface BookRemarkViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate,downLoadDelegate>
{
    NSString * _theTitle;
    UITableView * mpTableView;
    UIView * mpRemarkView;
    UITextView * mpTextView;
@public
    NSMutableArray * mpDataAry;
    NSMutableDictionary * mpSecondDataDic;
    int selectIndex;
    NSMutableString * theKeyStr;
}
@property(nonatomic,retain) NSString * theTitle;


@end
