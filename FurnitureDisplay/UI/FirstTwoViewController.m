//
//  FirstTwoViewController.m
//  ExaminationIpad
//
//  Created by gurdjieff on 13-9-15.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FirstTwoViewController.h"
#import "FirstTableViewCell.h"
#import "FirstViewCommentCtr.h"
#import "RemarkViewCtr.h"
#import "PredictTestViewCtr.h"
#import "NSString+CustomCategory.h"
#import "UIImageView+WebCache.h"
#import "FirstTableViewTwoCell.h"
#import "FirstViewThreeController.h"
#import "CustomAlertView.h"
#import <objc/runtime.h>
#import "PaymentAssistant.h"
#define cellCount 11


@interface FirstTwoViewController ()
{
    UIView * mpExplainView;
    UITextView * mpExplainLabel;
    UIButton * mpCloseBtn;
    
}

@end

@implementation FirstTwoViewController
@synthesize theTitle = _theTitle;
@synthesize ParentIDStr = _ParentIDStr;
@synthesize infoDic = mpInfoDic;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDataFromService];
}

-(void)resetString:(NSMutableString* )info
{
    while (1) {
        NSRange range = [info rangeOfString:@"<br />" options:NSCaseInsensitiveSearch];
        if (range.length > 0) {
            [info replaceCharactersInRange:range withString:@"\\n"];
        } else {
            return;
        }
    }
}

-(void)footBtnClickOne:(UIButton *)btn
{
    if (btn.tag == 100) {
        
        NSMutableString * CourseBrief = [NSMutableString stringWithString:mpInfoDic[@"CourseBrief"]];
        [self resetString:CourseBrief];

        mpExplainLabel.text = CourseBrief;
//        CGSize size = [CourseBrief sizeWithFont:mpExplainLabel.font constrainedToSize:CGSizeMake(appFrameWidth-60-200, 1000) lineBreakMode:NSLineBreakByWordWrapping];
//        mpExplainLabel.frame = CGRectMake(0, 0, appFrameWidth-60-200, size.height+40);
//        
//        CGPoint point = CGPointMake(mpExplainView.center.x, mpExplainView.center.y-60);
//        mpExplainLabel.center = point;
//        mpCloseBtn.frame = CGRectMake(mpExplainLabel.left-35, mpExplainLabel.buttom-35, 30, 30);
//        
        [UIView animateWithDuration:0.5 animations:^{
            mpExplainView.alpha = 1.0;
        }];
        
    } else if (btn.tag == 101) {
        PredictTestViewCtr * lpViewCtr = [[PredictTestViewCtr alloc] init];
        lpViewCtr.testType = RANDOM;
        lpViewCtr.infoDic = mpInfoDic;
        [self.navigationController pushViewController:lpViewCtr animated:YES];
    }
}

-(void)footBtnClickOneTwo:(UIButton *)btn
{
    if (btn.tag == 100) {
        if ([mpDataAry count] > selectIndex) {
            NSDictionary * dic = mpDataAry[selectIndex];
            NSMutableString * CourseBrief = [NSMutableString stringWithString:dic[@"CourseBrief"]];
            [self resetString:CourseBrief];

            mpExplainLabel.text = CourseBrief;
//            CGSize size = [CourseBrief sizeWithFont:mpExplainLabel.font constrainedToSize:CGSizeMake(appFrameWidth-60-200, 1000) lineBreakMode:NSLineBreakByWordWrapping];
//            mpExplainLabel.frame = CGRectMake(0, 0, appFrameWidth-60-200, size.height+40);
//            
//            CGPoint point = CGPointMake(mpExplainView.center.x, mpExplainView.center.y-60);
//            mpExplainLabel.center = point;
//            mpCloseBtn.frame = CGRectMake(mpExplainLabel.left-35, mpExplainLabel.buttom-35, 30, 30);
            
            [UIView animateWithDuration:0.5 animations:^{
                mpExplainView.alpha = 1.0;
            }];
        }
        
        
    } else if (btn.tag == 101) {
        if ([mpDataAry count] > selectIndex) {
            NSDictionary * dic = mpDataAry[selectIndex];
            PredictTestViewCtr * lpViewCtr = [[PredictTestViewCtr alloc] init];
            lpViewCtr.testType = RANDOM;
            lpViewCtr.infoDic = dic;
            [self.navigationController pushViewController:lpViewCtr animated:YES];
            
        }
    }
}


-(void)addTableViewFootViewOne
{
    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 60)];
    UIButton * lpBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 60)];
    UIButton * lpBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 59, (1024-60)/2, 60)];
    [lpBtn1 setBackgroundImage:[UIImage imageNamed:@"cellBack.png"] forState:UIControlStateNormal];
    [lpBtn2 setBackgroundImage:[UIImage imageNamed:@"cellBack.png"] forState:UIControlStateNormal];

    [lpBtn1 addTarget:self action:@selector(footBtnClickOne:) forControlEvents:UIControlEventTouchUpInside];
//    [lpBtn2 addTarget:self action:@selector(footBtnClickOne:) forControlEvents:UIControlEventTouchUpInside];
    lpBtn1.tag = 100;
    lpBtn2.tag = 101;
    
    
    
    //    lpBtn1.layer.borderColor = [UIColor grayColor].CGColor;
    //    lpBtn1.layer.borderWidth = 1;
    //    lpBtn2.layer.borderColor = [UIColor grayColor].CGColor;
    //    lpBtn2.layer.borderWidth = 1;
    [lpBtn1 setTitle:@"简介" forState:UIControlStateNormal];
    [lpBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [lpBtn2 setTitle:@"本章测试" forState:UIControlStateNormal];
    [lpBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [lpView addSubview:lpBtn1];
//    [lpView addSubview:lpBtn2];
    
    UILabel * lpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, (1024-60)/2, 1)];
    lpLabel.backgroundColor = [UIColor lightGrayColor];
    [lpView addSubview:lpLabel];
    
    mpTableView.tableFooterView = lpView;
}

-(void)addTableViewFootViewTwo
{
    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 60)];
    UIButton * lpBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 60)];
    UIButton * lpBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 59, (1024-60)/2, 60)];
    [lpBtn1 addTarget:self action:@selector(footBtnClickOneTwo:) forControlEvents:UIControlEventTouchUpInside];
    [lpBtn2 addTarget:self action:@selector(footBtnClickOneTwo:) forControlEvents:UIControlEventTouchUpInside];
    lpBtn1.tag = 100;
    lpBtn2.tag = 101;
    
    
    
    //    lpBtn1.layer.borderColor = [UIColor grayColor].CGColor;
    //    lpBtn1.layer.borderWidth = 1;
    //    lpBtn2.layer.borderColor = [UIColor grayColor].CGColor;
    //    lpBtn2.layer.borderWidth = 1;
    [lpBtn1 setTitle:@"简介" forState:UIControlStateNormal];
    [lpBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [lpBtn2 setTitle:@"本章测试" forState:UIControlStateNormal];
    [lpBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [lpView addSubview:lpBtn1];
//    [lpView addSubview:lpBtn2];
    
    UILabel * lpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, (1024-60)/2, 1)];
    lpLabel.backgroundColor = [UIColor lightGrayColor];
    [lpView addSubview:lpLabel];
    
    mpTableViewRight.tableFooterView = lpView;
}



-(void)addTableView
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
    [mpBaseView addSubview:mpTableViewRight];
    
//    [self addTableViewFootViewOne];
    [self addTableViewFootViewTwo];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            NSDictionary* lpDic = objc_getAssociatedObject(alertView, @"payInfo");
            [PaymentAssistant paymentWithInfo:lpDic];
        }
    }
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if (![info ifInvolveStr:@"\"result\":\"1\""]) {
        return;
    }
    
    if (tag == 300) {
        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
            NSMutableDictionary * lpDic = [NSMutableDictionary dictionaryWithDictionary:[info JSONValue]];
            NSDictionary * dic = [mpDataAry objectAtIndex:miSelectIndex];
            [lpDic setValue:dic[@"Name"] forKey:@"productName"];
            [lpDic setValue:dic[@"Name"] forKey:@"productDescription"];
            
            NSString * total = [lpDic objectForKey:@"Total"];
            NSString * alterInfo = [NSString stringWithFormat:@"当前课程需付费，价格%@元", total];
            CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:alterInfo delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
            alertView.tag = 100;
            objc_setAssociatedObject(alertView, @"payInfo",lpDic, OBJC_ASSOCIATION_RETAIN);
            [alertView show];
        }
    }
    
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if (tag == 101) {
        [mpDataAry setArray: [[info JSONValue] objectForKey:@"list"]];
        [userDefaults setObject:mpDataAry forKey:@"CourseList"];
        [userDefaults synchronize];
        //        [self getSecondDataFromServiceWithIndex:0];
        [mpTableView reloadData];
        //    孙霖手机给你吧 138-0137-7895
        [[NSNotificationCenter defaultCenter] postNotificationName:@"originalData" object:mpDataAry];
    } else if (tag == 102) {
        
        //                NSLog(@"%@", info);
    } else if (tag >= 200) {
        NSArray * ary = [NSArray arrayWithArray:[[info JSONValue] objectForKey:@"list"]];
        [mpSecondDataDic setObject:ary forKey:[NSString stringWithFormat:@"%d", tag-200]];
        [mpTableViewRight reloadData];
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}

-(void)getDataFromService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.useCache = YES;
	operation.urlStr =[serverIp stringByAppendingFormat:@"/Course/CourseList.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"ParentID"];
    operation.downInfoDelegate = self;
    operation.tag = 101;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}

-(void)getSecondDataFromServiceWithIndex:(int)index
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.useCache = YES;
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/CourseList.action"];
    
    if ([mpDataAry count] > index) {
        NSDictionary * tempDic = [mpDataAry objectAtIndex:index];
        [operation.argumentDic setValue:[tempDic objectForKey:@"GUID"] forKey:@"ParentID"];
    } else {
        return;
    }
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    operation.tag = 200+index;
    [mpOperationQueue addOperation:operation];
}


-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
    mpSecondDataDic = [[NSMutableDictionary alloc] init];
    selectIndex = -1;
    
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray * CourseList = [userDefaults objectForKey:@"CourseList"];
    if (CourseList) {
        [mpDataAry setArray:CourseList];
    }
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

-(void)explalinCloseBtnClick
{
    [UIView animateWithDuration:0.5 animations:^{
        mpExplainView.alpha = 0.0;
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = [mpInfoDic objectForKey:@"Name"];
    [self addLeftButton];
    [self addTableView];
    [self addExplainView];
}

-(void)getPaymentWithInfo:(NSDictionary *)apDic
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Pay.action"];
    [operation.argumentDic setValue:[apDic objectForKey:@"GUID"] forKey:@"GUID"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    operation.tag = 300;
    [mpOperationQueue addOperation:operation];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView.tag == 101) {
        int count = [mpDataAry count];
        if (count < cellCount) {
            count = cellCount;
        }
        return count;
    } else {
        tableView.tableFooterView.hidden = NO;

        NSArray * ary = [mpSecondDataDic objectForKey:[NSString stringWithFormat:@"%d", selectIndex]];
        if (ary) {
            int count = [ary count];
            if (count == 0) {
                tableView.tableFooterView.hidden = YES;

            }
            return count;
//            if (count < cellCount) {
//                count = cellCount;
//            }
//            return count;
        }
        tableView.tableFooterView.hidden = YES;

        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        NSString * identify = @"cell";
        FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        
        cell->alreadPay.hidden = YES;
        cell->mpIconImageView.hidden = YES;
        cell->mpLabel2.text = @"";

        
        if ([mpDataAry count] > indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            NSDictionary * lpDic = [mpDataAry objectAtIndex:indexPath.row];
            cell->mpIconImageView.hidden = NO;
            [cell->mpIconImageView setImageWithURL:[NSURL URLWithString:[lpDic objectForKey:@"Logo"]] placeholderImage:[UIImage imageNamed:@"picGreen.png"]];
            cell->mpLabel.text = [lpDic objectForKey:@"Name"];
            
            NSDictionary * dic = mpDataAry[indexPath.row];
            if ([dic[@"Payed"] isEqualToString:@"False"]) {
                cell->alreadPay.hidden = NO;
            } else {
                NSInteger KnowledgeCount = [dic[@"KnowledgeCount"] integerValue];
                if (KnowledgeCount == 0) {
                    cell->mpImageView.hidden = NO;
                    NSString * isRead = [dic objectForKey:@"IsRead"];
                    if ([isRead isEqualToString:@"False"]) {
                        cell->mpImageView.image = [UIImage imageNamed:@"notRead.png"];
                    } else {
                        cell->mpImageView.image = [UIImage imageNamed:@"hadRead.png"];
                    }
                }
            }
            
        } else if([mpDataAry count] == indexPath.row){
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell->mpImageView.image = nil;
//            cell->mpLabel2.text = @"简介";
//            cell->mpLabel.text = @"";
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell->mpImageView.image = nil;
            cell->mpLabel.text = @"";
        }
        
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
        
    } else {
        NSString * identify = @"cell2";
        FirstTableViewTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[FirstTableViewTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell->alreadPay.hidden = YES;
        cell->mpIconImageView.hidden = YES;
        cell->mpImageView.hidden = YES;


        
        
        NSArray * ary = [mpSecondDataDic objectForKey:[NSString stringWithFormat:@"%d", selectIndex]];
        if (ary && [ary count] > indexPath.row) {
            NSDictionary * tempDic = [ary objectAtIndex:indexPath.row];
            NSString * name = [tempDic objectForKey:@"Name"];
            NSString * Logo = [tempDic objectForKey:@"Logo"];
            
            if ([tempDic[@"Payed"] isEqualToString:@"False"]) {
                cell->alreadPay.hidden = NO;
            } else {
                NSInteger KnowledgeCount = [tempDic[@"KnowledgeCount"] integerValue];
                if (KnowledgeCount == 0) {
                    cell->mpImageView.hidden = NO;
                    NSString * isRead = [tempDic objectForKey:@"IsRead"];
                    if ([isRead isEqualToString:@"False"]) {
                        cell->mpImageView.image = [UIImage imageNamed:@"notRead.png"];
                    } else {
                        cell->mpImageView.image = [UIImage imageNamed:@"hadRead.png"];
                    }
                }
            }

            
            cell->mpIconImageView.hidden = NO;
            [cell->mpIconImageView setImageWithURL:[NSURL URLWithString:Logo] placeholderImage:[UIImage imageNamed:@"picGreen.png"]];
            cell->mpLabel.text = name;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell->mpImageView.image = nil;
            cell->mpIconImageView.image = nil;
            cell->mpLabel.text = @"";
        }
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        if ([mpDataAry count] == indexPath.row) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            NSMutableString * CourseBrief = [NSMutableString stringWithString:mpInfoDic[@"CourseBrief"]];
            [self resetString:CourseBrief];
            
            mpExplainLabel.text = CourseBrief;
                       [UIView animateWithDuration:0.5 animations:^{
                           mpExplainView.alpha = 1.0;
            }];
            return;

        }
        if ([mpDataAry count] <= indexPath.row) {
            return;
        }
        NSDictionary * dic = mpDataAry[indexPath.row];
        if ([dic[@"Payed"] isEqualToString:@"False"]) {
            miSelectIndex = indexPath.row;
            [self getPaymentWithInfo:dic];
            return;
        } else {
            NSInteger KnowledgeCount = [dic[@"KnowledgeCount"] integerValue];
            if (KnowledgeCount == 0) {
                FirstViewThreeController * lpViewCtr = [[FirstViewThreeController alloc] init];
                lpViewCtr.infoDic = dic;
                [self.navigationController pushViewController:lpViewCtr animated:YES];
                return;
            }
        }

        
        
        
        
        selectIndex = indexPath.row;
        NSString * key = [NSString stringWithFormat:@"%d", selectIndex];
        if (mpSecondDataDic[key]) {
            [mpTableViewRight reloadData];
        } else {
            [self getSecondDataFromServiceWithIndex:indexPath.row];
        }
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSString * key = [NSString stringWithFormat:@"%d", selectIndex];
        NSArray * tempAry = mpSecondDataDic[key];
        if (!tempAry) {
            return;
        }
        
        if ([tempAry count] <= indexPath.row) {
            return;
        }
        NSDictionary * dic = tempAry[indexPath.row];
        if ([dic[@"Payed"] isEqualToString:@"False"]) {
            miSelectIndex = indexPath.row;
            [self getPaymentWithInfo:dic];
        } else {
            NSInteger KnowledgeCount = [dic[@"KnowledgeCount"] integerValue];
            if (KnowledgeCount == 0) {
                FirstViewThreeController * lpViewCtr = [[FirstViewThreeController alloc] init];
                lpViewCtr.infoDic = dic;
                [self.navigationController pushViewController:lpViewCtr animated:YES];
            } else {
                FirstTwoViewController * lpViewCtr = [[FirstTwoViewController alloc] init];
                lpViewCtr.infoDic = dic;
                [self.navigationController pushViewController:lpViewCtr animated:YES];
            }
        }
        //        if ([mpTitleLabel.text isEqualToString:@"真题演练"]) {
        //            lpViewCtr.testType=Zhenti;
        //        } else if ([mpTitleLabel.text isEqualToString:@"模拟考试"]) {
        //            lpViewCtr.testType=Moni;
        //        }
        
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
