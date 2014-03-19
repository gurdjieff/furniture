//
//  RemarkViewCtr.m
//  Examination
//
//  Created by gurdjieff on 13-7-6.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "RemarkViewCtr.h"
#import "CustomAlertView.h"

@interface RemarkViewCtr ()

@end

@implementation RemarkViewCtr
@synthesize infoDic = mpInfoDic;

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
    UILabel * lpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 30)];
    lpLabel.backgroundColor = [UIColor clearColor];
    lpLabel.font = [UIFont boldSystemFontOfSize:20];
    lpLabel.text = @"笔记";
    lpLabel.textColor = [UIColor colorWithRed:0x58/255.0f green:0x42/255.0f blue:0x2e/255.0f alpha:1.0];
    [mpBaseView addSubview:lpLabel];
    UILabel * lpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, lpLabel.buttom, 40, 2)];
    lpLabel2.backgroundColor = [UIColor colorWithRed:0x58/255.0f green:0x42/255.0f blue:0x2e/255.0f alpha:1.0];
    [mpBaseView addSubview:lpLabel2];

    
    
    
    
    mpTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 42, appFrameWidth-60-20, appFrameHeigh-50-44)];
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
    if (![info ifInvolveStr:@"result"]) {
        return;
    }
    
    if (tag == 100) {
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:[info JSONValue]];
        [mpRemarkDic setDictionary:dic];
        if ([dic[@"result"] intValue] == 1) {
            mpTextView.text = [dic objectForKey:@"Brief"];
        }
        
    } else if (tag == 101) {
        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
            [iLoadAnimationView showItoastMesage:@"发表成功"];
            [self.navigationController popViewControllerAnimated:YES];
//            CustomAlertView * alertView = [[CustomAlertView alloc] initWithTitle:@"温馨提示" message:@"发表成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alertView show];
        }
    }
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}

-(void)saveDataToService
{
    if (mpTextView.text.length == 0) {
//        [iLoadAnimationView showItoastMesage:@""];
    }
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Note.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"CourseID"];
    operation.tag = 101;
    NSString * info = [NSString stringWithString:mpTextView.text];
    
    if (info.length == 0 && mpRemarkDic[@"GUID"]) {
        [operation.argumentDic setValue:mpRemarkDic[@"GUID"] forKey:@"GUID"];
    }
    [operation.argumentDic setValue:info forKey:@"Brief"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}

-(void)getDataFromService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Note.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"CourseID"];
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
    btn.frame = CGRectMake(appFrameWidth-70, 7, 60, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"发表" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}

-(void)initData
{
    mpRemarkDic = [[NSMutableDictionary alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = @"写笔记";
    [self addLeftButton];
    [self addRightBtn];
    [self addSubViews];
    [self getDataFromService];
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
