//
//  PredictTestViewCtr.m
//  Examination
//
//  Created by gurdjieff on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "PredictTestViewCtr.h"
#import "PredictTestCell.h"
#import "JudgeCell.h"
#import "ExplainViewController.h"
#import "SingleChioceCell.h"
#import "MultipleChoiceCell.h"
#import <objc/runtime.h>
#import "CustomAlertView.h"
#import "SelectBtn.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

#define WIDTH  80/2
#define HEIGHT  90/2
#define Hrow 5
#define BIG_IMG_WIDTH 264
#define BIG_IMG_HEIGHT 300


@interface PredictTestViewCtr ()
{
    NSTimer * myTimer;
    int topicCounts;
    int totalCounts;
    int rightCounts;
    NSMutableDictionary * topicDic;
}
@end

@implementation PredictTestViewCtr
@synthesize infoDic = mpInfoDic;
@synthesize testType;


-(id)init
{
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        testType = 0;
    }
    return self;
}

-(void)addTableView
{
    mpBaseView.backgroundColor = cellBackColor;
    UILabel * lpShadowLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 2, appFrameHeigh-44)];
    lpShadowLabel.backgroundColor = [UIColor darkGrayColor];
    [mpBaseView addSubview:lpShadowLabel];
    
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, appFrameWidth-60, appFrameHeigh-44) style:UITableViewStylePlain];
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.backgroundColor = [UIColor clearColor];
    mpTableView.separatorColor = [UIColor clearColor];
    [mpBaseView addSubview:mpTableView];
}

-(void)resetString:(NSMutableString* )info
{
    while (1) {
        NSRange range = [info rangeOfString:@"<br />" options:NSCaseInsensitiveSearch];
        if (range.length > 0) {
            [info deleteCharactersInRange:range];
        } else {
            return;
        }
    }
}

-(void)downLoadWithInfo:(NSString *)apInfo with:(NSInteger)tag
{
    if (![apInfo ifInvolveStr:@"list"]) {
        return;
    }
    
    NSMutableString * tempInfo = [[NSMutableString alloc] init];
    [tempInfo setString:apInfo];
    [self resetString:tempInfo];
    
    
    NSArray * ary = [NSArray arrayWithArray:[[tempInfo JSONValue] objectForKey:@"list"]];
    NSMutableArray * singleChioceAry = [[NSMutableArray alloc] init];
    NSMutableArray * multibleChioceAry = [[NSMutableArray alloc] init];
    NSMutableArray * yesOrNoAry = [[NSMutableArray alloc] init];
    
    for (NSDictionary * dic in ary) {
        NSMutableDictionary * tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        NSArray * Choices = tempDic[@"Choices"];
        if ([Choices isKindOfClass:[NSArray class]] && [Choices count] > 0) {
            NSString * answer = [tempDic objectForKey:@"Answer"];
            if ([answer isKindOfClass:[NSString class]]) {
                if (answer.length == 1) {
                    [tempDic setObject:@"-10" forKey:@"userAnswere"];
                    [singleChioceAry addObject:tempDic];
                } else if (answer.length > 1) {
                    NSMutableArray * ary = [[NSMutableArray alloc] init];
                    [tempDic setObject:ary forKey:@"userAnswere"];
                    [multibleChioceAry addObject:tempDic];
                }
            }
        } else {
            [tempDic setObject:@"-10" forKey:@"userAnswere"];
            [yesOrNoAry addObject:tempDic];
        }
    }
    
    [mpSingleChioceAry setArray:singleChioceAry];
    [mpMultiChioceAry setArray:multibleChioceAry];
    [mpYesOrNoAry setArray:yesOrNoAry];
    
    [mpTableView reloadData];
}


-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}


-(void)getDataFromService
{
    if (testType==Predict) {
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/QuestionList.action"];
        //    CourseID
        [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"CourseID"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        operation.tag= 10001;
        [mpOperationQueue addOperation:operation];
    } else if (testType == Zhenti) {
        commonDataOperation * operation = [[commonDataOperation alloc] init] ;
        operation.urlStr = [serverIp stringByAppendingString:@"/Exam/PoolQuestionList.action"];
        operation.tag =20004;
        [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"ExamPoolID"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
    }
    //模拟题库
    else if (testType == Moni) {
        commonDataOperation * operation = [[commonDataOperation alloc] init] ;
        operation.urlStr = [serverIp stringByAppendingString:@"/Exam/PoolQuestionList.action"];
        operation.tag =20005;
        [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"ExamPoolID"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
    }
    //错题中心
    else if (testType==Cuoti) {
        commonDataOperation * operation = [[commonDataOperation alloc] init] ;
        operation.urlStr = [serverIp stringByAppendingString:@"/Exam/ErrQuestionList.action"];
        operation.tag =20006;
        [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"ExamPoolID"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
    } else if (testType == RANDOM) {
//        116.90.86.104:81

        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.useCache = YES;
        
        operation.urlStr =[serverIp stringByAppendingFormat:@"/Course/RandomQuizList.action"];
        [operation.argumentDic setValue:mpInfoDic[@"GUID"]forKey:@"GUID"];
        [operation.argumentDic setValue:@"20" forKey:@"RandomQuizList"];
        operation.downInfoDelegate = self;
        operation.tag = 2006;
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
    }
}

-(void)initData
{
    topicDic =[[NSMutableDictionary alloc] init];
    
    mpDataAry = [[NSMutableArray alloc] init];
    mpSingleChioceAry = [[NSMutableArray alloc] init];
    mpMultiChioceAry = [[NSMutableArray alloc] init];
    mpYesOrNoAry = [[NSMutableArray alloc] init];
    
    mpHeadBtn1 = [[HeadButton alloc] initWithFrame:CGRectMake(0, 0, appFrameWidth-60, 60)];
    mpHeadBtn1->mpTitle.text = @"判断题";
//    mpHeadBtn1.backgroundColor = cellBackColor;
    
    mpHeadBtn1.tag = 100;
    [mpHeadBtn1 addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    mpHeadBtn2 = [[HeadButton alloc] initWithFrame:CGRectMake(0, 0, appFrameWidth-60, 60)];
    mpHeadBtn2->mpTitle.text = @"单项选择题";
    mpHeadBtn2.tag = 101;
//    mpHeadBtn2.backgroundColor = cellBackColor;
    [mpHeadBtn2 addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    mpHeadBtn3 = [[HeadButton alloc] initWithFrame:CGRectMake(0, 0, appFrameWidth-60, 60)];
    mpHeadBtn3->mpTitle.text = @"多项选择题";
    mpHeadBtn3.tag = 102;
//    mpHeadBtn3.backgroundColor = cellBackColor;
    [mpHeadBtn3 addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)rightBtnClick
{
    topicCounts = 0;
    rightCounts = 0;
    totalCounts = [mpYesOrNoAry count]+[mpSingleChioceAry count]+[mpMultiChioceAry count];
    
    [topicDic removeAllObjects];
    
    
    int judge = 0;
    int single = 0;
    int multiple = 0;
    
    for (NSDictionary * dic in mpYesOrNoAry) {
            NSLog(@"----------->%@",dic);
        if ([dic[@"Answer"] isEqualToString:dic[@"userAnswere"]]) {
            //代表此题做对了
            judge++;
            [self sendAnswer:dic tag:YES];
            [topicDic setObject:@"yes" forKey:[NSString stringWithFormat:@"%d",topicCounts]];
        } else {
            //代表此题做错了。
            [self sendAnswer:dic tag:NO];
            [topicDic setObject:@"no" forKey:[NSString stringWithFormat:@"%d",topicCounts]];
        }
        topicCounts ++;
    }
    
    for (NSDictionary * dic in mpSingleChioceAry) {
        if ([dic[@"Answer"] isEqualToString:dic[@"userAnswere"]]) {
            //代表此题做对了
            single++;
            [self sendAnswer:dic tag:YES];
            [topicDic setObject:@"yes" forKey:[NSString stringWithFormat:@"%d",topicCounts]];
        } else {
            //代表此题做错了。
            [self sendAnswer:dic tag:NO];
            [topicDic setObject:@"no" forKey:[NSString stringWithFormat:@"%d",topicCounts]];
        }
        topicCounts ++;
    }
    
    for (NSDictionary * dic in mpMultiChioceAry) {
        NSArray * userAry = dic[@"userAnswere"];
        
        NSMutableString * lastAnswere = [[NSMutableString alloc] init];
        int counts = [userAry count];
        for (int i = 0; i < counts; i++) {
            NSString * str = [userAry objectAtIndex:i];
            if (i == counts - 1) {
                [lastAnswere appendFormat:@"%@", str];
            } else {
                [lastAnswere appendFormat:@"%@,", str];
            }
        }
        
        if ([dic[@"Answer"] isEqualToString:lastAnswere]) {
            //代表此题做对了
            multiple++;
            [self sendAnswer:dic tag:YES];
            [topicDic setObject:@"yes" forKey:[NSString stringWithFormat:@"%d",topicCounts]];
        } else {
            //代表此题做错了。
            [self sendAnswer:dic tag:NO];
            [topicDic setObject:@"no" forKey:[NSString stringWithFormat:@"%d",topicCounts]];
        }
        topicCounts ++;
    }
    
    rightCounts = judge+single+multiple;
    [self addScoreView];
}

-(void)addScoreView
{
    if (!scoreView) {
        for (UIView * view in [scoreView subviews]) {
            [view removeFromSuperview];
        }
        [scoreView removeFromSuperview];
        scoreView = nil;
    }
    
    if (bgView==nil) {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, appFrameWidth-60, appFrameHeigh)];
        [bgView setBackgroundColor:[UIColor colorWithRed:0.3
                                                   green:0.3
                                                    blue:0.3
                                                   alpha:0.7]];
        [self.view addSubview:bgView];
    }
    
    float width = 400;
    scoreView =[[UIView alloc] init];
    [scoreView setBackgroundColor:[UIColor colorWithRed:205.0f/255.f
                                                  green:205.0f/255.f
                                                   blue:205.0f/255.f
                                                  alpha:1]];
    CGRect frame = CGRectMake(280, appFrameHeigh, width, appFrameHeigh-200);
    [scoreView setFrame:frame];
    scoreView.userInteractionEnabled = YES;
    [bgView addSubview:scoreView];
    
      
    NSArray * txtArr = @[@"题目数量:",@"正确数:",@"错误数:",@"60%",@"正确率:            %",@"题目索引:"];
    
    for (int i =0; i < 6; i++) {
        UILabel * label =[[UILabel alloc] init];
        [label setTextColor:[UIColor blackColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont systemFontOfSize:18]];
        [label setTextAlignment:UITextAlignmentLeft];
        [label setTag:200+i];
       
        
        if (i<3) {
            [label setFrame:CGRectMake(20, 30 * i+20, width-40, 30)];
        } else if (i == 3) {
            [label setFrame:CGRectMake(180 +70 *(i-3), 115, 80, 30)];
            label.textAlignment = NSTextAlignmentCenter;
            [label setFont:[UIFont systemFontOfSize:24]];

//            label.backgroundColor = [UIColor grayColor];
        } else if (i<5 ) {
            [label setFrame:CGRectMake(30 +70 *(i-3), 115, 300, 30)];
            label.textAlignment = NSTextAlignmentLeft;
            [label setFont:[UIFont systemFontOfSize:24]];
            [label setTextAlignment:UITextAlignmentLeft];
//            label.backgroundColor = [UIColor grayColor];
        }
        else {
            [label setFrame:CGRectMake(20, 150, width-40, 30)];
        }
        
//        if (i == 4) {
//            [label setFrame:CGRectMake(60 +70 *(i-3), 115, 160, 30)];
//
//        }
        
          
        switch (i) {
            case 0:
            {
                [label setText:[NSString stringWithFormat:@"题目数量:%d",totalCounts]];
            }
                break;
            case 1:
            {
                [label setText:[NSString stringWithFormat:@"正确数:%d",rightCounts]];
            }
                break;
            case 2:
            {
                [label setText:[NSString stringWithFormat:@"错误数:%d",totalCounts-rightCounts]];
            }
                break;
            case 3:
            {
                [label setTextColor:[UIColor orangeColor]];
                if (totalCounts == 0) {
                    [label setText:@"0.0"];
                } else {
                    [label setText:[NSString stringWithFormat:@"%0.1f",(float)rightCounts/totalCounts *100]];
                }
            }
                break;
            case 4:
            {
                [label setTextColor:[UIColor orangeColor]];
                label.font = [UIFont systemFontOfSize:24];
                [label setText:[txtArr objectAtIndex:i]];
            }
                break;
            default:
            {
                [label setText:[txtArr objectAtIndex:i]];
            }
                break;
        }
          
        [scoreView addSubview:label];
    }
    
    topicCounts = 0;
	int i=0;
	int j=0;
	int k=0;
	
	for (i=0; i<totalCounts; i++) {
		
		if(i%Hrow==0){
			for (j=0; j<Hrow; j++) {
				if (k*Hrow+j<totalCounts) {
					UIImageView *imgView=[[UIImageView alloc]init];
					imgView.frame=CGRectMake(j*WIDTH+j*35+30,140+(k+1)*(HEIGHT+20), WIDTH, HEIGHT);
                    
                    NSString * theKey =[NSString stringWithFormat:@"%d",k*Hrow+j];
                    NSString * theObj =[topicDic objectForKey:theKey];
                    
                    if ([theObj isEqualToString:@"yes"]) {
                        [imgView setImage:[UIImage imageNamed:@"rightShow.png"]];
                    }else{
                        [imgView setImage:[UIImage imageNamed:@"wrongShow.png"]];
                    }
              
					imgView.tag=k*Hrow+j+1+400;
					[scoreView addSubview:imgView];
					
                    imgView.frame=CGRectMake(j*WIDTH+j*35+30,140+(k+1)*(HEIGHT+12), WIDTH, HEIGHT);
                    
					UILabel *lblInfo=[[UILabel alloc]init];
					lblInfo.frame=CGRectMake(0,10, WIDTH, HEIGHT);
					lblInfo.text=[NSString stringWithFormat:@"%d",k*Hrow+j+1];
					lblInfo.tag=k*Hrow+j+1+300;
					lblInfo.backgroundColor=[UIColor clearColor];
					lblInfo.textColor=[UIColor grayColor];
					lblInfo.font=[UIFont systemFontOfSize:14];
					lblInfo.textAlignment=UITextAlignmentCenter;
					[imgView addSubview:lblInfo];
					[self small:imgView];
					[self small:lblInfo];
				}
			}
			k++;
		}
	}
    
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame: CGRectMake(width/2-25, scoreView.frame.size.height-60, 50, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(removeScoreView:) forControlEvents:UIControlEventTouchUpInside];
    [scoreView addSubview:btn];
    
    [self performSelector:@selector(move:)
               withObject:[NSNumber numberWithFloat:88]
               afterDelay:0.0f];
    
    myTimer=[NSTimer scheduledTimerWithTimeInterval:0.15
                                             target:self
                                           selector:@selector(changeBig)
                                           userInfo:nil
                                            repeats:YES];
}


-(void)removeScoreView:(id)sender
{
    [bgView removeFromSuperview];
    bgView =nil;
    [self performSelector:@selector(move:)
               withObject:[NSNumber numberWithFloat:appFrameHeigh]
               afterDelay:0];
}

-(void)move:(NSNumber *)h
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
    CGRect frame = scoreView.frame;
    CGRect frameNew = CGRectMake(frame.origin.x, 100, frame.size.width, frame.size.height);
    [scoreView setFrame:frameNew];
	[UIView commitAnimations];
}

-(void)small:(UIView *)myView{
	CGAffineTransform transform=CGAffineTransformMakeScale(0.001, 0.001);
	myView.transform=transform;
}

-(void)changeBig{
	
	topicCounts++;
	if(topicCounts==totalCounts){
		[myTimer invalidate];
	}
    [self big:[scoreView viewWithTag:topicCounts+400]];
	[self big:[scoreView viewWithTag:topicCounts+300]];
}

-(void)big:(UIView *)myView{
	
	CGAffineTransform transform=CGAffineTransformMakeScale(1, 1);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	myView.transform=transform;
	[UIView commitAnimations];
}

-(void)sendAnswer:(NSDictionary *)dic tag:(BOOL)t
{
    NSString * lpUrl = nil;
    if (testType != Cuoti && t == NO) {
        lpUrl = [serverIp stringByAppendingFormat:@"/Exam/QuizErrLog.action"];
    } else if (testType == Cuoti && t == YES) {
        lpUrl = [serverIp stringByAppendingFormat:@"/Exam/ClearQuizErrLog.action"];
    } else {
        return;
    }
    
    AppDelegate * appDegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSOperationQueue * lpOperationQueue = appDegate.operationQueue;
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = lpUrl;
    [operation.argumentDic setValue:[dic objectForKey:@"GUID"] forKey:@"QuestionID"];
    operation.isPOST = YES;
    [lpOperationQueue addOperation:operation];
}


-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(appFrameWidth-60, 7, 50, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}

-(void)explalinCloseBtnClick
{
    [UIView animateWithDuration:0.5 animations:^{
        mpExplainView.alpha = 0.0;
    }];
}

-(void)addExplainView
{
    mpExplainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appFrameWidth-60, appFrameHeigh-44)];
    mpExplainView.backgroundColor = [UIColor grayColor];
    mpExplainView.alpha = 0.0;
    [mpBaseView addSubview:mpExplainView];
    
    mpExplainLabel = [[UITextView alloc] initWithFrame:CGRectMake(100, 100, appFrameWidth-60-200, appFrameHeigh-44-200)];
    mpExplainLabel.layer.borderWidth = 4;
    mpExplainLabel.font = [UIFont systemFontOfSize:18];
    mpExplainLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    mpExplainLabel.layer.cornerRadius = 10;
    mpExplainLabel.editable = NO;
    [mpExplainView addSubview:mpExplainLabel];
    
    mpCloseBtn = [[UIButton alloc] initWithFrame:CGRectMake(mpExplainLabel.left-50, mpExplainLabel.buttom-40, 30, 30)];
    [mpCloseBtn setBackgroundImage:[UIImage imageNamed:@"X.png"] forState:UIControlStateNormal];
    [mpCloseBtn addTarget:self action:@selector(explalinCloseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpExplainView addSubview:mpCloseBtn];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = [mpInfoDic objectForKey:@"Name"];
    [self addLeftButton];
    [self addRightBtn];
    [self addTableView];
    [self addExplainView];
    [self getDataFromService];
    
	// Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    LFLog("");
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LFLog("");
    if (section == 0) {
        if (mpHeadBtn1->open) {
            return [mpYesOrNoAry count];
        }
    } else if (section == 1) {
        if (mpHeadBtn2->open) {
            return [mpSingleChioceAry count];
        }
    } else {
        if (mpHeadBtn3->open) {
            return [mpMultiChioceAry count];
        }
    }
    return 0;
}

-(void)explainBtnClick:(UIButton *)btn
{
    NSIndexPath* indexPath = objc_getAssociatedObject(btn, @"indexPath");
    NSString * answere = nil;
    if (indexPath.section == 0) {
        answere = mpYesOrNoAry[indexPath.row][@"Explain"];
    } else if (indexPath.section == 1) {
        answere = mpSingleChioceAry[indexPath.row][@"Explain"];
    } else if (indexPath.section == 2) {
        answere = mpMultiChioceAry[indexPath.row][@"Explain"];
    }
    
    mpExplainLabel.text = answere;
//    CGSize size = [answere sizeWithFont:mpExplainLabel.font constrainedToSize:CGSizeMake(appFrameWidth-60-200, 1000) lineBreakMode:NSLineBreakByWordWrapping];
//    mpExplainLabel.frame = CGRectMake(0, 0, appFrameWidth-60-200, size.height+40);
//    
//    CGPoint point = CGPointMake(mpExplainView.center.x, mpExplainView.center.y-60);
//    mpExplainLabel.center = point;
//    mpCloseBtn.frame = CGRectMake(mpExplainLabel.left-35, mpExplainLabel.buttom-35, 30, 30);
    
    [UIView animateWithDuration:0.5 animations:^{
        mpExplainView.alpha = 1.0;
    }];
}

-(void)headBtnClick:(HeadButton *)btn
{
    LFLog("");
    
    [UIView animateWithDuration:0.3 animations:^{
        [btn headBtnClick];
    } completion:^(BOOL f){
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:btn.tag - 100];
        [mpTableView reloadSections:set
                   withRowAnimation:UITableViewRowAnimationNone];
    }];
}


-(void)judeBtnClick:(UIButton *)btn
{
    NSIndexPath* indexPath = objc_getAssociatedObject(btn, @"indexPath");
    NSString* answere = objc_getAssociatedObject(btn, @"answere");
    
    JudgeCell * cell = (JudgeCell *)[mpTableView cellForRowAtIndexPath:indexPath];
    [cell btnClick:btn];
    NSMutableDictionary * dic = mpYesOrNoAry[indexPath.row];
    [dic setObject:answere forKey:@"userAnswere"];
}

-(void)singleChoiceBtnClick:(SelectBtn *)btn
{
    NSIndexPath* indexPath = objc_getAssociatedObject(btn, @"indexPath");
    SingleChioceCell * cell = (SingleChioceCell *)[mpTableView cellForRowAtIndexPath:indexPath];
    [cell btnClick:btn];
    
    NSString* answere = objc_getAssociatedObject(btn, @"answere");
    NSMutableDictionary * dic = mpSingleChioceAry[indexPath.row];
    [dic setObject:answere forKey:@"userAnswere"];
}

-(void)multipleChoiceBtnClick:(SelectBtn *)btn
{
    NSIndexPath* indexPath = objc_getAssociatedObject(btn, @"indexPath");
    MultipleChoiceCell * cell = (MultipleChoiceCell *)[mpTableView cellForRowAtIndexPath:indexPath];
    [cell btnClick:btn];
    
    NSString* answere = objc_getAssociatedObject(btn, @"answere");
    NSMutableArray * ary = mpMultiChioceAry[indexPath.row][@"userAnswere"];
    if (btn->selected) {
        [ary addObject:answere];
    } else {
        for (NSString * s in ary) {
            if ([s isEqualToString:answere]) {
                [ary removeObject:s];
                break;
            }
        }
    }
    
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    [ary sortUsingComparator:cmptr];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LFLog("");
    
    NSString * identify1 = @"JudgeCell";
    NSString * identify2 = @"SingleChioceCell";
    NSString * identify3 = @"MultipleChoiceCell";
    
    if (indexPath.section == 0) {
        //        JudgeCell * cell = [tableView dequeueReusableCellWithIdentifier:identify1];
        JudgeCell * cell = nil;
        if (cell == nil) {
            cell = [[JudgeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify1];
        }
        
        NSDictionary * lpDic = mpYesOrNoAry[indexPath.row];
        
        if (testType == Predict) {
            [cell->mpExplainBtn addTarget:self action:@selector(explainBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            objc_setAssociatedObject(cell->mpExplainBtn, @"indexPath",indexPath, OBJC_ASSOCIATION_RETAIN);
            
        } else {
            cell->mpExplainBtn.hidden = YES;
        }
        
        [cell->mpBtn1 addTarget:self action:@selector(judeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(cell->mpBtn1, @"indexPath",indexPath, OBJC_ASSOCIATION_RETAIN);
        objc_setAssociatedObject(cell->mpBtn1, @"answere",@"0", OBJC_ASSOCIATION_RETAIN);
        
        [cell->mpBtn2 addTarget:self action:@selector(judeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(cell->mpBtn2, @"indexPath",indexPath, OBJC_ASSOCIATION_RETAIN);
        objc_setAssociatedObject(cell->mpBtn2, @"answere",@"-1", OBJC_ASSOCIATION_RETAIN);
        
        
        [cell->mpBtn1 setBackgroundImage:[UIImage imageNamed:@"rightGray.png"] forState:UIControlStateNormal];
        [cell->mpBtn1 setBackgroundImage:[UIImage imageNamed:@"rightGray.png"] forState:UIControlStateHighlighted];
        
        [cell->mpBtn2 setBackgroundImage:[UIImage imageNamed:@"wrongGray.png"] forState:UIControlStateNormal];
        [cell->mpBtn2 setBackgroundImage:[UIImage imageNamed:@"wrongGray.png"] forState:UIControlStateHighlighted];
        
        NSString * answere = lpDic[@"userAnswere"];
        if ([answere isEqualToString:@"0"]) {
            [cell->mpBtn1 setBackgroundImage:[UIImage imageNamed:@"rightLight.png"] forState:UIControlStateNormal];
            [cell->mpBtn1 setBackgroundImage:[UIImage imageNamed:@"rightLight.png"] forState:UIControlStateHighlighted];
        } else if ([answere isEqualToString:@"1"]) {
            [cell->mpBtn2 setBackgroundImage:[UIImage imageNamed:@"wrongLight.png"] forState:UIControlStateNormal];
            [cell->mpBtn2 setBackgroundImage:[UIImage imageNamed:@"wrongLight.png"] forState:UIControlStateHighlighted];
        }
        
        
        cell->mpLabelIndex.text = [NSString stringWithFormat:@"%d", indexPath.row+1];
        NSString * askInfo = lpDic[@"Ask"];
        cell->mpLabel1.text = askInfo;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    else if (indexPath.section == 1) {
        
        SingleChioceCell * cell = [tableView dequeueReusableCellWithIdentifier:identify2];
        if (cell == nil) {
            cell = [[SingleChioceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify2];
        }
        
        cell->mpLabelIndex.text = [NSString stringWithFormat:@"%d", indexPath.row+1+[mpYesOrNoAry count]];
        NSDictionary * lpDic = mpSingleChioceAry[indexPath.row];
        cell->mpLabel1.text = lpDic[@"Ask"];
        NSArray * lpAry = lpDic[@"Choices"];
        [cell setBtnsTitle:lpAry];
        
        int answere = [lpDic[@"userAnswere"] intValue];
        int choices = [lpAry count];
        for (int i = 0; i < choices; i++) {
            SelectBtn * btn = (SelectBtn *)[cell viewWithTag:100 + i];
            [btn addTarget:self action:@selector(singleChoiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            objc_setAssociatedObject(btn, @"indexPath",indexPath, OBJC_ASSOCIATION_RETAIN);
            objc_setAssociatedObject(btn, @"answere",[NSString stringWithFormat:@"%d", i+1], OBJC_ASSOCIATION_RETAIN);
            if (i == answere-1) {
                btn.selected = YES;
                btn->mpTitleView.image = [UIImage imageNamed:@"selected.png"];
                btn->mpTitle.textColor = yellowColor;
            } else {
                btn.selected = NO;
                btn->mpTitleView.image = [UIImage imageNamed:@"unSelect.png"];
                btn->mpTitle.textColor = [UIColor colorWithRed:0x88/255.0f green:0x88/255.0f blue:0x88/255.0f alpha:1.0];
            }
        }
        
        if (testType == 0) {
            [cell->mpExplainBtn addTarget:self action:@selector(explainBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            objc_setAssociatedObject(cell->mpExplainBtn, @"indexPath",indexPath, OBJC_ASSOCIATION_RETAIN);
            
        } else {
            cell->mpExplainBtn.hidden = YES;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        MultipleChoiceCell * cell = [tableView dequeueReusableCellWithIdentifier:identify3];
        if (cell == nil) {
            cell = [[MultipleChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify3];
        }
        LFLog("");
        
        cell->mpLabelIndex.text = [NSString stringWithFormat:@"%d", indexPath.row+1+[mpYesOrNoAry count]+[mpSingleChioceAry count]];
        NSDictionary * lpDic = mpMultiChioceAry[indexPath.row];
        cell->mpLabel1.text = lpDic[@"Ask"];
        NSArray * lpAry = lpDic[@"Choices"];
        [cell setBtnsTitle:lpAry];
        
        int choices = [lpAry count];
        for (int i = 0; i < choices; i++) {
            SelectBtn * btn = (SelectBtn *)[cell viewWithTag:100 + i];
            [btn addTarget:self action:@selector(multipleChoiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            objc_setAssociatedObject(btn, @"indexPath",indexPath, OBJC_ASSOCIATION_RETAIN);
            objc_setAssociatedObject(btn, @"answere",[NSString stringWithFormat:@"%d", i+1], OBJC_ASSOCIATION_RETAIN);
            
            btn.selected = NO;
            btn->mpTitleView.image = [UIImage imageNamed:@"unSelect.png"];
            btn->mpTitle.textColor = [UIColor colorWithRed:0x88/255.0f green:0x88/255.0f blue:0x88/255.0f alpha:1.0];
            
            NSMutableArray * ary = lpDic[@"userAnswere"];
            for (NSString * answere in ary) {
                if (i == [answere intValue]) {
                    btn.selected = YES;
                    btn->mpTitleView.image = [UIImage imageNamed:@"selected.png"];
                    btn->mpTitle.textColor = yellowColor;
                }
            }
        }
        
        if (testType == 0) {
            [cell->mpExplainBtn addTarget:self action:@selector(explainBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            objc_setAssociatedObject(cell->mpExplainBtn, @"indexPath",indexPath, OBJC_ASSOCIATION_RETAIN);
            
        } else {
            cell->mpExplainBtn.hidden = YES;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSDictionary * lpDic = mpYesOrNoAry[indexPath.row];
        NSString * askInfo = lpDic[@"Ask"];
        CGSize size = [askInfo sizeWithFont:askFont constrainedToSize:CGSizeMake(askWidth, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        if (testType == 0) {
            return size.height + 10 + choiceBtnHeight + 10 + explainBtnHeight + 10;
        } else {
            return size.height + 10 + choiceBtnHeight + 10;
        }
        return size.height + 10 + choiceBtnHeight + 10 + explainBtnHeight + 10;
    } else if (indexPath.section == 1) {
        NSDictionary * lpDic = mpSingleChioceAry[indexPath.row];
        NSString * askInfo = lpDic[@"Ask"];
        CGSize size = [askInfo sizeWithFont:askFont constrainedToSize:CGSizeMake(askWidth, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        NSArray * lpAry = lpDic[@"Choices"];
        
        float heigh = 40.0;
        float totalHeight = 0.0;
        for (int i = 0; i < [lpAry count]; i++) {
            NSString * info2 = [NSString stringWithString:[lpAry objectAtIndex:i]];
            CGSize size = [info2 sizeWithFont:askFont constrainedToSize:CGSizeMake(appFrameWidth-60-80, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            if (heigh < size.height) {
                heigh = size.height;
            }
            totalHeight += heigh;
        }
        
        if (testType == 0) {
            return size.height + 10 + totalHeight + 10 + explainBtnHeight + 10;
        } else {
            return size.height + 10 + totalHeight + 10;
        }
        
    } else {
        NSDictionary * lpDic = mpMultiChioceAry[indexPath.row];
        NSString * askInfo = lpDic[@"Ask"];
        CGSize size = [askInfo sizeWithFont:askFont constrainedToSize:CGSizeMake(askWidth, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        NSArray * lpAry = lpDic[@"Choices"];
        
        float heigh = 40.0;
        float totalHeight = 0.0;
        for (int i = 0; i < [lpAry count]; i++) {
            NSString * info2 = [NSString stringWithString:[lpAry objectAtIndex:i]];
            CGSize size = [info2 sizeWithFont:askFont constrainedToSize:CGSizeMake(280-30, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            if (heigh < size.height) {
                heigh = size.height;
            }
            totalHeight += heigh;
        }
        
        if (testType == 0) {
            return size.height + 10 + totalHeight + 10 + explainBtnHeight + 10;
        } else {
            return size.height + 10 + totalHeight + 10;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if ([mpYesOrNoAry count]) {
            return 60.0f;
        } else {
            return 0.0;
        }
    } else if (section == 1) {
        if ([mpSingleChioceAry count]) {
            return 60.0f;
        } else {
            return 0.0;
        }
    } else {
        if ([mpMultiChioceAry count]) {
            return 60.0f;
        } else {
            return 0.0;
        }
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if ([mpHeadBtn1 superview]) {
            [mpHeadBtn1 removeFromSuperview];
        }
        return mpHeadBtn1;
    } else if (section == 1) {
        if ([mpHeadBtn2 superview]) {
            [mpHeadBtn2 removeFromSuperview];
        }
        return mpHeadBtn2;
    } else {
        if ([mpHeadBtn3 superview]) {
            [mpHeadBtn3 removeFromSuperview];
        }
        return mpHeadBtn3;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
