//
//  SecondTwoViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiAccount.h"



@interface ThirdTwoViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate,downLoadDelegate>
{
@protected
    NSString * theTitle;
    NSMutableArray * cellSourceArr;
    UITableView * myTableView;
    float screenWidth;
    float screenHeight;
    NSInteger deleteRow;
    NSMutableString * CourseIDStr;
}
@property(nonatomic,assign) ListStyle LS;
@property(nonatomic,retain) NSString * theTitle;
@property(nonatomic,retain) NSDictionary * infoDict;


//-(void)addDataSource;
@end
