//
//  CampusInfoViewCtr.m
//  ExaminationIpad
//
//  Created by gurdjieff on 13-8-17.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "CampusInfoViewCtr.h"
#import "CampusTableCell.h"
#import "NewItoast.h"
#import "AppDelegate.h"

@interface CampusInfoViewCtr ()

@end

@implementation CampusInfoViewCtr
@synthesize theTitle = _theTitle;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setTableViewCellSelecet
{
    [mpTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}


-(void)addTableView
{
    mpBaseView.backgroundColor = cellBackColor;
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 748-44)];
    imageView.image = [UIImage imageNamed:@"cellBack.png"];
    [mpBaseView addSubview:imageView];
    
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 748-44) style:UITableViewStylePlain];
    mpTableView.tag = 101;
    mpTableView.showsVerticalScrollIndicator = NO;
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.separatorColor = [UIColor clearColor];
    mpTableView.backgroundColor = [UIColor clearColor];
    [mpBaseView addSubview:mpTableView];
}

-(void)addWebView
{
    int version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
//    mpWebView = [[UIWebView alloc] initWithFrame:CGRectMake((1024-60)/2+20, 0, (1024-60)/2-20, appFrameHeigh-44)];
    mpWebView = [[UIWebView alloc] initWithFrame:CGRectMake((1024-60)/2, 0, (1024-60)/2, appFrameHeigh-44)];

    mpWebView.backgroundColor = cellBackColor;
    [mpBaseView addSubview:mpWebView];
}

-(void)rightBtnClick
{
    [NewItoast showItoastWithMessage:@"功能待完善中。。。"];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([appDelegate.dicData allValues] == 0) {
        [appDelegate sendInitialInfo];
    } else {
        NSString * phone =[appDelegate.dicData objectForKey:@"HotLine"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phone]];
        [[UIApplication sharedApplication] openURL:url];
    }
}

-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(appFrameWidth-90, 7, 80, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"我要报名" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}


-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
    mpSecondDataDic = [[NSMutableDictionary alloc] init];
    selectIndex = 0;
}

-(void)reLoadWebViewContent
{
    NSString * key = [NSString stringWithFormat:@"%d", selectIndex];
    NSString * lpContent = mpSecondDataDic[key];
    [mpWebView loadHTMLString:lpContent baseURL:nil];
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if (![info ifInvolveStr:@"\"result\":\"1\""]) {
        return;
    }
    
    if (tag == 101) {
        [mpDataAry setArray: [[info JSONValue] objectForKey:@"list"]];
        [mpTableView reloadData];
    } else if (tag >= 200) {
        NSString * content = [NSString stringWithString:[[info JSONValue] objectForKey:@"Detail"]];
        [mpSecondDataDic setObject:content forKey:[NSString stringWithFormat:@"%d", tag-200]];
        [self reLoadWebViewContent];
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{

}


-(void)getDataFromService
{
    if ([mpTitleLabel.text isEqualToString:@"名家讲堂"]) {
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.useCache = YES;
        operation.tag = 101;
        operation.urlStr = [serverIp stringByAppendingString:@"/Application/TeacherList.action"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
    } else if ([mpTitleLabel.text isEqualToString:@"学校信息"]) {
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.tag = 101;
        operation.useCache = YES;
        operation.urlStr = [serverIp stringByAppendingString:@"/Application/SchoolList.action"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
    }
}



-(void)getSecondDataFromServiceWithIndex:(int)index
{
    NSString * lpGuid = nil;
    if ([mpDataAry count] > index) {
        NSDictionary * tempDic = [mpDataAry objectAtIndex:index];
        lpGuid = tempDic[@"GUID"];        
    } else {
        return;
    }

    
    if ([mpTitleLabel.text isEqualToString:@"名家讲堂"]) {
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        operation.tag = 200+index;
        [operation.argumentDic setValue:lpGuid forKey:@"GUID"];
        operation.urlStr = [serverIp stringByAppendingString:@"/Application/TeacherView.action"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        operation.useCache = YES;
        [mpOperationQueue addOperation:operation];
    } else if ([mpTitleLabel.text isEqualToString:@"学校信息"]) {
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        [operation.argumentDic setValue:lpGuid forKey:@"GUID"];
        operation.tag = 200+index;
        operation.urlStr = [serverIp stringByAppendingString:@"/Application/SchoolView.action"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        operation.useCache = YES;
        [mpOperationQueue addOperation:operation];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    mpTitleLabel.text = _theTitle;
    [self initData];
    [self addLeftButton];
//    [self addRightBtn];
    [self addTableView];
    [self addWebView];
    [self getDataFromService];
	// Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mpDataAry count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = @"cell";
    CampusTableCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[CampusTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSDictionary * lpDic = [mpDataAry objectAtIndex:indexPath.row];
    cell->mpLabel.text = [lpDic objectForKey:@"Name"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        selectIndex = indexPath.row;
        NSString * key = [NSString stringWithFormat:@"%d", selectIndex];
        [self reLoadWebViewContent];
        if (mpSecondDataDic[key]) {
        } else {
            [self getSecondDataFromServiceWithIndex:selectIndex];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
