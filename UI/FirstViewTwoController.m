//
//  FirstViewTwoController.m
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FirstViewTwoController.h"
#import "FirstTableViewTwoCell.h"
#import "NSString+CustomCategory.h"
#import "FirstViewThreeController.h"

@interface FirstViewTwoController ()

@end

@implementation FirstViewTwoController
@synthesize infoDic = mpInfoDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)addTableView
{
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, appFrameHeigh-44) style:UITableViewStylePlain];
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.backgroundColor = cellBackColor;
    mpTableView.separatorColor = [UIColor clearColor];
    [mpBaseView addSubview:mpTableView];
    [mpTableView release];
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if (![info ifInvolveStr:@"list"]) {
        return;
    }
    
    [mpDataAry setArray: [[info JSONValue] objectForKey:@"list"]];
    [mpTableView reloadData];
    //    孙霖手机给你吧 138-0137-7895
    
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}


-(void)getDataFromService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/KnowledgeList.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"ParentID"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
    [operation release];
}

-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = [mpInfoDic objectForKey:@"Name"];
    [self addLeftButton];
    [self addTableView];
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
    FirstTableViewTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[FirstTableViewTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
    }
    
    NSDictionary * tempDic = [mpDataAry objectAtIndex:indexPath.row];
    NSString * isRead = [tempDic objectForKey:@"IsRead"];
    NSString * name = [tempDic objectForKey:@"Name"];
    if ([isRead isEqualToString:@"False"]) {
        cell->mpImageView.image = [UIImage imageNamed:@"notRead.png"];
    } else {
        cell->mpImageView.image = [UIImage imageNamed:@"hadRead.png"];
    }
    
    cell->mpLabel.text = name;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FirstViewThreeController * lpView = [[FirstViewThreeController alloc] init];
    lpView.infoDic = [mpDataAry objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:lpView animated:YES];
    [lpView release];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.0f;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [mpInfoDic release], mpInfoDic = nil;
    [mpDataAry release], mpDataAry = nil;
    [super dealloc];
}

@end
