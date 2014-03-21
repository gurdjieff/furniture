//
//  BookRemarkViewController.m
//  ExaminationIpad
//
//  Created by gurd on 13-8-26.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BookRemarkViewController.h"
#import "RealPracticeCell.h"
#import "FirstViewThreeController.h"
#define cellHight 60.0f
#define cellCount 12
@interface BookRemarkViewController ()
{
    UILabel * mpLabel;
}
@end

@implementation BookRemarkViewController
@synthesize theTitle = _theTitle;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
}

-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
    mpSecondDataDic = [[NSMutableDictionary alloc] init];
    selectIndex = 0;
}
-(void)resetRemarkContent
{
    NSString * key = [NSString stringWithFormat:@"%d", selectIndex];
    NSString * lpContent = mpSecondDataDic[key];
    mpTextView.text = lpContent;
}

-(void)knowledgeBtnClick
{
    FirstViewThreeController * lpViewCtr = [[FirstViewThreeController alloc] init];
    if ([mpDataAry count] <= selectIndex) {
        return;
    }
    lpViewCtr.infoDic = mpDataAry[selectIndex];
    [self.navigationController pushViewController:lpViewCtr animated:YES];
}

-(void)addRemarkView
{
    mpRemarkView = [[UIView alloc] initWithFrame:CGRectMake((1024-60)/2, 0, (1024-60)/2, appFrameHeigh-44)];
    mpRemarkView.backgroundColor = cellBackColor;
    [mpBaseView addSubview:mpRemarkView];
    
    mpLabel = [[UILabel alloc] init];
    [mpLabel setFrame:CGRectMake(20, 10, 60, 42)];
    mpLabel.clipsToBounds = YES;
    mpLabel.font = [UIFont systemFontOfSize:18];
    mpLabel.backgroundColor = [UIColor clearColor];
    mpLabel.text = @"笔记";
    [mpRemarkView addSubview:mpLabel];
    UIButton * lpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 100, 40)];
    [lpBtn addTarget:self action:@selector(knowledgeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpRemarkView addSubview:lpBtn];
    
    [self resetLabel];
    
    
    
    
    
    UILabel * lpLabel2 = [[UILabel alloc] init];
    [lpLabel2 setFrame:CGRectMake(0, 36, 200, 1)];
    lpLabel2.backgroundColor = [UIColor blackColor];
    [mpLabel addSubview:lpLabel2];
    
    mpTextView = [[UITextView alloc] init];
    mpTextView.font = [UIFont systemFontOfSize:17];
    mpTextView.backgroundColor = [UIColor clearColor];
//    mpTextView.editable = NO;
    [mpTextView setFrame:CGRectMake(20.0, 40, (1024-60)/2-40, appFrameHeigh-44-50)];
    [mpRemarkView addSubview:mpTextView];

}

-(void)resetLabel
{
    CGSize size = [mpLabel.text sizeWithFont:mpLabel.font constrainedToSize:CGSizeMake(300, 20) lineBreakMode:NSLineBreakByWordWrapping];
    [mpLabel setWidth:size.width];
}

-(void)saveDataToService
{
    if ([mpDataAry count] <= selectIndex) {
        return;
    }
    
    if (mpTextView.text.length == 0) {
        return;
        //        [iLoadAnimationView showItoastMesage:@""];
    }
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Note.action"];
    [operation.argumentDic setValue:[mpDataAry[selectIndex] objectForKey:@"GUID"] forKey:@"CourseID"];
    operation.tag = 101;
    NSString * info = [NSString stringWithString:mpTextView.text];
    
//    if (info.length == 0 && mpRemarkDic[@"GUID"]) {
//        [operation.argumentDic setValue:mpRemarkDic[@"GUID"] forKey:@"GUID"];
//    }
    [operation.argumentDic setValue:info forKey:@"Brief"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}

-(void)rightBtnClick
{
    [self saveDataToService];
}

-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(appFrameWidth-70, 7, 60, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"发表" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self addRightBtn];
    mpTitleLabel.text = _theTitle;
    [self addLeftButton];
    [self addTableViews];
    [self addRemarkView];
    [self getDataFromService];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

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
            NSString * guid = mpDataAry[indexPath.row][@"NoteID"];
            [self deletePlanFromService:guid];
        }
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [mpDataAry count];
    if (count < cellCount) {
        count = cellCount;
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = @"cell";
    RealPracticeCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[RealPracticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
//    cell->mpBackImageView.hidden = YES;
    
    if ([mpDataAry count] > indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSDictionary * lpDic = [mpDataAry objectAtIndex:indexPath.row];
        cell->mpLabel.text = [lpDic objectForKey:@"Name"];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell->mpLabel.text = @"";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        selectIndex = indexPath.row;

        if ([mpDataAry count] > selectIndex) {
            mpLabel.text = mpDataAry[selectIndex][@"Name"];
            [self resetLabel];
        }
        
        NSString * key = [NSString stringWithFormat:@"%d", selectIndex];
        NSString * lpContent = mpSecondDataDic[key];
        [self resetRemarkContent];
        if (lpContent) {
        } else {
            [self getSecondDataFromServiceWithIndex:indexPath.row];
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
    [mpOperationQueue addOperation:operation];
}

-(void)deletePlanFromService:(NSString *)guid
{
    commonDataOperation * operation = [[commonDataOperation alloc] init] ;
    operation.tag =102;
    operation.urlStr = [serverIp stringByAppendingString:@"/Course/Note.action"];
    [operation.argumentDic setObject:guid forKey:@"GUID"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}


-(void)getDataFromService
{
    if ([mpTitleLabel.text isEqualToString:@"书签笔记"]) {
        commonDataOperation * operation = [[commonDataOperation alloc] init] ;
        operation.tag =100;
        operation.useCache = YES;
        operation.urlStr = [serverIp stringByAppendingString:@"/Course/NoteList.action"];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [mpOperationQueue addOperation:operation];
    }
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
        NSString * Brief = [info JSONValue][@"Brief"];
        if (Brief) {
//            NSString * Brief = [NSString stringWithString:[[info JSONValue] objectForKey:@"Brief"]];
            [mpSecondDataDic setObject:[NSString stringWithString:Brief] forKey:[NSString stringWithFormat:@"%d", tag-200]];
            [self resetRemarkContent];

        }
        
//        [mpSecondDataDic setObject:Brief forKey:[NSString stringWithFormat:@"%d", tag-200]];
    } else if (tag == 100) {
        NSArray * ary = [NSArray arrayWithArray:[[info JSONValue] objectForKey:@"list"]];
        [mpDataAry setArray:ary];
        [mpTableView reloadData];
    }  else if (tag == 101) {
        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
            [iLoadAnimationView showItoastMesage:@"发表成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if (tag == 102) {
        [self getDataFromService];
    }

}

@end
