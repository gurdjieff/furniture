//
//  SecondTwoViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-7-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "SecondTwoViewController.h"
#import "FirstViewController.h"
#import "FirstViewController.h"
#import "PredictTestViewCtr.h"
#import "FirstTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RealPracticeCell.h"
#import "PredictTestViewCtr.h"
#import "UIImageView+WebCache.h"


#define cellHight 60.0f
#define cellCount 12

@interface SecondTwoViewController ()


@end

@implementation SecondTwoViewController
@synthesize theTitle = _theTitle;
@synthesize LS;

- (id)init
{
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)addFreshView
{
    mpHeaderView = [[EGORefreshTableHeaderView alloc] initHeadFreshView];
    mpHeaderView.delegate = self;
    [mpTableView addSubview:mpHeaderView];
    
    mpFooterView = [[EGORefreshTableHeaderView alloc] initHeadFreshView];
    mpFooterView.delegate = self;
    [mpFooterView addSubview:mpHeaderView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0) {
        [mpHeaderView egoRefreshScrollViewDidScroll:mpTableView];
    } else {
        [mpFooterView egoRefreshScrollViewDidScroll:mpTableView];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y > 0) {
        [mpHeaderView egoRefreshScrollViewDidEndDragging:mpTableView];
    } else {
        [mpFooterView egoRefreshScrollViewDidEndDragging:mpTableView];
    }
}

-(void)stopRefreshView
{
    [mpHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:mpTableView];
    [mpFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:mpTableView];
}

-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view loadType:(loadType)type
{
    if (type == HEAD) {
        
    } else {
        
    }
//    [self getDataFromService];
}

-(void)setTableViewCellSelecet
{
    [mpTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
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
    [mpBaseView addSubview:mpTableViewRight];
}

-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
    if ([_theTitle isEqualToString:@"书签笔记"]) {
    } else {
        [mpDataAry setArray:[FirstViewController getOriginalDataAry]];
    }

    mpSecondDataDic = [[NSMutableDictionary alloc] init];
    selectIndex = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = _theTitle;
    [self addLeftButton];
    [self addTableViews];
    [self getDataFromService];
//    [self addFreshView];
//    [self getSecondDataFromServiceWithIndex:0];
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
        NSArray * ary = [mpSecondDataDic objectForKey:[NSString stringWithFormat:@"%d", selectIndex]];
        if (ary) {
            int count = [ary count];
            if (count < cellCount) {
                count = cellCount;
            }
            return count;
        }
        return cellCount;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        NSString * identify = @"cell";
        RealPracticeCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[RealPracticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            [cell resetLabel];
        }
        
        if ([mpDataAry count] > indexPath.row) {
            NSDictionary * lpDic = [mpDataAry objectAtIndex:indexPath.row];
            [cell->mpImageView setImageWithURL:[NSURL URLWithString:[lpDic objectForKey:@"Logo"]] placeholderImage:[UIImage imageNamed:@"picGreen.png"]];
            cell->mpLabel.text = [lpDic objectForKey:@"Name"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell->mpLabel.text = @"";
            [cell->mpImageView setImage:nil];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
        
    } else {
        NSString * identify = @"cell";
        RealPracticeCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[RealPracticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell->mpBackImageView.hidden = YES;
        NSArray * ary = [mpSecondDataDic objectForKey:[NSString stringWithFormat:@"%d", selectIndex]];
        if (ary && [ary count] > indexPath.row) {
            NSDictionary * tempDic = [ary objectAtIndex:indexPath.row];
            NSString * name = [tempDic objectForKey:@"Name"];
            cell->mpLabel.text = name;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell->mpLabel.text = @"";

        }
    
        return cell;
    }
}


//- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	
//    NSString *CellIdentifier = @"Cell";
//    RealPracticeCell * cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil){
//        cell=[[RealPracticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.selectionStyle=UITableViewCellSelectionStyleGray;
//    }
//    
//    NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
//    cell->mpLabel.text =[dic objectForKey:@"Name"];
//    return cell;
//    
//}

/*
    if (LS ==cuotizhongxin)
    {
        
        CuoTiCell * cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell=[[CuoTiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
        }
                
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
        cell.timulabel.text =[dic objectForKey:@"Name"];
        NSString * fenshuStr =[NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"Count"],[dic objectForKey:@"Total"]];
        cell.zhishilabel.text =fenshuStr;
        return cell;
        
    } else if(LS == zhentiyanlian || LS == monikaoshi)
    {
        NSString * identify = @"cell";
        FirstTableViewCell * cell = [tableViews dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        
        NSArray * topArr =[FirstViewController getOriginalDataAry];
        NSDictionary * lpDic =[topArr objectAtIndex:indexPath.row];
        
        [cell->mpImageView setImageWithURL:[NSURL URLWithString:[lpDic objectForKey:@"Logo"]] placeholderImage:[UIImage imageNamed:@"picGreen.png"]];
        cell->mpLabel.text = [lpDic objectForKey:@"Name"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        UITableViewCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            cell.contentView.backgroundColor =[UIColor clearColor];
            cell.textLabel.backgroundColor =[UIColor clearColor];
            cell.textLabel.textAlignment = UITextAlignmentLeft;
            cell.backgroundColor =[UIColor clearColor];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font =[UIFont boldSystemFontOfSize:20];
            cell.textLabel.textColor = [UIColor darkGrayColor];
            UIImageView* lpImageView=[[UIImageView alloc] init];
            lpImageView.backgroundColor = cellSeparateColor;
            lpImageView.frame=CGRectMake(0, 47, 320, 1);
            [cell.contentView addSubview:lpImageView];
        }
        
        
        if (LS == yanlanshijuan || LS == tiku) {
            NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
            NSString * namestr = [dic objectForKey:@"Name"];
            cell.textLabel.text = namestr;
        }
        
        return cell;
    }
}
 */


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        
        NSDictionary * dic = mpDataAry[indexPath.row];
        PredictTestViewCtr * lpViewCtr = [[PredictTestViewCtr alloc] init];
        lpViewCtr.infoDic = dic;
        
        if ([mpTitleLabel.text isEqualToString:@"真题演练"]) {
            lpViewCtr.testType=Zhenti;
        } else if ([mpTitleLabel.text isEqualToString:@"模拟考试"]) {
            lpViewCtr.testType=Moni;
        }
        [self.navigationController pushViewController:lpViewCtr animated:YES];

        return;
        selectIndex = indexPath.row;
        NSString * key = [NSString stringWithFormat:@"%d", selectIndex];
        NSArray * ary = mpSecondDataDic[key];
        [mpTableViewRight reloadData];
        if (ary && [ary count] > 0) {
//            [mpTableViewRight reloadData];
        } else {
            [self getSecondDataFromServiceWithIndex:indexPath.row];
        }
    } else {
        return;
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
        PredictTestViewCtr * lpViewCtr = [[PredictTestViewCtr alloc] init];
        lpViewCtr.infoDic = dic;
       
        if ([mpTitleLabel.text isEqualToString:@"真题演练"]) {
            lpViewCtr.testType=Zhenti;
        } else if ([mpTitleLabel.text isEqualToString:@"模拟考试"]) {
            lpViewCtr.testType=Moni;
        }
        [self.navigationController pushViewController:lpViewCtr animated:YES];
    }
    return;
    
    
    
    if (LS == zhentiyanlian
        || LS ==monikaoshi)
    {
        
        NSArray * topArr =[FirstViewController getOriginalDataAry];
        NSDictionary * dic =[topArr objectAtIndex:indexPath.row];

        SecondTwoViewController  * vc =[[SecondTwoViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.theTitle = [dic objectForKey:@"Name"];
//        vc.infoDict = dic;


        if (LS==zhentiyanlian)
        {
            vc.LS = yanlanshijuan;
        }
        
        
        if (LS ==monikaoshi)
        {
            vc.LS = tiku;
        }
                 
        [self.navigationController pushViewController:vc animated:YES];        
    } else if (LS == yanlanshijuan
             || LS ==tiku
             || LS ==cuotizhongxin) {
//        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
//        PredictTestViewCtr * lpViewCtr = [[PredictTestViewCtr alloc] init];
//        lpViewCtr.infoDic = dic;
//        
//        if (LS==yanlanshijuan)
//            lpViewCtr.testType=Zhenti;
//        if (LS==tiku)
//            lpViewCtr.testType=Moni;
//        if (LS==cuotizhongxin)
//            lpViewCtr.testType=Cuoti;
//        
//        [self.navigationController pushViewController:lpViewCtr animated:YES];
    }
 }




#pragma mark - http


-(void)getSecondDataFromServiceWithIndex:(int)index
{
    if ([mpTitleLabel.text isEqualToString:@"真题演练"]) {
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.useCache = YES;
        operation.urlStr = [serverIp stringByAppendingFormat:@"/Exam/PoolList.action"];
        if ([mpDataAry count] > index) {
            NSDictionary * tempDic = [mpDataAry objectAtIndex:index];
            [operation.argumentDic setValue:[tempDic objectForKey:@"GUID"] forKey:@"CourseID"];
        }
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        operation.tag = 200+index;
        [mpOperationQueue addOperation:operation];
    } else if ([mpTitleLabel.text isEqualToString:@"模拟考试"]) {
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.useCache = YES;
        operation.urlStr = [serverIp stringByAppendingFormat:@"/Exam/QuizList.action"];
        if ([mpDataAry count] > index) {
            NSDictionary * tempDic = [mpDataAry objectAtIndex:index];
            [operation.argumentDic setValue:[tempDic objectForKey:@"GUID"] forKey:@"CourseID"];
        }
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        operation.tag = 200+index;
        [mpOperationQueue addOperation:operation];
    } else if ([mpTitleLabel.text isEqualToString:@"书签笔记"]) {
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.useCache = YES;
        operation.urlStr = [serverIp stringByAppendingFormat:@"/Exam/QuizList.action"];
        if ([mpDataAry count] > index) {
            NSDictionary * tempDic = [mpDataAry objectAtIndex:index];
            [operation.argumentDic setValue:[tempDic objectForKey:@"GUID"] forKey:@"CourseID"];
        }
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        operation.tag = 200+index;
        [mpOperationQueue addOperation:operation];
    }
}

-(void)getDataFromService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init] ;
    operation.tag =100;
    operation.useCache = YES;
    if ([mpTitleLabel.text isEqualToString:@"真题演练"]) {
        operation.urlStr = [serverIp stringByAppendingString:@"/Exam/PoolList.action"];
    } else if ([mpTitleLabel.text isEqualToString:@"模拟考试"]) {
                operation.urlStr = [serverIp stringByAppendingString:@"/Exam/QuizList.action"];

    
    }
//    if ([mpTitleLabel.text isEqualToString:@"书签笔记"]) {
      
        
//        operation.urlStr = [serverIp stringByAppendingString:@"/Course/NoteList.action"];

    
//    @"/Exam/PoolList.action"
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
//    } else if ([mpTitleLabel.text isEqualToString:@""]) {
//        commonDataOperation * operation = [[commonDataOperation alloc] init] ;
//        operation.tag =100;
//        operation.urlStr = [serverIp stringByAppendingString:@"/Exam/PoolList.action"];
//        operation.downInfoDelegate = self;
//        operation.isPOST = YES;
//        [mpOperationQueue addOperation:operation];
//    }
    return;
    
    NSString * urlString = nil;
    if (LS == zhentiyanlian
        || LS == monikaoshi) {
        return;
    } else if (LS == cuotizhongxin) {
        commonDataOperation * operation = [[commonDataOperation alloc] init] ;
        urlString = @"/Exam/QuizUserList.action";
        operation.tag =100;
        operation.urlStr = [serverIp stringByAppendingString:urlString];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [[Common getOperationQueue] addOperation:operation];
    } else if (LS == yanlanshijuan || LS ==tiku ) {
        commonDataOperation * operation = [[commonDataOperation alloc] init] ;
        //真题
        if (LS == yanlanshijuan)
        {
            urlString = @"/Exam/PoolList.action";
            operation.tag =101;
        }
        
        //模拟题库
        else if (LS ==tiku) {
            urlString = @"/Exam/QuizList.action";
            operation.tag =102;
        }
             
        operation.urlStr = [serverIp stringByAppendingString:urlString];

//        [operation.argumentDic setValue:[infoDict objectForKey:@"GUID"] forKey:@"CourseID"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [[Common getOperationQueue] addOperation:operation];
    } else if (LS == shuqianbiji) {
        
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",info);
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if (![info ifInvolveStr:@"list"]) {
        return;
    }
    
    if (tag >= 200) {
        NSArray * ary = [NSArray arrayWithArray:[[info JSONValue] objectForKey:@"list"]];
        [mpSecondDataDic setObject:ary forKey:[NSString stringWithFormat:@"%d", tag-200]];
        [mpTableViewRight reloadData];
    } else if (tag == 100) {
        NSArray * ary = [NSArray arrayWithArray:[[info JSONValue] objectForKey:@"list"]];
        [mpDataAry setArray:ary];
        [mpTableView reloadData];
    }

    
//    if (tag == 100) {
//        [mpHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:mpTableView];
//        [mpDataAry setArray: [[info JSONValue] objectForKey:@"list"]];
//        [userDefaults setObject:mpDataAry forKey:@"CourseList"];
//        [userDefaults synchronize];
//        [self getSecondDataFromServiceWithIndex:0];
//        [mpTableView reloadData];
//        [self performSelector:@selector(setTableViewCellSelecet) withObject:nil afterDelay:0.05];
//        //    孙霖手机给你吧 138-0137-7895
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"originalData" object:mpDataAry];
//    } else if (tag == 102) {
//        
//        //                NSLog(@"%@", info);
//    } else if (tag >= 200) {
//        NSArray * ary = [NSArray arrayWithArray:[[info JSONValue] objectForKey:@"list"]];
//        [mpSecondDataDic setObject:ary forKey:[NSString stringWithFormat:@"%d", tag-200]];
//        [userDefaults setObject:ary forKey:@"CourseList1"];
//        [userDefaults synchronize];
//        [mpTableViewRight reloadData];
//    }
}

@end
