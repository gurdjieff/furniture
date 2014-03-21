//
//  FeedBackViewCtr.m
//  Examination
//
//  Created by gurdjieff on 13-8-12.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FeedBackViewCtr.h"
#import <QuartzCore/QuartzCore.h>

@interface FeedBackViewCtr ()

@end

@implementation FeedBackViewCtr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [mpTextView becomeFirstResponder];
}


-(void)addSubViews
{
    mpTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 20, appFrameWidth-60-20, appFrameHeigh-40-44)];
//    mpTextView.layer.cornerRadius = 5.0;
//    mpTextView.layer.borderWidth = 1.0;
//    mpTextView.layer.borderColor = [UIColor grayColor].CGColor;
    mpTextView.font = [UIFont systemFontOfSize:20];
//    mpTextView.layer.shadowColor = [UIColor greenColor].CGColor;
//    mpTextView.layer.shadowOffset = CGSizeMake(10, 10);
//    mpTextView.layer.shadowOpacity = 0.5;
    [mpBaseView addSubview:mpTextView];
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if (tag== 100) {
        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
            [NewItoast showItoastWithMessage:@"提交成功"];
            [mpTextView setText:@""];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}

-(void)saveDataToService
{
    if (mpTextView.text.length == 0) {
        [NewItoast showItoastWithMessage:@"内容不能为容"];
        return;
    }

    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/System/Feedback.action"];
    operation.tag = 100;
    operation.showAnimation = NO;
    NSString * info = [NSString stringWithString:mpTextView.text];
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
    [self addLeftButton];
    mpTitleLabel.text = @"意见反馈";
    [self addRightBtn];
    [self addSubViews];
	// Do any additional setup after loading the view.
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
