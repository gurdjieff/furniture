//
//  CustomTabBarViewCtr.m
//  Examination
//
//  Created by gurd on 13-6-23.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "CustomTabBarViewCtr.h"
#import "BaseViewController.h"
#import "CustomNavigationViewCtr.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

#define TabBarHeight 48

@interface CustomTabBarViewCtr ()

@end

@implementation CustomTabBarViewCtr

+(CustomTabBarViewCtr *)shareTabBarViewCtr
{
    static CustomTabBarViewCtr * instance = nil;
    if (instance == nil) {
        instance = [[CustomTabBarViewCtr alloc] init];
    }
    return instance;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)addViewCtrs
{
    FirstViewController * fvc = [[FirstViewController alloc] init];
    CustomNavigationViewCtr * cvc1 = [[CustomNavigationViewCtr alloc] initWithRootViewController:fvc];
    
    
    SecondViewController * svc = [[SecondViewController alloc] init];
    CustomNavigationViewCtr * cvc2 = [[CustomNavigationViewCtr alloc] initWithRootViewController:svc];
    
    ThirdViewController * tvc = [[ThirdViewController alloc] init];
    CustomNavigationViewCtr * cvc3 = [[CustomNavigationViewCtr alloc] initWithRootViewController:tvc];
    
    FourthViewController * fvc2 = [[FourthViewController alloc] init];
    CustomNavigationViewCtr * cvc4 = [[CustomNavigationViewCtr alloc] initWithRootViewController:fvc2];
    
    
    NSArray * aryTemp = [NSArray arrayWithObjects:cvc1,cvc2,cvc3,cvc4, nil];
    self.viewControllers = aryTemp;

}

-(void)btnClick:(UIButton *)apBtn
{
    NSArray * ary = [NSArray arrayWithObjects:@"firstGray.png",@"secondGray.png",@"thirdGray.png",@"fourthGray.png", nil];
    NSArray * ary2 = [NSArray arrayWithObjects:@"firstYellow.png",@"secondYellow.png",@"thirdYellow.png",@"fourthYellow.png", nil];

    for (int i = 0; i < 4; i++) {
        UIButton * btn = (UIButton *)[mpView viewWithTag:100+i];
        [btn setBackgroundImage:[UIImage imageNamed:[ary objectAtIndex:i]] forState:UIControlStateNormal];
        btn.userInteractionEnabled = YES;
    }
    apBtn.userInteractionEnabled = NO;
    [apBtn setBackgroundImage:[UIImage imageNamed:[ary2 objectAtIndex:apBtn.tag - 100]] forState:UIControlStateNormal];
    [apBtn setBackgroundImage:[UIImage imageNamed:[ary2 objectAtIndex:apBtn.tag - 100]] forState:UIControlStateHighlighted];

    self.selectedIndex = apBtn.tag-100;
}

-(void)addCustomTabBarView
{
    mpView = [[UIView alloc] initWithFrame:CGRectMake(0, 44+20, 60.0, 748-44)];
    mpView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"purpleSmall.png"]];
    [self.view addSubview:mpView];
    
    
    NSArray * ary = [NSArray arrayWithObjects:@"firstGray.png",@"secondGray.png",@"thirdGray.png",@"fourthGray.png", nil];
    float width = 60.0;
//    float heigh = (748.0-44.0-100)/4;
    float heigh = 120.0f;


    for (int i = 0; i < 4; i++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, heigh*i, width, heigh)];
        if (i == 0) {
            [btn setBackgroundImage:[UIImage imageNamed:@"firstYellow.png"] forState:UIControlStateNormal];
        } else {
            [btn setBackgroundImage:[UIImage imageNamed:[ary objectAtIndex:i]] forState:UIControlStateNormal];
        }
        
        if (i == 0) {
            btn.backgroundColor = [UIColor darkGrayColor];
        } else {
            btn.backgroundColor = [UIColor grayColor];
        }
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        btn.tag = 100+i;
        [mpView addSubview:btn];
    }
}

- (void)reRectSubViews
{
    int version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    // 设置tabBarController下子view的frame
    for(UIView *view in self.view.subviews) {
        // 隐藏默认的tabbar
        if([view isKindOfClass:[UITabBar class]]) {
			view.hidden = YES;
			[view setFrame:CGRectMake(view.frame.origin.x, self.view.bounds.size.height, self.view.bounds.size.width,TabBarHeight)];
            //设置tabBarviewController.view的大小
            // 统一移动子view的frame
        } else {
			[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [[UIScreen mainScreen] bounds].size.height)];
		}
	}
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self reRectSubViews];
    [self addViewCtrs];
    [self addCustomTabBarView];
	// Do any additional setup after loading the view.
}


//-(BOOL)shouldAutorotate
//{
//    return YES;
//}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if (toInterfaceOrientation == UIDeviceOrientationLandscapeRight
        || toInterfaceOrientation == UIDeviceOrientationLandscapeLeft) {
        return YES;
    } else {
        return NO;
    }
}

//- (BOOL) shouldAutorotate {
//    UIViewController *controller = self.selectedViewController;
//    if ([controller isKindOfClass:[UINavigationController class]])
//        controller = [(UINavigationController *)controller visibleViewController];
//    if ([controller isKindOfClass:NSClassFromString(@"MPInlineVideoFullscreenViewController")]) {
//        return YES;
//    } else {
//        return NO;
//    }
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
