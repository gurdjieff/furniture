//
//  WebViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize LS;
@synthesize theTitle;
@synthesize requestDic;

-(void)dealloc
{
    [requestDic release];
    [theTitle release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        screenWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mpTitleLabel.text = theTitle;
    [self addLeftButton];
    
    if (LS == mingjiajiangtang) 
        [self addRightButton];
    [self addWebView];
    [self sendHttpRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rightBtnClick
{
    
}

-(void)addRightButton
{
    NSString * title = nil;
        title= @"我要报名";
    
    UIButton * lpRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth-80,3, 70, 38)];
    [lpRightBtn setTitle:title forState:UIControlStateNormal];
    [lpRightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [lpRightBtn setBackgroundColor:[UIColor orangeColor]];
    [lpRightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:lpRightBtn];
    [lpRightBtn release];
}


-(void)addWebView
{
    contentWebView=[[UIWebView alloc]initWithFrame:CGRectMake(5, 44, screenWidth-10,screenHeight-44)];
    contentWebView.delegate = self;
//    [contentWebView setScalesPageToFit:YES];
	contentWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    contentWebView.opaque = NO;
	contentWebView.scrollView.bounces =YES;
    contentWebView.backgroundColor =[UIColor whiteColor];    
	[self.view addSubview:contentWebView];
	[contentWebView release];
}



#pragma mark - http



-(void)sendHttpRequest
{
    
    NSLog(@"requestDic：%@",requestDic);
    
    /*
     
     8.2名家讲堂详情
     说明：获得教师详细信息。
     请求地址：/Application/TeacherView.action
     
     
     */
    if (LS == mingjiajiangtang)
    {
        NSString * urlString = nil;
        NSString * theKey = nil;

        commonDataOperation * operation = [[commonDataOperation alloc] init];
        urlString = @"/Application/TeacherView.action";
        theKey = @"GUID";
        operation.tag = 30002;
        operation.urlStr = [serverIp stringByAppendingString:urlString];
        [operation.argumentDic setValue:[requestDic objectForKey:theKey] forKey:theKey];

        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [[Common getOperationQueue] addOperation:operation];
        [operation release];
    }
    /*
     
     8.4学校详情
     说明：获得学校详细信息。
     请求地址：/Application/SchoolView.action
     
     */
    
    else if (LS == xuexiaoxinxi)
    {
        NSString * urlString = nil;
        NSString * theKey = nil;
        
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        urlString = @"/Application/SchoolView.action";
        theKey = @"GUID";
        operation.tag = 30004;
        
        operation.urlStr = [serverIp stringByAppendingString:urlString];
        [operation.argumentDic setValue:[requestDic objectForKey:theKey] forKey:theKey];
        
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [[Common getOperationQueue] addOperation:operation];
        [operation release];
    }
    
    /*
     
     6.8学习交流回复列表（分页）
     说明：
     请求地址：/Course/ReplyList.action
     请求参数
     序号
     参数名称
     必须
     描述
     1
     ReplyID
     是
     主贴编码
     

     
     
     */
    
    else
        ;
    
    
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",info);
    
    if (LS == zhentiyanlian)
    {
        
    }
    
}
-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",info);
    
    @try {
        
        
        //讲坛详情
        
        
        if (tag == 30002)
        {
            NSLog(@"%@",info);
            
            NSString * content =[[info JSONValue] objectForKey:@"Detail"];
            
            [contentWebView loadHTMLString:content baseURL:nil];
        }
        
        //学校详情
        if (tag ==30004) {
            NSLog(@"%@",info);
            
            
            NSString * content =[[info JSONValue] objectForKey:@"Detail"];
            
            [contentWebView loadHTMLString:content baseURL:nil];
            
            
        }
        
        
           
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception reason]);
    }
    @finally {
        ;
    }
    
    
    
}
-(void)FreshDataWithInfo:(NSString *)info with:(NSInteger)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",info);
    
}



@end
