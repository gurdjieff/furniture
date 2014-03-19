//
//  AboutUsViewController.m
//  Examination
//
//  Created by gurd on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AppDelegate.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)addWebView
{
    int version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    mpWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, appFrameWidth-60, appFrameHeigh-44)];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([appDelegate.dicData allValues] == 0) {
        [appDelegate sendInitialInfo];
        
    } else {
        NSString * html = appDelegate.dicData[@"About"];
        if (html && html.length > 0) {
            [mpWebView loadHTMLString:html baseURL:nil];
        }
    }
    [mpBaseView addSubview:mpWebView];
}

-(void)aboutUs
{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString * html = appDelegate.dicData[@"About"];
    if (html && html.length > 0 && [html ifInvolveStr:@"html"]) {
        [mpWebView loadHTMLString:html baseURL:nil];
    }

}

-(void)initNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aboutUs) name:@"aboutUs" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mpTitleLabel.text = @"关于我们";
    [self initNotification];
    [self addLeftButton];
    [self addWebView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
