//
//  StudyCommunitViewCtr.h
//  ExaminationIpad
//
//  Created by gurd on 13-9-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"

@interface StudyCommunitViewCtr : BaseViewController
<UITableViewDataSource, UITableViewDelegate, downLoadDelegate>
{
    UITableView * mpTableView;
    UITableView * mpTableViewRight;
    NSMutableArray * mpDataAry;
    UIImageView * mpFootView;
    CGPoint center;
    int selectIndex;
    NSMutableDictionary * mpSecondDataDic;
    UIImageView * mpRightImageView;
    UILabel * mpRightLabel1;
    UILabel * mpRightLabel2;
    UILabel * mpRightLabel3;
    UILabel * mpRightLabel4;
    UIView * mpRightHeaderView;
    UITextView * mpTextView;

}
@end
