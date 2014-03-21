//
//  ChangePwdViewCtr.m
//  Examination
//
//  Created by gurd on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "ChangePwdViewCtr.h"
#import "CustomAlertView.h"

@interface ChangePwdViewCtr ()

@end

@implementation ChangePwdViewCtr

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
    mpBaseView.center = CGPointMake(center.x, center.y - 130);
    [UIView commitAnimations];
}


-(void)addSubViews
{
    float textFieldHeight = 40;
    float textFieldWidth = 400;
    float startX = 255;
    float startY = 180;

    
    UIImageView * lpView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748-44)];
    lpView.image = [UIImage imageNamed:@"purple.png"];
    [mpBaseView addSubview:lpView];
    
    //    456 169
    
    UIImageView * lpView2 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 50, 200, 75)];
    lpView2.image = [UIImage imageNamed:@"platform.png"];
    [mpBaseView addSubview:lpView2];
    
    UILabel * lpLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(startX, startY, 70, textFieldHeight)];
    lpLabel1.backgroundColor = [UIColor grayColor];
    lpLabel1.textAlignment = NSTextAlignmentCenter;
    lpLabel1.text = @"原密码";
    UILabel * lpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(startX, startY+(textFieldHeight+10)*1, 70, textFieldHeight)];
    lpLabel2.textAlignment = NSTextAlignmentCenter;
    lpLabel2.text = @"新密码";
    lpLabel2.backgroundColor = [UIColor grayColor];
    
    UILabel * lpLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(startX, startY+(textFieldHeight+10)*2, 70, textFieldHeight)];
    lpLabel3.textAlignment = NSTextAlignmentCenter;
    lpLabel3.text = @"确认密码";
    lpLabel3.backgroundColor = [UIColor grayColor];
    
    
    [mpBaseView addSubview:lpLabel1];
    [mpBaseView addSubview:lpLabel2];
    [mpBaseView addSubview:lpLabel3];
    
    
    
    mpOldPassword = [[UITextField alloc] initWithFrame:CGRectMake(lpLabel1.left, startY, textFieldWidth, textFieldHeight)];
    mpOldPassword.backgroundColor = [UIColor whiteColor];
    mpOldPassword.borderStyle = UITextBorderStyleNone;
    mpOldPassword.secureTextEntry = YES;
    mpOldPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [mpBaseView addSubview:mpOldPassword];
    
    mpPassword = [[UITextField alloc] initWithFrame:CGRectMake(lpLabel1.left, startY+(textFieldHeight+10)*1, textFieldWidth, textFieldHeight)];
    mpPassword.backgroundColor = [UIColor whiteColor];
    mpPassword.borderStyle = UITextBorderStyleNone;
    mpPassword.secureTextEntry = YES;
    mpPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [mpBaseView addSubview:mpPassword];
    
    mpPassword2 = [[UITextField alloc] initWithFrame:CGRectMake(lpLabel1.left, startY+(textFieldHeight+10)*2, textFieldWidth, textFieldHeight)];
    mpPassword2.backgroundColor = [UIColor whiteColor];
    mpPassword2.secureTextEntry = YES;
    mpPassword2.borderStyle = UITextBorderStyleNone;
    mpPassword2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [mpBaseView addSubview:mpPassword2];
    
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(100, 330, 120, 40);
    rightBtn.frame = CGRectMake(startX + 180, mpPassword2.buttom + 30, 120, 40);

    rightBtn.tag = 101;
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpBaseView addSubview:rightBtn];
}


-(void)btnClick:(UIButton *)btn
{
    [self sendChangePwdRequest];
}

-(void)initData
{
    center = mpBaseView.center;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = @"修改密码";
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
            CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"密码修改成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}

-(void)sendChangePwdRequest
{
    if (mpPassword.text.length == 0 || mpPassword2.text.length == 0) {
        CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        
        //        [CommonInterface showToastViewForCurrentVisibleViewForTwoSecondsWithMessage:@"密码不能为空"];
        return;
    }
    
    if (mpOldPassword.text.length == 0) {
        CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"旧密码不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }

    
    if (![mpPassword.text isEqualToString:mpPassword2.text]) {
        CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"两次新密码不相同" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        
        //        [CommonInterface showToastViewForCurrentVisibleViewForTwoSecondsWithMessage:@"两次密码不相同"];
        return;
    }
    
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/User/ChangePassword.action"];
    operation.downInfoDelegate = self;
    operation.tag = 100;
    
    [operation.argumentDic setValue:[mpOldPassword.text stringFromMD5] forKey:@"OldPassword"];
    [operation.argumentDic setValue:[mpPassword.text stringFromMD5] forKey:@"Password"];
    [operation.argumentDic setValue:[mpPassword2.text stringFromMD5] forKey:@"RePassword"];
    operation.isPOST = YES;
    [[Common getOperationQueue] addOperation:operation];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mpOldPassword resignFirstResponder];
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
