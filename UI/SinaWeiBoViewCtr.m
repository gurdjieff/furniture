//
//  SinaWeiBoViewCtr.m
//  Examination
//
//  Created by gurd on 13-8-12.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "SinaWeiBoViewCtr.h"

@interface SinaWeiBoViewCtr ()

@end

@implementation SinaWeiBoViewCtr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)sinaweiboDidLogIn:(SinaWeibo *)apSinaWeibo
{
//    NSURL *URL =  [NSURL URLWithString:UNLOGURL];
//    asi = [ASIFormDataRequest requestWithURL:URL];
//    asi.requestMethod = @"POST";
//    asi.timeOutSeconds = 60;
//    asi.tag = 1;
//    asi.delegate = self;
//    [asi setPostValue:[[NSNumber numberWithInt:2] stringValue] forKey:@"type"];
//    [asi setPostValue:[WeiBoEngine shareWeiboEngine]->sinaweibo.userID   forKey:@"thirdId"];
//    
//    NSString *k = [NSString stringWithFormat:@"2%@%@",[WeiBoEngine shareWeiboEngine]->sinaweibo.userID,MD5KEY];
//    [asi setPostValue:[k md5Hash] forKey:@"k"];
//    NSLog(@"kyao %@",[k md5Hash]);
//    [asi setPostValue:[NSString stringWithString:[WeiBoEngine shareWeiboEngine]->sinaweibo.accessToken] forKey:@"t"];
//    
//    [self darwherad:asi];
//    [asi startAsynchronous];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addLeftButton];
    mpTitleLabel.text = @"新浪微博登录";
    WeiBoEngine * engine = [WeiBoEngine shareWeiboEngine];
    engine.weiBoDelegate = self;
    [engine->sinaweibo logOut];
    if (![engine->sinaweibo isAuthValid]) {
        [mpBaseView addSubview:[engine->sinaweibo logInView]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
