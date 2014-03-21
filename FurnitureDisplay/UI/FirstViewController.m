//
//  FirstViewController.m
//  FurnitureDisplay
//
//  Created by gurd102 on 14-3-19.
//  Copyright (c) 2014年 gurd. All rights reserved.
//

#import "FirstViewController.h"
#import "Custombutton.h"

@interface FirstViewController ()
<UIScrollViewDelegate>
{
    UIScrollView * mpMainScrollView;
    UIScrollView * mpcatalogScrollView;
}
@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)catalogBtnClick:(Custombutton *)apBtn
{
    int number = apBtn.tag - 100;
    mpMainScrollView.contentOffset = CGPointMake(number*appFrameWidth, 0);
}


-(void)addScrollViews
{
    mpMainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, appFrameWidth, appFrameHeigh)];
    mpMainScrollView.contentSize = CGSizeMake(appFrameWidth*10, appFrameHeigh);
    mpMainScrollView.delegate = self;
    mpMainScrollView.tag = 100;
    mpMainScrollView.pagingEnabled = YES;
    [mpBaseView addSubview:mpMainScrollView];
    
    for (int i = 0; i < 20; i++) {
        Custombutton * btn = [Custombutton buttonWithType:UIButtonTypeCustom];
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        btn.layer.borderWidth = 1.0;
        btn.frame = CGRectMake(i*appFrameWidth, 0, appFrameWidth, appFrameHeigh);
        [btn setTitle:[NSString stringWithFormat:@"number:%d", i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:50];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [mpMainScrollView addSubview:btn];
    }
    
    
    mpcatalogScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 400, appFrameWidth, 200)];
    mpcatalogScrollView.contentSize = CGSizeMake(appFrameWidth*10, 200);
    mpcatalogScrollView.bounces = NO;
//    mpcatalogScrollView.delegate = self;
    mpcatalogScrollView.tag = 101;
    [mpBaseView addSubview:mpcatalogScrollView];
    
    for (int i = 0; i < 10; i++) {
        Custombutton * btn = [Custombutton buttonWithType:UIButtonTypeCustom];
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        btn.layer.borderWidth = 1.0;
        btn.frame = CGRectMake(i*400, 0, 400, 200);
        btn.tag = 100 + i;
        [btn setTitle:[NSString stringWithFormat:@"number:%d", i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:50];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(catalogBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [mpcatalogScrollView addSubview:btn];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mpNavitateViewBottom.hidden = YES;
    [self addScrollViews];


	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
