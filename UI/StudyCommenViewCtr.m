//
//  StudyCommenViewCtr.m
//  ExaminationIpad
//
//  Created by gurd on 13-9-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "StudyCommenViewCtr.h"
#import "NewItoast.h"

@interface StudyCommenViewCtr ()

@end

@implementation StudyCommenViewCtr
@synthesize infoDic = mpInfoDic;
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
    [mpTextView becomeFirstResponder];
}

-(void)addSubViews
{
    
    mpTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, (appFrameWidth-60)-20, appFrameHeigh-44-50)];
    mpTextView.font = [UIFont systemFontOfSize:16];
    //    mpTextView.text = @"人世间，比青春再可宝贵的东西实在没有，然而青春也最容易消逝。最可贵的东西却不甚为人所爱惜，最易消逝的东西却在促进它的消逝。谁能保持得永远的青春的，便是伟大的人。";
    [mpBaseView addSubview:mpTextView];
}
-(void)rightBtnClick
{
    [self saveDataToService];
}

-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(appFrameWidth-90, 7, 80, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"发表" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if ([info ifInvolveStr:@"\"result\":\"1\""]) {
        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
            [NewItoast showItoastWithMessage:@"提交成功"];
            [mpTextView setText:@""];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


-(void)saveDataToService
{
    if (mpTextView.text.length == 0) {
        [NewItoast showItoastWithMessage:@"请输入内容"];
        return;
    }
    
    
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Remark.action"];
    operation.tag = 101;
    operation.showAnimation = NO;

    NSString * info = [NSString stringWithString:mpTextView.text];
    [operation.argumentDic setValue:info forKey:@"Brief"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    mpTitleLabel.text = @"发表交流";
    [self addLeftButton];
    [self addRightBtn];
    [self addSubViews];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
