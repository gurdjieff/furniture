//
//  MistakeTestViewCtr.m
//  ExaminationIpad
//
//  Created by gurdjieff on 13-8-17.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "MistakeTestViewCtr.h"
#import "MistakeProblemCell.h"
#import "PredictTestViewCtr.h"

@interface MistakeTestViewCtr ()

@end

@implementation MistakeTestViewCtr
@synthesize theTitle = _theTitle;

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

-(void)addTableViews
{
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, (1024-60), 748-44) style:UITableViewStylePlain];
    mpTableView.tag = 101;
    mpTableView.showsVerticalScrollIndicator = NO;
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.separatorColor = [UIColor clearColor];
    mpTableView.backgroundColor = cellBackColor;
    [mpBaseView addSubview:mpTableView];
}

-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
}

#pragma mark - http
-(void)getDataFromService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init] ;
    operation.tag =100;
    operation.useCache = YES;
    operation.urlStr = [serverIp stringByAppendingString:@"/Exam/QuizUserList.action"];
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
    if (![info ifInvolveStr:@"list"]) {
        return;
    }
    [mpDataAry setArray: [[info JSONValue] objectForKey:@"list"]];
    [mpTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = _theTitle;
    [self addLeftButton];
    [self addTableViews];
}

#pragma mark - Table view data source


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mpDataAry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = @"cell";
    MistakeProblemCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[MistakeProblemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    NSDictionary * lpDic = [mpDataAry objectAtIndex:indexPath.row];
    NSString * fenshuStr =[NSString stringWithFormat:@"%@/%@",[lpDic objectForKey:@"Count"],[lpDic objectForKey:@"Total"]];
    cell->mpLabel.text = [lpDic objectForKey:@"Name"];
    cell->mpLabel2.text = fenshuStr;
    NSString * date = lpDic[@"PostDate"];
    NSString * yearDate = [[date componentsSeparatedByString:@" "] objectAtIndex:0];
    cell->mpLabel3.text = yearDate;
    //

    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dic =[mpDataAry objectAtIndex:indexPath.row];
    PredictTestViewCtr * lpViewCtr = [[PredictTestViewCtr alloc] init];
    lpViewCtr.infoDic = dic;
    lpViewCtr.testType=Cuoti;
    [self.navigationController pushViewController:lpViewCtr animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
