//
//  JiHuaTwoViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "DrawUpPlanCell.h"
#import "ComboBoxView.h"
#import "TSLocateView.h"

@interface JiHuaTwoViewController : BaseViewController
    <UITableViewDataSource,UITableViewDelegate,
    downLoadDelegate,DrawUpDelegate,
    UIActionSheetDelegate>
{
    NSString * theTitle;
    float screenWidth;
    float screenHeight;
    
    UITableView * myTableView;
    NSArray * leftDisArr;
    BOOL isPickerAppear;
    ComboBoxView * _comboBox;
    UIDatePicker * datePicker;
    NSMutableString * CourseIDStr;
    NSInteger uptag;
    BOOL isShowAlert;
    BOOL isKnowledge;
    BOOL isGetSource;
    
    
    NSInteger knowledgeCount;
    
    NSString * currentDateStr;
    NSMutableString * startDateStr;
    NSMutableString * endDateStr;
}
@property(nonatomic,retain) NSString * theTitle;
@end
