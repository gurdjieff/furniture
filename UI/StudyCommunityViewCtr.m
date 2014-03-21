//
//  StudyCommunityViewCtr.m
//  Examination
//
//  Created by gurd on 13-7-30.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "StudyCommunityViewCtr.h"
#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#define backColor [UIColor clearColor]

@interface StudyCommunityViewCtr ()

@end

@implementation StudyCommunityViewCtr

@synthesize infoDic = mpInfoDic;
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
        mpBaseView.center = center;

//        mpFootView.frame = CGRectMake(0, appFrameHeigh-44-50, 320, 50);
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
    mpBaseView.center = CGPointMake(center.x, center.y - keyboardSize.height);
    [UIView commitAnimations];
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



-(void)addTableView
{
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, appFrameHeigh-44-50) style:UITableViewStylePlain];
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.separatorColor = [UIColor clearColor];
    [mpBaseView addSubview:mpTableView];
}

-(void)addTableViewHeadView
{
//    {
//        Brief = "\U554a\U554a\U554a";
//        GUID = "78868dfb-fb66-4801-a96f-32f759363766";
//        PostDate = "2013-8-3 20:53:08";
//        User =     {
//            HeadPhotoUrl = "http://114.113.155.86:80/images/headphoto/298.jpg?635101091670000000";
//            NickName = "";
//            UserID = "22b4d647-3e4f-4376-878d-7f7af64f9fa6";
//            UserName = gurdjieff;
//        };
//    }

    NSDictionary * userInfo = mpInfoDic[@"User"];    
    UIView * lpHeaderView = [[UIView alloc] init];
//    lpHeaderView.backgroundColor = [UIColor greenColor];
    UIImageView * lpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 20, 70, 70)];
    lpImageView.backgroundColor = backColor;
    [lpImageView setImageWithURL:[NSURL URLWithString:userInfo[@"HeadPhotoUrl"]]];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    label1.text = userInfo[@"UserName"];
    label1.textAlignment = NSTextAlignmentRight;
    label1.backgroundColor = backColor;
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 140, 30)];
    label2.text = mpInfoDic[@"PostDate"];
    label2.backgroundColor = backColor;
    
    UILabel * label3 = [[UILabel alloc] init];
    label3.text = mpInfoDic[@"Brief"];
    label3.numberOfLines = 0;
    label3.backgroundColor = backColor;
    
    [lpHeaderView addSubview:lpImageView];
    [lpHeaderView addSubview:label1];
    [lpHeaderView addSubview:label2];
    [lpHeaderView addSubview:label3];

        
    CGSize size = [mpInfoDic[@"Brief"] sizeWithFont:label3.font constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    label3.frame = CGRectMake(20, 140, size.width, size.height);
    lpHeaderView.frame = CGRectMake(0, 0, 320, label3.buttom+10);
    
    mpTableView.tableHeaderView = lpHeaderView;
}

-(void)subMitBtnClick:(UIButton *)btn
{
    [self saveDataToService];
}


-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if (tag == 100) {
        if (![info ifInvolveStr:@"list"]) {
            return;
        }
        [mpDataAry setArray:[info JSONValue][@"list"]];
        [mpTableView reloadData];
    } else if (tag == 101) {
//        [mpTextView resignFirstResponder];
//        mpTextView.text = @"";
        [self getDataFromService];
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}

-(void)saveDataToService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Reply.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"ReplyID"];
    operation.tag = 101;
    NSString * info = [NSString stringWithString:mpTextView.text];
    [operation.argumentDic setValue:info forKey:@"Brief"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}

-(void)getDataFromService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/ReplyList.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"ReplyID"];
    operation.tag = 100;
    operation.useCache = YES;
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
    btn.frame = CGRectMake(320-55, 0, 55, 44);
    //    [btn setBackgroundImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    [btn setTitle:@"发表" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}

-(void)addFootView
{
    mpFootView = [[UIImageView alloc] initWithFrame:CGRectMake(0, appFrameHeigh-44-50, 320, 50)];
    [mpBaseView addSubview:mpFootView];
    mpFootView.userInteractionEnabled = YES;
    mpFootView.image = [UIImage imageNamed:@"purpleback.png"];
    
    mpTextView = [[UITextView alloc] initWithFrame:CGRectMake(40, 7, 220, 36)];
    mpTextView.font = [UIFont systemFontOfSize:16];
    //    mpTextView.placeholder = @"我要评论";
    mpTextView.backgroundColor = [UIColor whiteColor];
    //    mpTextField.textAlignment = YES;
    [mpFootView addSubview:mpTextView];
    
    UIImageView * lpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 30)];
    lpImageView.image = [UIImage imageNamed:@"pen.png"];
    [mpFootView addSubview:lpImageView];
    UIButton * lpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lpBtn.frame = CGRectMake(268, 7, 46, 36);
    [lpBtn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [lpBtn setTitle:@"确定" forState:UIControlStateNormal];
    lpBtn.tag = 100;
    [lpBtn addTarget:self action:@selector(subMitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpFootView addSubview:lpBtn];
}

-(void)initData
{
    mpDataAry = [[NSMutableArray alloc] init];
    center = mpBaseView.center;
    [self initNotification];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self addLeftButton];
//    [self addRightBtn];
     mpTitleLabel.text = @"学习交流";
    [self addTableView];
    [self addTableViewHeadView];
    [self addFootView];
    [self getDataFromService];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 320, 30)];
    label.text = @"    回复列表";
    label.font = [UIFont systemFontOfSize:20];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
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
    cell->mpLabel3.text = tempDic[@"Brief"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mpTextView resignFirstResponder];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [mpTextView resignFirstResponder];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mpTextView resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
