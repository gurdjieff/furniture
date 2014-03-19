//
//  BaseViewController.m
//  Examination
//
//  Created by gurd on 13-6-23.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mpOperationQueue = [[NSOperationQueue alloc] init];
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
}

-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addLeftButton
{
    UIButton * lpLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [lpLeftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [lpLeftBtn setBackgroundImage:[UIImage imageNamed:@"navigateBack.png"] forState:UIControlStateNormal];
    [mpNavitateView addSubview:lpLeftBtn];
}

-(void)addBaseSubviews
{
    mpBaseView = [[UIView alloc] initWithFrame:CGRectMake(60, 44, 1024-60, 748-44)];
    mpBaseView.userInteractionEnabled = YES;
    mpBaseView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mpBaseView];

    mpNavitateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 748-44, 1024, 44)];
    mpNavitateView.image = [UIImage imageNamed:@"navigatebar.png"];
    [self.view addSubview:mpNavitateView];
    mpNavitateView.userInteractionEnabled = YES;
    
    mpTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, 1024-44*2, 44)];
    mpTitleLabel.backgroundColor = [UIColor clearColor];
    mpTitleLabel.textColor = [UIColor whiteColor];
    mpTitleLabel.textAlignment = NSTextAlignmentCenter;
    mpTitleLabel.font = [UIFont boldSystemFontOfSize:22];
    [mpNavitateView addSubview:mpTitleLabel];
    
    int version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
        mpBaseView.frame = CGRectMake(60, 44+20, 1024-60, 748);
        mpNavitateView.frame = CGRectMake(0, 748-44+20, 1024, 44);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView * view = self.view;
    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [[UIScreen mainScreen] bounds].size.height)];

//    for(UIView *view in self.view.subviews) {
//        // 隐藏默认的tabbar
//        if([view isKindOfClass:[UITabBar class]]) {
//			view.hidden = YES;
//			[view setFrame:CGRectMake(view.frame.origin.x, self.view.bounds.size.height, self.view.bounds.size.width,TabBarHeight)];
//            //设置tabBarviewController.view的大小
//            // 统一移动子view的frame
//        } else {
//			[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [[UIScreen mainScreen] bounds].size.height)];
//		}
//	}
//
    
    
    mpBaseView.backgroundColor = [UIColor colorWithRed:0xe6/255.0 green:0xe4/255.0 blue:0xe2/255.0 alpha:1.0];
    [self addBaseSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    
}

@end
