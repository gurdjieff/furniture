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
#import "Custombutton.h"

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

-(void)showMenuView
{
    [UIView animateWithDuration:0.5 animations:^{
        mpMenuView.frame = CGRectMake(40, 20, 200, 60*(4+1));
    } completion:nil];
}

-(void)hideMenuView
{
    [UIView animateWithDuration:0.5 animations:^{
        mpMenuView.frame = CGRectMake(40, 20, 200, 40);
    } completion:nil];
}

-(void)showMenusViewOne
{
    mpMenuView1.frame = CGRectMake(0, 40, 200, 60 * 10);
}

-(void)showMenusViewTwo
{
    mpMenuView2.frame = CGRectMake(0, 40, 200, 60 * 10);
}

-(void)showMenusViewThree
{
    mpMenuView3.frame = CGRectMake(0, 40, 200, 60 * 10);
}

-(void)showMenusViewFour
{
    mpMenuView4.frame = CGRectMake(0, 40, 200, 60 * 10);
}



-(void)headBtnClick:(Custombutton *)apBtn
{
    if (apBtn.tag == 100) {
        if (apBtn.currentSeleted == NO) {
            [self showMenuView];
        } else {
            [self hideMenuView];
            self.selectedIndex = 0;
        }
        apBtn.currentSeleted = !apBtn.currentSeleted;
    }
    
    return;
    self.selectedIndex = apBtn.tag-100;
}


-(void)menuBtnClick:(Custombutton *)apBtn
{
    if (apBtn.tag == 100) {
        
    } else if (apBtn.tag == 101) {
    
    } else if (apBtn.tag == 102) {
        
    } else if (apBtn.tag == 103) {
        
    }
}

-(void)addCustomTabBarView
{
    mpMenuView = [[UIView alloc] initWithFrame:CGRectMake(40, 20, 200.0, 40)];
    mpMenuView.backgroundColor = [UIColor grayColor];
    mpMenuView.clipsToBounds = YES;
    
    Custombutton * btn = [Custombutton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(0, 0, 200.0, 40);
    btn.tag = 100;
    [btn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchDown];
    [mpMenuView addSubview:btn];
    [self.view addSubview:mpMenuView];
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

-(void)addMenuBtns
{
    float width = 200.0;
    float heigh = 60.0f;
    NSArray * lpAry = [NSArray arrayWithObjects:@"关于我们",@"大师之家",@"设计师推荐",@"顶层活动", nil];
    
    for (int i = 0; i < 4; i++) {
        Custombutton * btn = [[Custombutton alloc] initWithFrame:CGRectMake(0, heigh*i+40, width, heigh)];
        [btn setTitle:lpAry[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchDown];
        btn.tag = 100+i;
        [mpMenuView addSubview:btn];
    }
}

-(void)initMenuViews
{
    mpMenuView1 = [[UIView alloc] init];
    mpMenuView2 = [[UIView alloc] init];
    mpMenuView3 = [[UIView alloc] init];
    mpMenuView4 = [[UIView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self reRectSubViews];
    [self addViewCtrs];
    [self addCustomTabBarView];
    [self addMenuBtns];
    [self initMenuViews];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if (toInterfaceOrientation == UIDeviceOrientationLandscapeRight
        || toInterfaceOrientation == UIDeviceOrientationLandscapeLeft) {
        return YES;
    } else {
        return NO;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
