//
//  SearchViewController.m
//  ExaminationIpad
//
//  Created by gurd on 13-11-11.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "SearchViewController.h"
#import "FirstTwoViewController.h"
#import "FirstViewThreeController.h"
#import "searchCell.h"
#import "CustomAlertView.h"
#import <objc/runtime.h>
#import "PaymentAssistant.h"

@interface SearchViewController ()
<UITableViewDataSource, UITableViewDelegate, downLoadDelegate, UISearchBarDelegate>
{
    UISearchBar * _searchBar;
    UITableView * _tableView;
    NSMutableArray * mpDataAry;
    int selectIndex;
    int miSelectIndex;
}
@end

@implementation SearchViewController

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

-(void)addSubViews
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, appFrameWidth-60, 40)];
//    _searchBar.keyboardType
    _searchBar.delegate = self;
    [mpBaseView addSubview:_searchBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchBar.buttom, appFrameWidth-60, appFrameHeigh-44-40)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [mpBaseView addSubview:_tableView];
}

-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
//    [_searchBar resignFirstResponder];

//    [self getDataFromService];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    [_searchBar resignFirstResponder];
//    _searchBar.text = @"进行时";
    [self getDataFromService];
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
        return;
    }

    
    NSDictionary * dic = [info JSONValue];
    NSArray * ary = dic[@"list"];
    if ([ary count] == 0) {
        [NewItoast showItoastWithMessage:@"没有搜到结果"];
    } else {
        [mpDataAry setArray:[NSArray arrayWithArray:dic[@"list"]]];
        [_tableView reloadData];
    }
}

-(void)getDataFromService
{
    if (_searchBar.text.length == 0) {
        return;
    }
    [_searchBar resignFirstResponder];
    commonDataOperation * operation = [[commonDataOperation alloc] init];
//    operation.useCache = YES;
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/KnowledgeSearch.action"];
    [operation.argumentDic setObject:[NSString stringWithString:_searchBar.text] forKey:@"Keyword"];
//    [operation.argumentDic setObject:@"进行时" forKey:@"Keyword"];
    operation.downInfoDelegate = self;
    operation.tag = 101;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    
//    _searchBar.text = @"";
    
    
//    Course/KnowledgeSearch.action搜索知识点，输入参数Keyword －－－keyworld
}

-(void)getPaymentWithInfo:(NSDictionary *)apDic
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Pay.action"];
//    [operation.argumentDic setValue:[apDic objectForKey:@"GUID"] forKey:@"GUID"];
    [operation.argumentDic setValue:apDic[@"PayCourseID"] forKey:@"GUID"];

    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    operation.tag = 300;
    [mpOperationQueue addOperation:operation];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = @"搜索";
    [self addLeftButton];
    [self addSubViews];
	// Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mpDataAry count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[searchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell->alreadPay.hidden = YES;
    
    
    if ([mpDataAry count] > indexPath.row) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        NSDictionary * dic = mpDataAry[indexPath.row];
        cell->mpLabel.text = [dic objectForKey:@"Name"];

        if ([dic[@"Payed"] isEqualToString:@"False"]) {
            cell->alreadPay.hidden = NO;
        } else {
        }
        
    }
//    cell.textLabel.text = @"cell";
//    {
//        GUID = "3f066542-6fe0-48b1-a9a1-5b0afb4ae3a6";
//        Name = "\U9a6c\U514b\U601d\U4e3b\U4e49\U7684\U4ea7\U751f";
//    },

//    NSDictionary * dic = [mpDataAry objectAtIndex:indexPath.row];
//    cell.textLabel.text = dic[@"Name"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([mpDataAry count] <= indexPath.row) {
        return;
    }
    NSDictionary * dic = mpDataAry[indexPath.row];
    if ([dic[@"Payed"] isEqualToString:@"False"]) {
        miSelectIndex = indexPath.row;
        [self getPaymentWithInfo:dic];
        return;
    }

    
    
    FirstViewThreeController * lpViewCtr = [[FirstViewThreeController alloc] init];
    lpViewCtr.infoDic = mpDataAry[indexPath.row];
    UINavigationController * nc = self.navigationController;
    [nc popViewControllerAnimated:NO];
    [nc pushViewController:lpViewCtr animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
