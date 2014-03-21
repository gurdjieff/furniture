//
//  JiaoLiuViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-8-4.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiAccount.h"

@interface JiaoLiuViewController :BaseViewController
<UITableViewDataSource,UITableViewDelegate,downLoadDelegate>
{
    NSMutableArray * cellSourceArr;

    float screenWidth;
    float screenHeight;
    UITableView * myTableView;
    
}
@property(nonatomic,assign) ListStyle LS;
@property(nonatomic,retain) NSString * theTitle;
@property(nonatomic,retain) NSDictionary * requestDic;
@end
