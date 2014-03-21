//
//  FirstViewCommentCtr.m
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FirstViewCommentCtr.h"
#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "StudyCommunityViewCtr.h"
#import "AddCommentViewCtr.h"
#import "Common.h"

@interface FirstViewCommentCtr ()

@end

@implementation FirstViewCommentCtr
@synthesize infoDic = mpInfoDic;
@synthesize theTitle = _theTitle;
@synthesize ctrStyle = _ctrStyle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

-(void)keyboarWilldHidden
{
    [UIView animateWithDuration:0.25 animations:^{
        mpFootView.frame = CGRectMake(0, appFrameHeigh-44-50, appFrameWidth-60, 50);
//        mpFootView2.frame = CGRectMake(0, appFrameHeigh-44-50, 320, 50);
    }];
}

-(void)keyboardWillShow:(NSNotification *)aNotification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    
    NSDictionary* lpinfo=[aNotification userInfo];
    NSValue* lpValue=[lpinfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize=[lpValue CGRectValue].size;
//    mpFootView.frame = CGRectMake(0, appFrameHeigh-44-50-keyboardSize.height, 320, 50);
    mpFootView.frame = CGRectMake(0, appFrameHeigh-44-50-keyboardSize.width, appFrameWidth-60, 50);

//    mpFootView2.frame = CGRectMake(0, mpFootView.frame.origin.y-30, 320, 30);
    [UIView commitAnimations];
}

-(void)addTableView
{
    float height = 0;
    if (_theTitle==nil) {
        height = appFrameHeigh-44-50;
    } else{
        height = appFrameHeigh-44;
    }

    
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, appFrameWidth-60, height) style:UITableViewStylePlain];
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.separatorColor = [UIColor clearColor];
    [mpBaseView addSubview:mpTableView];
}

-(void)resetTitle
{
    return;
    int number = 0;
    for (int i = 0; i < 5; i++) {
        UIButton * btn = (UIButton *)[mpFootView2 viewWithTag:101 + i];
        if (btn.selected) {
            number += 1;
        }
    }
    mpLabel.text = [NSString stringWithFormat:@"%d星",number];
}

-(void)btnClick:(UIButton *)apBtn
{
    if (apBtn.tag >= 101) {
        apBtn.selected = !apBtn.selected;
        if (apBtn.selected) {
            [apBtn setBackgroundImage:[UIImage imageNamed:@"yellowStar.png"] forState:UIControlStateNormal];
        } else {
            [apBtn setBackgroundImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        }
        [self resetTitle];
    }
}

-(void)subMitBtnClick:(UIButton *)btn
{
    [self saveDataToService];
}

-(void)addFootView
{
    mpFootView = [[UIImageView alloc] initWithFrame:CGRectMake(0, appFrameHeigh-44-50, appFrameWidth-60, 50)];
    [mpBaseView addSubview:mpFootView];
    mpFootView.userInteractionEnabled = YES;
    mpFootView.image = [UIImage imageNamed:@"purpleSmall.png"];
    
    mpTextView = [[UITextView alloc] initWithFrame:CGRectMake(60, 7, appFrameWidth-60-140, 36)];
//    mpTextView.placeholder = @"我要评论";
    mpTextView.backgroundColor = [UIColor whiteColor];
    mpTextView.font = [UIFont systemFontOfSize:16];
    [mpFootView addSubview:mpTextView];
    
    UIImageView * lpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 30)];
    lpImageView.image = [UIImage imageNamed:@"pen.png"];
    [mpFootView addSubview:lpImageView];
    
    UIButton * lpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lpBtn.frame = CGRectMake(mpFootView.left-60, 7, 46, 36);
    lpBtn.backgroundColor = [UIColor brownColor];
    [lpBtn setTitle:@"确定" forState:UIControlStateNormal];
    lpBtn.tag = 100;
    [lpBtn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [lpBtn addTarget:self action:@selector(subMitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpFootView addSubview:lpBtn];
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
    if (tag == 102) {
        [self getDataFromService];
    }
    
    //提交评论
    if (tag==30002)
    {
        NSString *   result =[[tempInfo JSONValue] objectForKey:@"result"];
        
        if ([result isEqualToString:@"1"]) {
            [iLoadAnimationView showItoastMesage:@"提交成功"];
            [mpTextView resignFirstResponder];
            mpTextView.text = @"";
            [self getDataFromService];
        }
        return;
    }
    
    if (![tempInfo ifInvolveStr:@"list"]) {
        return;
    }

    [mpDataAry setArray:[tempInfo JSONValue][@"list"]];
    [mpTableView reloadData];
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}

-(void)saveDataToService
{
    if (mpTextView.text.length == 0) {
        [NewItoast showItoastWithMessage:@"请输入内容"];
        return;
    }
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Remark.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"CourseID"];
    operation.tag = 30002;
    NSString * info = [NSString stringWithString:mpTextView.text];
    [operation.argumentDic setValue:info forKey:@"Brief"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}

-(void)getDataFromService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.useCache = YES;
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/RemarkList.action"];
     
    if (_ctrStyle == jiaoliu) {
        operation.tag = 30001;
        [operation.argumentDic setValue:@""
                                 forKey:@"CourseID"];
    } else {
        [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"CourseID"];
        operation.tag = 30000;
    }
    
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
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

-(void)rightBtnClick
{
     AddCommentViewCtr * lpViewCtr = [[AddCommentViewCtr alloc] init];
    lpViewCtr.infoDic = mpInfoDic;
    lpViewCtr.ctrStyle = _ctrStyle;
    [self.navigationController pushViewController:lpViewCtr animated:YES];
}

-(void)addRightButton:(NSString *)title
{
    UIButton * lpRightBtn = [[UIButton alloc] init];
    lpRightBtn.frame = CGRectMake(320-55, 7, 50, 30);
    [lpRightBtn setTitle:title forState:UIControlStateNormal];
    [lpRightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [lpRightBtn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [lpRightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:lpRightBtn];
}

//-(void)addRightBtn
//{
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(320-55, 0, 55, 44);
//    //    [btn setBackgroundImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
//    [btn setTitle:@"发表" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [mpNavitateView addSubview:btn];
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDataFromService];
}

-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self addLeftButton];
    [self addTableView];

    if (_theTitle==nil)
    {
        mpTitleLabel.text = @"评论";
        [self addFootView];
    }
    else
    {
        mpTitleLabel.text = _theTitle;
        [self addRightButton:@"发表"];
    }
    
    [self initNotification];
	// Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mpDataAry count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = @"cell";
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        if (_ctrStyle==pinglun)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType =UITableViewCellAccessoryNone;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
//    
//    {
//        Brief = Dddddddddd;
//        GUID = "cc2e7cae-0e07-43d4-83f5-4a7fbb1f8a7d";
//        PostDate = "2013-7-30 16:07:18";
//        User =     {
//            HeadPhotoUrl = "http://114.113.155.86:80/images/headphoto/298.jpg?635101091670000000";
//            NickName = "";
//            UserID = "22b4d647-3e4f-4376-878d-7f7af64f9fa6";
//            UserName = gurdjieff;
//        };
//    },

    NSDictionary * tempDic = mpDataAry[indexPath.row];
    NSString * headpotoUrl = tempDic[@"User"][@"HeadPhotoUrl"];
    
    [cell->mpImageView setImageWithURL:[NSURL URLWithString:headpotoUrl] placeholderImage:nil];
    cell->mpLabel1.text = tempDic[@"User"][@"UserName"];;
    cell->mpLabel2.text = tempDic[@"PostDate"];
    NSString * brief = tempDic[@"Brief"];
    cell->mpLabel3.text = brief;

    CGSize detailSize = [brief sizeWithFont:commentFont constrainedToSize:CGSizeMake(appFrameWidth-60-80, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    float realiseHigh = detailSize.height < maxiHigh ? detailSize.height : maxiHigh;
    cell->mpLabel3.frame = CGRectMake(60, 25, appFrameWidth-60-80 , realiseHigh);
//	cell->mpImageView.frame =CGRectMake(10,detailSize.height/2 -5,40, 40);

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mpTextView resignFirstResponder];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (_ctrStyle == pinglun) {
        return;
    }
    
    StudyCommunityViewCtr * lpViewCtr = [[StudyCommunityViewCtr alloc] init];
    lpViewCtr.infoDic = mpDataAry[indexPath.row];
    [self.navigationController pushViewController:lpViewCtr animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * tempDic = mpDataAry[indexPath.row];
    NSString *content=tempDic[@"Brief"];
    CGSize detailSize = [content sizeWithFont:commentFont constrainedToSize:CGSizeMake(appFrameWidth-60-80, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    float realiseHigh = detailSize.height < maxiHigh ? detailSize.height : maxiHigh;
    return realiseHigh + 30;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
		NSDictionary * dic =mpDataAry[indexPath.row];
		NSDictionary * user =[dic objectForKey:@"User"];
		NSString * UserID =[user objectForKey:@"UserID"];
		NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
		NSString * uid =[userDefaults objectForKey:@"UserID"];
		if ([uid isEqualToString:UserID]) {
			return YES;
		}
        return NO;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
	if (editingStyle==UITableViewCellEditingStyleDelete)
	{
		[self sendDeleteInfoToServerWithInfo:mpDataAry[indexPath.row]];
	}
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mpTextView resignFirstResponder];
}



@end
