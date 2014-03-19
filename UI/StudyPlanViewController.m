//
//  StudyPlanViewController.m
//  ExaminationIpad
//
//  Created by gurd on 13-8-26.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "StudyPlanViewController.h"
#import "RealPracticeCell.h"
#import "AppDelegate.h"
#import "NewItoast.h"
#import "MakePlanViewController.h"
#import "StudyPlanCell.h"
#define cellHight 60.0f
#define cellCount 12
@interface StudyPlanViewController ()
{
    UITableView * mpTableViewRight;
    NSArray * mpPlanInfoAry;
    NSArray * mpPlanInfoPicAry;
    UILabel * mpLabel;


}
@end

@implementation StudyPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getDataFromService];
}


-(void)addTableViewFootView
{
    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 60)];
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, (1024-60)/2-40, 60)];
    mpLabel.font = [UIFont systemFontOfSize:20];
    mpLabel.textColor = [UIColor lightGrayColor];
    mpLabel.backgroundColor = [UIColor clearColor];
    [lpView addSubview:mpLabel];
    mpTableViewRight.tableFooterView = lpView;
}

-(void)resetFootView
{
    NSDictionary * lpTempDic = mpDataAry[selectIndex];
//    NSDate * sDate = nil;
//    NSDate * eDate = nil;
//    NSInteger knowledgeCount = 0;
//    //        float eachKnowledgeCount =0;
//    
    NSString * StudyCount = lpTempDic[@"StudyCount"];
    NSString * Count = lpTempDic[@"Count"];
    NSString * info = [NSString stringWithFormat:@"你已经学习了%@个知识点，还剩%@个， 加油！", StudyCount, Count];
    mpLabel.text = info;
}

-(void)addTableViews
{
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 748-44) style:UITableViewStylePlain];
    mpTableView.tag = 101;
    mpTableView.showsVerticalScrollIndicator = NO;
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.separatorColor = [UIColor clearColor];
    mpTableView.backgroundColor = cellBackColor;
    [mpBaseView addSubview:mpTableView];
    
    mpTableViewRight = [[UITableView alloc] initWithFrame:CGRectMake((1024-60)/2, 0, (1024-60)/2, 748-44) style:UITableViewStylePlain];
    mpTableViewRight.tag = 102;
    mpTableViewRight.showsVerticalScrollIndicator = NO;
    mpTableViewRight.delegate = self;
    mpTableViewRight.dataSource = self;
    mpTableViewRight.separatorColor = [UIColor clearColor];
    mpTableViewRight.backgroundColor = cellBackColor;
    mpTableViewRight.bounces = NO;
    [mpBaseView addSubview:mpTableViewRight];
    [self addTableViewFootView];

}

-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
    mpPlanInfoAry = [[NSArray alloc] initWithObjects:@"计划描述", @"选择章节",@"开始时间",@"结束时间",@"每天学习多少个知识点",@"完成现状",nil];
    mpPlanInfoPicAry = [[NSArray alloc] initWithObjects:@"planDisplay.png", @"chapter.png",@"startTime.png",@"endtime.png",@"everyDaystudy.png",@"completeState.png",nil];

    mpSecondDataDic = [[NSMutableDictionary alloc] init];
    selectIndex = 0;
}

-(void)resetPlanInfo
{
    mpPlanBaseView.hidden = NO;
    NSDictionary * lpTempDic = mpDataAry[selectIndex];
    NSDate * sDate = nil;
    NSDate * eDate = nil;
    NSInteger knowledgeCount = 0;
    float eachKnowledgeCount =0;

    for (int i = 0; i < 6; i++) {
        UILabel * lpTimeLabel = (UILabel *)[mpPlanBaseView viewWithTag:100 + i];
        if (i==0) {
            lpTimeLabel.text = lpTempDic[@"Brief"];
        }
        if (i == 1) {
            lpTimeLabel.text = lpTempDic[@"Name"];
        }
        
        if (i == 2) {
            NSArray * tmpArr =[[lpTempDic objectForKey:@"StartDate"] componentsSeparatedByString:@" "];
            lpTimeLabel.text =[tmpArr objectAtIndex:0];
            NSDateFormatter*date=[[NSDateFormatter alloc] init];
            [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            sDate=[date dateFromString:[lpTempDic objectForKey:@"StartDate"]];
        }
        if (i == 3) {
            NSArray * tmpArr =[[lpTempDic objectForKey:@"CompleteDate"] componentsSeparatedByString:@" "];
            lpTimeLabel.text =[tmpArr objectAtIndex:0];
            
            NSDateFormatter*date=[[NSDateFormatter alloc] init];
            [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            eDate=[date dateFromString:[lpTempDic objectForKey:@"CompleteDate"]];
        }
        if (i == 4)
        {
            lpTimeLabel.text =[lpTempDic objectForKey:@"Count"];
            knowledgeCount = [[lpTempDic objectForKey:@"Count"] integerValue];
        }
        if (i == 5)
        {
            eachKnowledgeCount = knowledgeCount/([eDate timeIntervalSinceDate:sDate]/24/3600+1);
            lpTimeLabel.text  = [NSString stringWithFormat:@"%0.1f",eachKnowledgeCount];
        }
    }
    
    int days = (int)[[NSDate date] timeIntervalSinceDate:sDate]/24/3600+1;
    int count  = days*eachKnowledgeCount;
    
    if (count<0) {
        count=0;
    }
    mpTextView.text = [NSString stringWithFormat:@"今天你应该学习了%i个知识点了，赶快去完成计划吧！",count];
}


-(void)addPlanInfoView
{
    return;
    mpPlanBaseView = [[UIView alloc] initWithFrame:CGRectMake((1024-60)/2, 0, (1024-60)/2, appFrameHeigh-44)];
    mpPlanBaseView.hidden = YES;
    mpPlanBaseView.backgroundColor = cellBackColor;
    mpBaseView.backgroundColor = cellBackColor;
//    mpPlanBaseView.backgroundColor = [UIColor grayColor];
//    mpPlanBaseView.hidden = YES;

    [mpBaseView addSubview:mpPlanBaseView];
    
    UIImageView * imageview =[[UIImageView alloc] init];
    [imageview setBackgroundColor:[UIColor colorWithRed:220.0f/255 green:220.0f/255 blue:220.0f/255 alpha:1]];
    [imageview setFrame:CGRectMake(20, 10+44, (appFrameWidth-60)/2-40, 260)];
    [mpPlanBaseView addSubview:imageview];
    
    NSArray * ary = [NSArray arrayWithObjects:@"计划描述:",@"选择科目:",@"开始时间:",@"结束时间:",@"总知识点数量:",@"每天知识点数量:",nil];
    for (int i=0; i<6; ++i) {
        UILabel * timelabel =[[UILabel alloc] init];
        [timelabel setFont:[UIFont systemFontOfSize:20]];
        [timelabel setTextColor:[UIColor blackColor]];
        [timelabel setBackgroundColor:[UIColor clearColor]];
        [timelabel setTextAlignment:UITextAlignmentRight];
        timelabel.text = ary[i];
        [timelabel setFrame:CGRectMake(10, 10+44+5+40*i, 200, 40)];
        [mpPlanBaseView  addSubview:timelabel];
    }
    
    for (int i=0; i<6; ++i) {
        UILabel * timelabel =[[UILabel alloc] init];
        [timelabel setFont:[UIFont systemFontOfSize:18]];
        [timelabel setTextColor:[UIColor orangeColor]];
        [timelabel setBackgroundColor:[UIColor clearColor]];
        [timelabel setTextAlignment:UITextAlignmentLeft];
        timelabel.tag = 100 + i;
        [timelabel setFrame:CGRectMake(220, 60+40*i, 170, 40)];
        [mpPlanBaseView addSubview:timelabel];
    }

    
    mpTextView = [[UITextView alloc] initWithFrame:CGRectMake(40, 320, (appFrameWidth-60)/2-80, 200)];
    mpTextView.editable  = NO;
    mpTextView.font = [UIFont systemFontOfSize:20];
    mpTextView.textColor = [UIColor darkGrayColor];
    [mpTextView setBackgroundColor:[UIColor clearColor]];
    [mpPlanBaseView addSubview:mpTextView];
}


-(void)rightBtnClick
{
    MakePlanViewController * lpViewCtr = [[MakePlanViewController alloc] init];
    [self.navigationController pushViewController:lpViewCtr animated:YES];
}

-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(appFrameWidth-90, 7, 80, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"制定计划" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = _theTitle;
    [self addLeftButton];
    [self addRightBtn];
    [self addTableViews];
//    [self addPlanInfoView];
//    [self getDataFromService];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 101) {
        int count = [mpDataAry count];
        if (count < cellCount) {
            count = cellCount;
        }
        return count;
    } else {
        if ([mpDataAry count] > selectIndex) {
            NSDictionary * lpTempDic = mpDataAry[selectIndex];
            if (lpTempDic) {
                return [mpPlanInfoAry count];
            }
        }
        return 0;
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mpDataAry count] > indexPath.row) {
        return YES;
    } else {
        return NO;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([mpDataAry count] > indexPath.row) {
            NSString * guid = mpDataAry[indexPath.row][@"GUID"];
            [self deletePlanFromService:guid];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        return 60;
    } else {
        return 100;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        NSString * identify = @"cell";
        RealPracticeCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[RealPracticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        //    cell->mpBackImageView.hidden = YES;
        
        if ([mpDataAry count] > indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            NSDictionary * lpDic = [mpDataAry objectAtIndex:indexPath.row];
            cell->mpLabel.text = [lpDic objectForKey:@"Brief"];
            
            NSString * state = [lpDic objectForKey:@"Status"];
            [cell->mpStateBtn setTitle:state forState:UIControlStateNormal];
            
            if ([state isEqualToString:@"已过期"]) {
                [cell->mpStateBtn setBackgroundImage:[[UIImage imageNamed:@"expire.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:4] forState:UIControlStateNormal];
            } else if ([state isEqualToString:@"已完成"]) {
                [cell->mpStateBtn setBackgroundImage:[[UIImage imageNamed:@"complete.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:4] forState:UIControlStateNormal];
                
            } else if ([state isEqualToString:@"未完成"]) {
                [cell->mpStateBtn setBackgroundImage:[[UIImage imageNamed:@"uncomplete.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:4] forState:UIControlStateNormal];
            }
        } else {
            cell->mpLabel.text = @"";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;

    } else {
        NSString * identify = @"cell";
        StudyPlanCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[StudyPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        
        cell->mpImageView.image = [UIImage imageNamed:[mpPlanInfoPicAry objectAtIndex:indexPath.row]];
        cell->mpLabel.text = [mpPlanInfoAry objectAtIndex:indexPath.row];
        
        
        
        NSDictionary * lpTempDic = mpDataAry[selectIndex];
        NSDate * sDate = nil;
        NSDate * eDate = nil;
        NSInteger knowledgeCount = 0;
//        float eachKnowledgeCount =0;
        if (indexPath.row == 0) {
            cell->mpLabel2.text = lpTempDic[@"Brief"];

        } else if (indexPath.row == 1) {
            cell->mpLabel2.text = lpTempDic[@"Name"];

        } else if (indexPath.row == 2) {
            NSArray * tmpArr =[[lpTempDic objectForKey:@"StartDate"] componentsSeparatedByString:@" "];
            cell->mpLabel2.text =[tmpArr objectAtIndex:0];
            NSDateFormatter*date=[[NSDateFormatter alloc] init];
            [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            sDate=[date dateFromString:[lpTempDic objectForKey:@"StartDate"]];

        } else if (indexPath.row == 3) {
            NSArray * tmpArr =[[lpTempDic objectForKey:@"CompleteDate"] componentsSeparatedByString:@" "];
            cell->mpLabel2.text =[tmpArr objectAtIndex:0];
            NSDateFormatter*date=[[NSDateFormatter alloc] init];
            [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            eDate=[date dateFromString:[lpTempDic objectForKey:@"CompleteDate"]];

        } else if (indexPath.row == 4) {
            cell->mpLabel2.text =[lpTempDic objectForKey:@"Count"];
            knowledgeCount = [[lpTempDic objectForKey:@"Count"] integerValue];
            
            NSArray * tmpArr =[[lpTempDic objectForKey:@"StartDate"] componentsSeparatedByString:@" "];
            cell->mpLabel2.text =[tmpArr objectAtIndex:0];
            NSDateFormatter*date=[[NSDateFormatter alloc] init];
            [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            sDate=[date dateFromString:[lpTempDic objectForKey:@"StartDate"]];
            
            NSArray * tmpArr2 =[[lpTempDic objectForKey:@"CompleteDate"] componentsSeparatedByString:@" "];
            cell->mpLabel2.text =[tmpArr2 objectAtIndex:0];
            NSDateFormatter*date2=[[NSDateFormatter alloc] init];
            [date2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            eDate=[date2 dateFromString:[lpTempDic objectForKey:@"CompleteDate"]];
            float time = [eDate timeIntervalSinceDate:sDate];
            if (time > 0) {
                int days = time/3600/24+1;
            
            cell->mpLabel2.text =[NSString stringWithFormat:@"%i", (int)(knowledgeCount/days)];
//            knowledgeCount = [[lpTempDic objectForKey:@"Count"] integerValue];

            }
            
            
//            NSDate * date1 = mesg1[@"data"];
//            NSDate * date2 = mesg2[@"data"];
//            float time = [date2 timeIntervalSinceDate:date1]+1;
//            if (time > 0) {
//                int days = time/3600/24+1;
//                NSString * info = [NSString stringWithFormat:@"每天学    %i   个知识点", (int)count/days];
//                mpDetailLabel.text = info;
//            } else {
//                mpDetailLabel.text = @"每天学         个知识点";
//            }

            
        }  else if (indexPath.row == 5) {
            cell->mpLabel2.text = lpTempDic[@"Status"];

        }
        
//        for (int i = 0; i < 6; i++) {
//            UILabel * lpTimeLabel = (UILabel *)[mpPlanBaseView viewWithTag:100 + i];
//            if (i==0) {
//                lpTimeLabel.text = lpTempDic[@"Brief"];
//            }
//            if (i == 1) {
//                lpTimeLabel.text = lpTempDic[@"Name"];
//            }
//            
//            if (i == 2) {
//                NSArray * tmpArr =[[lpTempDic objectForKey:@"StartDate"] componentsSeparatedByString:@" "];
//                lpTimeLabel.text =[tmpArr objectAtIndex:0];
//                NSDateFormatter*date=[[NSDateFormatter alloc] init];
//                [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                sDate=[date dateFromString:[lpTempDic objectForKey:@"StartDate"]];
//            }
//            if (i == 3) {
//                NSArray * tmpArr =[[lpTempDic objectForKey:@"CompleteDate"] componentsSeparatedByString:@" "];
//                lpTimeLabel.text =[tmpArr objectAtIndex:0];
//                
//                NSDateFormatter*date=[[NSDateFormatter alloc] init];
//                [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                eDate=[date dateFromString:[lpTempDic objectForKey:@"CompleteDate"]];
//            }
//            if (i == 4)
//            {
//                lpTimeLabel.text =[lpTempDic objectForKey:@"Count"];
//                knowledgeCount = [[lpTempDic objectForKey:@"Count"] integerValue];
//            }
//            if (i == 5)
//            {
//                eachKnowledgeCount = knowledgeCount/([eDate timeIntervalSinceDate:sDate]/24/3600+1);
//                lpTimeLabel.text  = [NSString stringWithFormat:@"%0.1f",eachKnowledgeCount];
//            }
//        }
//        
//        int days = (int)[[NSDate date] timeIntervalSinceDate:sDate]/24/3600+1;
//        float count  = days*eachKnowledgeCount;
//        
//        if (count<0) {
//            count=0;
//        }
//        mpTextView.text = [NSString stringWithFormat:@"今天你应该学习了%.1f个知识点了，赶快去完成计划吧！",count];


        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==  101) {
        if ([mpDataAry count] <= indexPath.row) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        } else {
            selectIndex = indexPath.row;
            [mpTableViewRight reloadData];
            [self resetFootView];
        }
    }
}




#pragma mark - http


-(void)getSecondDataFromServiceWithIndex:(int)index
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.useCache = YES;
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Note.action"];
    if ([mpDataAry count] > index) {
        NSDictionary * tempDic = [mpDataAry objectAtIndex:index];
        [operation.argumentDic setValue:[tempDic objectForKey:@"GUID"] forKey:@"CourseID"];
    }
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    operation.tag = 200+index;
    operation.useCache = YES;
    [mpOperationQueue addOperation:operation];
}

-(void)getDataFromService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init] ;
    operation.tag =100;
    operation.useCache = YES;
    operation.urlStr = [serverIp stringByAppendingString:@"/User/StudyPlanList.action"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}

-(void)deletePlanFromService:(NSString *)guid
{
    
    commonDataOperation * operation = [[commonDataOperation alloc] init] ;
    operation.tag =101;
    operation.useCache = YES;
    operation.urlStr = [serverIp stringByAppendingString:@"/User/DeleteStudyPlan.action"];
    [operation.argumentDic setObject:guid forKey:@"GUID"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",info);
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if (![info ifInvolveStr:@"\"result\":\"1\""]) {
        return;
    }
    
    if (tag >= 200) {
        NSString * Brief = [NSString stringWithString:[[info JSONValue] objectForKey:@"Brief"]];
        [mpSecondDataDic setObject:Brief forKey:[NSString stringWithFormat:@"%d", tag-200]];
//        [self resetPlanInfo];
    [self addPlanInfoView];

    } else if (tag == 100) {
        NSArray * ary = [NSArray arrayWithArray:[[info JSONValue] objectForKey:@"list"]];
        [mpDataAry setArray:ary];
        [mpTableView reloadData];
        [self addPlanInfoView];

    } else if (tag == 101) {
        [self getDataFromService];
    }
}

@end

