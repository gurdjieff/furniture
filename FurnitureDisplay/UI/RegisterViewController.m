//
//  RegisterViewController.m
//  Examination
//
//  Created by gurd on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "RegisterViewController.h"
#import "CommonInterface.h"
#import "CustomAlertView.h"
#import "FirstViewController.h"
#import "NewItoast.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    }];
}

-(void)keyboardWillShow:(NSNotification *)aNotification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    
//    NSDictionary* lpinfo=[aNotification userInfo];
//    NSValue* lpValue=[lpinfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGSize keyboardSize=[lpValue CGRectValue].size;
//    mpBaseView.center = CGPointMake(center.x, center.y - keyboardSize.height+10);
    mpBaseView.center = CGPointMake(center.x, center.y - 130);

    [UIView commitAnimations];
}


-(void)addSubViews
{
    
    float textFieldHeight = 40;
    float textFieldWidth = 400;
    float startX = 280;
    float startY = 240;
    
    UIImageView * lpView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, appFrameHeigh-44)];
    lpView.image = [UIImage imageNamed:@"registerBack.jpg"];
    [mpBaseView addSubview:lpView];
    
    //    456 169
    
//    UIImageView * lpView2 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 50, 200, 75)];
//    lpView2.image = [UIImage imageNamed:@"platform.png"];
//    [mpBaseView addSubview:lpView2];
    
    UILabel * lpLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(startX, startY, 70, textFieldHeight)];
    lpLabel1.backgroundColor = [UIColor grayColor];
    lpLabel1.textAlignment = NSTextAlignmentCenter;
    lpLabel1.text = @"昵称";
    UILabel * lpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(startX, startY+textFieldHeight+10, 70, textFieldHeight)];
    lpLabel2.textAlignment = NSTextAlignmentCenter;
    lpLabel2.text = @"密码";
    lpLabel2.backgroundColor = [UIColor grayColor];
    
    UILabel * lpLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(startX, startY+(textFieldHeight+10)*2, 70, textFieldHeight)];
    lpLabel3.textAlignment = NSTextAlignmentCenter;
    lpLabel3.text = @"确认密码";
    lpLabel3.backgroundColor = [UIColor grayColor];
    
    
    [mpBaseView addSubview:lpLabel1];
    [mpBaseView addSubview:lpLabel2];
    [mpBaseView addSubview:lpLabel3];

    

    
    mpName = [[UITextField alloc] initWithFrame:CGRectMake(lpLabel1.left, startY, textFieldWidth, textFieldHeight)];
    mpName.backgroundColor = [UIColor whiteColor];
    mpName.borderStyle = UITextBorderStyleNone;
    mpName.placeholder = @"请输入昵称";
    mpName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [mpBaseView addSubview:mpName];
    
    mpPassword = [[UITextField alloc] initWithFrame:CGRectMake(lpLabel1.left, startY+textFieldHeight+10, textFieldWidth, textFieldHeight)];
    mpPassword.backgroundColor = [UIColor whiteColor];
    mpPassword.borderStyle = UITextBorderStyleNone;
    mpPassword.secureTextEntry = YES;
    mpPassword.placeholder = @"请输入密码， 至少6位";
    mpPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [mpBaseView addSubview:mpPassword];
    
    mpPassword2 = [[UITextField alloc] initWithFrame:CGRectMake(lpLabel1.left, startY+(textFieldHeight+10)*2, textFieldWidth, textFieldHeight)];
    mpPassword2.backgroundColor = [UIColor whiteColor];
    mpPassword2.borderStyle = UITextBorderStyleNone;
    mpPassword2.secureTextEntry = YES;
    mpPassword2.placeholder = @"重复输入密码";
    mpPassword2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [mpBaseView addSubview:mpPassword2];

    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(startX + 170, mpPassword2.buttom + 30, 120, 40);
    rightBtn.tag = 101;
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpBaseView addSubview:rightBtn];
}


-(void)btnClick:(UIButton *)btn
{
    [self sendRegisterRequest];
}

-(void)initData
{
    mpBaseView.frame = CGRectMake(0, 44, 1024, 748-44);
    center = mpBaseView.center;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = @"注  册";
    [self addLeftButton];
    [self initNotification];
    [self addSubViews];
	// Do any additional setup after loading the view.
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if (tag == 100) {
        NSDictionary * dic = [info JSONValue];
        if ([dic[@"result"] intValue] == 0) {
            CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:dic[@"msg"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        } else if ([dic[@"result"] intValue] == 1) {
            commonDataOperation * operation = [[commonDataOperation alloc] init];
            operation.urlStr = [serverIp stringByAppendingFormat:@"/User/Login.action"];
            operation.downInfoDelegate = self;
            operation.tag = 101;
            
            [operation.argumentDic setValue:mpName.text forKey:@"UserName"];
            [operation.argumentDic setValue:[mpPassword.text stringFromMD5] forKey:@"Password"];
            operation.isPOST = YES;
            [[Common getOperationQueue] addOperation:operation];
        }

    } else {
        [NewItoast showItoastWithMessage:@"登录成功"];
        [[FirstViewController shareFirstViewCtr] getDataFromService];
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
         NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
            if ([cookie.name isEqualToString:@"AutoReLogin"]) {
                [userDefaults setValue:cookie.value forKey:@"cookie"];
                break;
            }
        }

        NSDictionary * dic = [info JSONValue];
        [userDefaults setObject:[dic objectForKey:@"UserName"] forKey:@"UserName"];
		[userDefaults setObject:[dic objectForKey:@"UserID"] forKey:@"UserID"];
		[userDefaults setObject:[dic objectForKey:@"NickName"] forKey:@"NickName"];
        [userDefaults setBool:YES forKey:@"ifLogin"];
        [userDefaults synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateLoginState" object:nil];
        [[self parentViewController] dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}

-(void)sendRegisterRequest
{
    if (mpPassword.text.length < 6) {
        [NewItoast showItoastWithMessage:@"密码长度至少6位" inView:mpBaseView];
//        CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alertView show];
        return;
    }
    
    if (mpName.text.length < 6) {
        [NewItoast showItoastWithMessage:@"昵称长度至少六位" inView:mpBaseView];
////        CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"昵称不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alertView show];
        return;
    }

    
    if (![mpPassword.text isEqualToString:mpPassword2.text]) {
        CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"两次密码不相同" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];

//        [CommonInterface showToastViewForCurrentVisibleViewForTwoSecondsWithMessage:@"两次密码不相同"];
        return;
    }
    
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/User/Register.action"];
    operation.downInfoDelegate = self;
    operation.tag = 100;
    
    [operation.argumentDic setValue:mpName.text forKey:@"UserName"];
    [operation.argumentDic setValue:[mpPassword.text stringFromMD5] forKey:@"Password"];
    [operation.argumentDic setValue:[mpPassword2.text stringFromMD5] forKey:@"RePassword"];
    operation.isPOST = YES;
    [[Common getOperationQueue] addOperation:operation];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mpName resignFirstResponder];
    [mpPassword resignFirstResponder];
    [mpPassword2 resignFirstResponder];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
