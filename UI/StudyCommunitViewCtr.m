//
//  StudyCommunitViewCtr.m
//  ExaminationIpad
//
//  Created by gurd on 13-9-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "StudyCommunitViewCtr.h"
#import "StudyCommunityCell.h"
#import "UIImageView+WebCache.h"
#import "StudyCommenViewCtr.h"
#define cellCount 12


@interface StudyCommunitViewCtr ()

@end

@implementation StudyCommunitViewCtr

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


-(void)rightBtnClick
{
    StudyCommenViewCtr * lpViewCtr = [[StudyCommenViewCtr alloc] init];
    [self.navigationController pushViewController:lpViewCtr animated:YES];
}

-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(appFrameWidth-90, 7, 80, 30);
//    btn.frame = CGRectMake(appFrameWidth-50, 0, 40, 40);

    
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"remark.png"] forState:UIControlStateNormal];

    [btn setTitle:@"发表" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}

-(void)resignBtnClick
{
    [mpTextView resignFirstResponder];
}

-(void)addTableViews
{
    mpBaseView.backgroundColor = cellBackColor;

    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 748-44) style:UITableViewStylePlain];
    mpTableView.tag = 101;
    mpTableView.showsVerticalScrollIndicator = NO;
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.separatorColor = [UIColor clearColor];
    mpTableView.backgroundColor = cellBackColor;
    [mpBaseView addSubview:mpTableView];
    
    mpTableViewRight = [[UITableView alloc] initWithFrame:CGRectMake((1024-60)/2, 0, (1024-60)/2, 748-44-50) style:UITableViewStylePlain];
    mpTableViewRight.tag = 102;
    mpTableViewRight.showsVerticalScrollIndicator = NO;
    mpTableViewRight.delegate = self;
    mpTableViewRight.dataSource = self;
    mpTableViewRight.separatorColor = [UIColor clearColor];
    mpTableViewRight.backgroundColor = cellBackColor;
    [mpBaseView addSubview:mpTableViewRight];
    
//    UIButton * btn = [[UIButton alloc] initWithFrame:mpTableView.frame];
//    [btn addTarget:self action:@selector(resignBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [mpBaseView addSubview:mpTableViewRight];
    
}

-(void)resetTableViewHeadView
{
    mpFootView.hidden = NO;
    NSDictionary * userInfo = mpDataAry[selectIndex][@"User"];
    [mpRightImageView setImageWithURL:[NSURL URLWithString:userInfo[@"HeadPhotoUrl"]]];
    
    mpRightLabel1.text = userInfo[@"UserName"];
    mpRightLabel2.text = mpDataAry[selectIndex][@"PostDate"];
    mpRightLabel3.text = mpDataAry[selectIndex][@"Brief"];
    
    CGSize size = [mpDataAry[selectIndex][@"Brief"] sizeWithFont:mpRightLabel3.font constrainedToSize:CGSizeMake(440, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    mpRightLabel3.frame = CGRectMake(20, 140, size.width, size.height);
    mpRightLabel4.frame = CGRectMake(0, mpRightLabel3.buttom+10, (appFrameWidth-60)/2, 30);
    mpRightHeaderView.frame = CGRectMake(0, 0, 320, mpRightLabel3.buttom+10+30);
    mpTableViewRight.tableHeaderView = mpRightHeaderView;

}

-(void)addTableViewHeadView
{
    mpRightHeaderView = [[UIView alloc] init];
    mpRightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 70, 70)];
    mpRightImageView.backgroundColor = [UIColor clearColor];
    
    mpRightLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 200, 30)];
//    mpRightLabel1.textAlignment = NSTextAlignmentRight;
    mpRightLabel1.backgroundColor = [UIColor clearColor];;
    mpRightLabel1.textColor = [UIColor darkGrayColor];
    
    mpRightLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(280, 90, 180, 30)];
    mpRightLabel2.backgroundColor = [UIColor clearColor];
    mpRightLabel2.textAlignment = NSTextAlignmentRight;
    mpRightLabel2.textColor = [UIColor darkGrayColor];


    
    mpRightLabel3 = [[UILabel alloc] init];
    mpRightLabel3.numberOfLines = 0;
    mpRightLabel3.backgroundColor = [UIColor clearColor];
    mpRightLabel3.textColor = [UIColor darkGrayColor];

    
    mpRightLabel4 = [[UILabel alloc] init];
    mpRightLabel4.text = @"    回复列表";
    mpRightLabel4.font = [UIFont systemFontOfSize:18];
    mpRightLabel4.backgroundColor = [UIColor clearColor];
    
    
    [mpRightHeaderView addSubview:mpRightImageView];
    [mpRightHeaderView addSubview:mpRightLabel1];
    [mpRightHeaderView addSubview:mpRightLabel2];
    [mpRightHeaderView addSubview:mpRightLabel3];
    [mpRightHeaderView addSubview:mpRightLabel4];
    
    mpTableViewRight.tableHeaderView = mpRightHeaderView;
}


-(void)addFootView
{
    float width = (appFrameWidth-60)/2;
    mpFootView = [[UIImageView alloc] initWithFrame:CGRectMake(width, appFrameHeigh-44-50, width, 50)];
    mpFootView.hidden = YES;
    [mpBaseView addSubview:mpFootView];
    mpFootView.userInteractionEnabled = YES;
    mpFootView.image = [UIImage imageNamed:@"purpleSmall.png"];
    
    mpTextView = [[UITextView alloc] initWithFrame:CGRectMake(40, 7, width-100, 36)];
    mpTextView.font = [UIFont systemFontOfSize:16];
    //    mpTextView.placeholder = @"我要评论";
    mpTextView.backgroundColor = [UIColor whiteColor];
    //    mpTextField.textAlignment = YES;
    [mpFootView addSubview:mpTextView];
    
    UIImageView * lpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 30)];
    lpImageView.image = [UIImage imageNamed:@"pen.png"];
    [mpFootView addSubview:lpImageView];
    UIButton * lpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lpBtn.frame = CGRectMake(width-52, 7, 46, 36);
    [lpBtn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [lpBtn setTitle:@"确定" forState:UIControlStateNormal];
    lpBtn.tag = 100;
    [lpBtn addTarget:self action:@selector(subMitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpFootView addSubview:lpBtn];
}

-(void)subMitBtnClick:(UIButton *)btn
{
    [mpTextView resignFirstResponder];
    [self saveDataToService];
}

-(void)saveDataToService
{
    if (mpTextView.text.length == 0) {
        [NewItoast showItoastWithMessage:@"请输入内容"];
        return;
    }

    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Reply.action"];
    if ([mpDataAry count] > selectIndex) {
        NSDictionary * tempDic = [mpDataAry objectAtIndex:selectIndex];
        [operation.argumentDic setValue:[tempDic objectForKey:@"GUID"] forKey:@"ReplyID"];
        
    }

    operation.tag = 101;
    NSString * info = [NSString stringWithString:mpTextView.text];
    [operation.argumentDic setValue:info forKey:@"Brief"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
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

-(void)downLoadWithInfo:(NSString *)apInfo with:(NSInteger)tag
{
    if (![apInfo ifInvolveStr:@"\"result\":\"1\""]) {
        return;
    }
    
    NSMutableString * tempInfo = [[NSMutableString alloc] init];
    [tempInfo setString:apInfo];
    [self resetString:tempInfo];
    
    if (tag == 100) {
        NSArray * ary = [NSArray arrayWithArray:[[tempInfo JSONValue] objectForKey:@"list"]];
        [mpDataAry setArray:ary];
        [mpTableView reloadData];
    } else if (tag == 101) {
        [mpTextView resignFirstResponder];
        mpTextView.text = @"";
        [self getSecondDataFromServiceWithIndex:selectIndex];
    } else if (tag == 102) {
        [self getDataFromService];
    } else if (tag == 103) {
        [self getSecondDataFromServiceWithIndex:selectIndex];
    } else {
        NSArray * ary = [NSArray arrayWithArray:[[tempInfo JSONValue] objectForKey:@"list"]];
        [mpSecondDataDic setObject:ary forKey:[NSString stringWithFormat:@"%d", tag-200]];
        [mpTableViewRight reloadData];
        [self resetTableViewHeadView];
    }
}

-(void)sendDeleteInfoToServerWithInfo:(NSDictionary *)apDic
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/DeleteRemark.action"];
    [operation.argumentDic setValue:[apDic objectForKey:@"GUID"]
                             forKey:@"GUID"];
    operation.tag = 102;
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}

-(void)sendDeleteTwoInfoToServerWithInfo:(NSDictionary *)apDic
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/DeleteRemark.action"];
    [operation.argumentDic setValue:[apDic objectForKey:@"GUID"]
                             forKey:@"GUID"];
    operation.tag = 103;
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}



-(void)getSecondDataFromServiceWithIndex:(int)index
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/ReplyList.action"];
    if ([mpDataAry count] > index) {
        NSDictionary * tempDic = [mpDataAry objectAtIndex:index];
        [operation.argumentDic setValue:[tempDic objectForKey:@"GUID"] forKey:@"ReplyID"];
        
    }

    operation.tag = 200+index;
    operation.downInfoDelegate = self;
    operation.useCache = YES;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}



-(void)getDataFromService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/RemarkList.action"];
    [operation.argumentDic setValue:@""
                             forKey:@"CourseID"];
    operation.tag = 100;
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    operation.useCache = YES;
    [mpOperationQueue addOperation:operation];
}

-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
    mpSecondDataDic = [[NSMutableDictionary alloc] init];
    selectIndex = 0;
}

-(void)keyboarWilldHidden
{
    [UIView animateWithDuration:0.25 animations:^{
        float width = (appFrameWidth-60)/2;
        mpFootView.frame = CGRectMake(width, appFrameHeigh-44-50, width, 50);
    }];
}

-(void)keyboardWillShow:(NSNotification *)aNotification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    
    NSDictionary* lpinfo=[aNotification userInfo];
    NSValue* lpValue=[lpinfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize=[lpValue CGRectValue].size;
    float width = (appFrameWidth-60)/2;
    mpFootView.frame = CGRectMake(width, appFrameHeigh-44-50-keyboardSize.width, width, 50);
    [UIView commitAnimations];
}




-(void)initNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboarWilldHidden)
												 name:UIKeyboardWillHideNotification
											   object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    mpTitleLabel.text = @"学习交流";
    [self initData];
    [self initNotification];
    [self addRightBtn];
    [self addLeftButton];
    [self addTableViews];
    [self addTableViewHeadView];
    [self addFootView];
//    [self getDataFromService];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 101) {
        int count = [mpDataAry count];
//        if (count < cellCount) {
//            count = cellCount;
//        }
        return count;
    } else {
        NSArray * ary = [mpSecondDataDic objectForKey:[NSString stringWithFormat:@"%d", selectIndex]];
        return [ary count];
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        NSDictionary * tempDic = mpDataAry[indexPath.row];
        NSString *content=tempDic[@"Brief"];
        float width = (appFrameWidth-60)/2-80;
        CGSize detailSize = [content sizeWithFont:labelFont constrainedToSize:CGSizeMake(width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        float realHigh = detailSize.height < maxiHigh ? detailSize.height : maxiHigh;
        return realHigh + 50;
    } else {
        NSArray * ary = [mpSecondDataDic objectForKey:[NSString stringWithFormat:@"%d", selectIndex]];
        NSDictionary * tempDic = ary[indexPath.row];
        NSString *content=tempDic[@"Brief"];
        float width = (appFrameWidth-60)/2-80;
        CGSize detailSize = [content sizeWithFont:labelFont constrainedToSize:CGSizeMake(width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        float realHigh = detailSize.height < maxiHigh ? detailSize.height : maxiHigh;
        return realHigh + 40;
    }
}


//{
//    Brief = "\U8bfe\U7a0b\U4e2d\U6ca1\U6709\U89c6\U9891\U662f\U4e0d\U662f\U8be5\U9690\U85cf\Uff1f";
//    CourseID = "65696608-38c6-4f8e-a8cd-6ef517af8293";
//    GUID = "1024c57f-dcf0-4cad-94bd-6e8970436cb7";
//    PostDate = "13\U5e749\U67089\U65e5";
//    ReadCount = 1;
//    ReplyCount = 0;
//    SetTopUserID = "";
//    User =     {
//        HeadPhotoUrl = "http://116.90.86.104:81/images/headphoto/324.jpg?635143290980000000";
//        NickName = "\U5fae\U5b66\U4e60\U662f\U597d\U4e1c\U897f";
//        UserID = "d542bde2-662e-47f3-911a-5391b44a7667";
//        UserName = "\U5fae\U5b66\U4e60\U662f\U597d\U4e1c\U897f";
//    };
//},


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101) {
        NSString * identify = @"cell";
        StudyCommunityCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[StudyCommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell->mpLabel4.hidden = NO;
        }
        
        NSDictionary * tempDic = mpDataAry[indexPath.row];
        cell->useBackImage = YES;
        NSString * headpotoUrl = tempDic[@"User"][@"HeadPhotoUrl"];
        
        [cell->mpImageView setImageWithURL:[NSURL URLWithString:headpotoUrl] placeholderImage:nil];
        cell->mpLabel1.text = tempDic[@"User"][@"UserName"];;
        cell->mpLabel2.text = tempDic[@"PostDate"];
        cell->mpLabel5.text = tempDic[@"ReadCount"];

        
        NSString * brief = tempDic[@"Brief"];
        NSString * ReplyCount = tempDic[@"ReplyCount"];
        cell->mpLabel3.text = brief;
        float width = (appFrameWidth-60)/2-80;
        CGSize detailSize = [brief sizeWithFont:labelFont constrainedToSize:CGSizeMake(width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        float realHigh = detailSize.height < maxiHigh ? detailSize.height : maxiHigh;
        cell->mpLabel3.frame = CGRectMake(60, 25, width , realHigh);
        cell->mpLabel4.text = [NSString stringWithFormat:@"%@", ReplyCount];
        
        cell->mpLabel2.frame = CGRectMake(cell->mpImageView1.right+10, cell->mpLabel3.buttom+5, 160, 20);
        cell->mpLabel5.frame = CGRectMake(cell->mpImageView2.right+10, cell->mpLabel3.buttom+5, 160, 20);
        cell->mpLabel4.frame = CGRectMake(cell->mpImageView3.right+10, cell->mpLabel3.buttom+5, 160, 20);

        
        [cell->mpImageView1 setTop:cell->mpLabel3.buttom+5];
        [cell->mpImageView2 setTop:cell->mpLabel3.buttom+5];
        [cell->mpImageView3 setTop:cell->mpLabel3.buttom+5];
        
        cell->mpBackImageView.frame = CGRectMake(0, 0, (appFrameWidth-60)/2, realHigh + 50);
        return cell;

    } else {
        NSString * identify = @"cell";
        StudyCommunityCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell == nil) {
            cell = [[StudyCommunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        
        NSArray * ary = [mpSecondDataDic objectForKey:[NSString stringWithFormat:@"%d", selectIndex]];
        NSDictionary * tempDic = ary[indexPath.row];
        NSString * headpotoUrl = tempDic[@"User"][@"HeadPhotoUrl"];
        
        [cell->mpImageView setImageWithURL:[NSURL URLWithString:headpotoUrl] placeholderImage:nil];
        cell->mpLabel1.text = tempDic[@"User"][@"UserName"];;
        cell->mpLabel2.text = tempDic[@"PostDate"];
        cell->mpLabel2.textAlignment = NSTextAlignmentRight;
        NSString * brief = tempDic[@"Brief"];
        cell->mpLabel3.text = brief;
        float width = (appFrameWidth-60)/2-80;
        CGSize detailSize = [brief sizeWithFont:labelFont constrainedToSize:CGSizeMake(width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        float realHigh = detailSize.height < maxiHigh ? detailSize.height : maxiHigh;
        cell->mpLabel3.frame = CGRectMake(60, 25, width , realHigh);
        
        cell->mpImageView1.hidden = YES;
        cell->mpImageView2.hidden = YES;
        cell->mpImageView3.hidden = YES;
        
//        cell->
//
//        
//        cell->mpLabel2.frame = CGRectMake(cell->mpImageView1.right+10, cell->mpLabel3.buttom, 160, 20);
//        cell->mpLabel5.frame = CGRectMake(cell->mpImageView2.right+10, cell->mpLabel3.buttom, 160, 20);
//        cell->mpLabel4.frame = CGRectMake(cell->mpImageView3.right+10, cell->mpLabel3.buttom, 160, 20);
//        
        
//        cell->mpImageView.frame =CGRectMake(10,detailSize.height/2 -5,40, 40);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell->mpBackImageView.frame = CGRectMake(0, 0, (appFrameWidth-60)/2, detailSize.height + 30);
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [mpTextView resignFirstResponder];
    if (tableView.tag == 101) {
        selectIndex = indexPath.row;
        NSLog(@"---%d", selectIndex);
        NSString * key = [NSString stringWithFormat:@"%d", selectIndex];
        if (mpSecondDataDic[key]) {
            [mpTableViewRight reloadData];
            [self resetTableViewHeadView];
        } else {
            [self getSecondDataFromServiceWithIndex:indexPath.row];
        }
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 101) {
        NSDictionary * dic =mpDataAry[indexPath.row];
        NSDictionary * user =[dic objectForKey:@"User"];
        NSString * UserID =[user objectForKey:@"UserID"];
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        NSString * uid =[userDefaults objectForKey:@"UserID"];
        if ([uid isEqualToString:UserID]) {
            return YES;
        }
        return NO;

    } else {
        NSLog(@"---%d", selectIndex);
        NSString * key = [NSString stringWithFormat:@"%d", selectIndex];
        if (mpSecondDataDic[key]) {
            NSDictionary * dic =mpSecondDataDic[key][indexPath.row];
            NSDictionary * user =[dic objectForKey:@"User"];
            NSString * UserID =[user objectForKey:@"UserID"];
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            NSString * uid =[userDefaults objectForKey:@"UserID"];
            if ([uid isEqualToString:UserID]) {
                return YES;
            }
            return NO;
        }
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle != UITableViewCellEditingStyleDelete) {
        return;
    }
    
    if (tableView.tag == 101) {
        [self sendDeleteInfoToServerWithInfo:mpDataAry[indexPath.row]];
    } else {
        NSLog(@"---%d", selectIndex);
        NSString * key = [NSString stringWithFormat:@"%d", selectIndex];
        if (mpSecondDataDic[key]) {
            NSDictionary * dic =mpSecondDataDic[key][indexPath.row];
            [self sendDeleteTwoInfoToServerWithInfo:dic];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
