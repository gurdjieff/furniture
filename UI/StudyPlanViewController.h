//
//  StudyPlanViewController.h
//  ExaminationIpad
//
//  Created by gurd on 13-8-26.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"

@interface StudyPlanViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate,downLoadDelegate>
{
    NSString * _theTitle;
    UITableView * mpTableView;
    UIView * mpPlanBaseView;
    UITextView * mpTextView;
@public
    NSMutableArray * mpDataAry;
    NSMutableDictionary * mpSecondDataDic;
    int selectIndex;
    NSMutableString * theKeyStr;
}
@property(nonatomic,retain) NSString * theTitle;

@end
