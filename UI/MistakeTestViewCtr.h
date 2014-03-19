//
//  MistakeTestViewCtr.h
//  ExaminationIpad
//
//  Created by gurdjieff on 13-8-17.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"

@interface MistakeTestViewCtr : BaseViewController
<UITableViewDataSource,UITableViewDelegate,downLoadDelegate>
{
    UITableView * mpTableView;
    NSMutableArray * mpDataAry;
    NSString * _theTitle;
}
@property(nonatomic,retain) NSString * theTitle;

@end
