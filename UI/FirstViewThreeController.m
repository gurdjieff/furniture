//
//  FirstViewThreeController.m
//  Examination
//
//  Created by gurdjieff on 13-7-19.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "FirstViewThreeController.h"
#import "NSString+CustomCategory.h"
#import "RemarkViewCtr.h"
#import "FirstViewCommentCtr.h"
#import "PredictTestViewCtr.h"
#import "AppDelegate.h"
#import "DownloadManager.h"


@interface FirstViewThreeController ()

@end

@implementation FirstViewThreeController
@synthesize infoDic = mpInfoDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)rightBtnClick
{
    if (mpImageBackView.frame.origin.y == 0.0) {
        [UIView animateWithDuration:0.5 animations:^{
            mpImageBackView.frame = CGRectMake(320-105, 0-200, 100, 152);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            mpImageBackView.frame = CGRectMake(320-105, 0, 100, 152);
        }];
    }
}

-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(320-45, 5, 40, 35);
    [btn setBackgroundImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}

-(void)addMenuViews
{
    mpImageBackView = [[UIImageView alloc] initWithFrame:CGRectMake(appFrameWidth-100-60, 0, 100, appFrameHeigh-44)];
    mpImageBackView.userInteractionEnabled = YES;
    mpImageBackView.backgroundColor = [UIColor lightGrayColor];
//    mpImageBackView.image = [UIImage imageNamed:@"bumpRect.png"];
    [mpBaseView addSubview:mpImageBackView];
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(5, 0, 90, 40);
    [btn1 setTitle:@"测评" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:20];

    [btn1 setBackgroundImage:[UIImage imageNamed:@"purpleSmall.png"] forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"btnYellow.png"] forState:UIControlStateHighlighted];
    
    btn1.tag = 101;
    [btn1 addTarget:self action:@selector(memuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpImageBackView addSubview:btn1];

    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(5, 50, 90, 40);
    [btn2 setTitle:@"写笔记" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    [btn2 setBackgroundImage:[UIImage imageNamed:@"purpleSmall.png"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"btnYellow.png"] forState:UIControlStateHighlighted];
    
    btn2.tag = 102;
    [btn2 addTarget:self action:@selector(memuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mpImageBackView addSubview:btn2];
    

//    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn3.frame = CGRectMake(5, 100, 90, 40);
//    [btn3 setTitle:@"评论" forState:UIControlStateNormal];
//    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn3.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    [btn3 setBackgroundImage:[UIImage imageNamed:@"purpleSmall.png"] forState:UIControlStateNormal];
//    [btn3 setBackgroundImage:[UIImage imageNamed:@"btnYellow.png"] forState:UIControlStateHighlighted];
//    
//    btn3.tag = 103;
//    [btn3 addTarget:self action:@selector(memuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [mpImageBackView addSubview:btn3];
//
//    UIButton * btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn4.frame = CGRectMake(5, 150, 90, 40);
//    [btn4 setTitle:@"打分" forState:UIControlStateNormal];
//    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn4.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    [btn4 setBackgroundImage:[UIImage imageNamed:@"purpleSmall.png"] forState:UIControlStateNormal];
//    [btn4 setBackgroundImage:[UIImage imageNamed:@"btnYellow.png"] forState:UIControlStateHighlighted];
//    
//    btn4.tag = 104;
//    [btn4 addTarget:self action:@selector(memuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [mpImageBackView addSubview:btn4];
    
    [self.view bringSubviewToFront:mpNavitateView];
}

-(void)memuBtnClick:(UIButton *)btn
{
    if (btn.tag == 101) {
        PredictTestViewCtr * lpViewCtr = [[PredictTestViewCtr alloc] init];
        lpViewCtr.infoDic = mpInfoDic;
        lpViewCtr.testType = 0;
        [self.navigationController pushViewController:lpViewCtr animated:YES];
    } else if (btn.tag == 102) {
        RemarkViewCtr * lpViewCtr = [[RemarkViewCtr alloc] init];
        lpViewCtr.infoDic = mpInfoDic;
        [self.navigationController pushViewController:lpViewCtr animated:YES];
    } else if (btn.tag == 103) {
        FirstViewCommentCtr * lpViewCtr = [[FirstViewCommentCtr alloc] init];
        lpViewCtr.infoDic = mpInfoDic;
        [self.navigationController pushViewController:lpViewCtr animated:YES];
    } else if (btn.tag == 104) {
        [UIView animateWithDuration:0.5 animations:^{
            mpScoredView.alpha = 1.0;
        } completion:^(BOOL f){
            mpScoredView.userInteractionEnabled = YES;
        }];
    }
}

-(void)playMovie:(NSString *)apUrl
{
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"girl" ofType:@"mp4"];
    //    AVQueuePlayer *
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"rmvb"];
    //    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    //    AVAsset *movieAsset	= [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    //    NSString *file = [[NSString alloc] initWithFormat:@"http://devimages.apple.com/samplecode/adDemo/ad.m3u8"];
    //    NSString *file = [[NSString alloc] initWithFormat:@"http://116.90.86.104/Course/Media.action?GUID=64df1be2-9463-4bc0-bd12-7e90793f4106"];
    
//    NSString *file = [[NSString alloc] initWithFormat:@"http://www.bj5800.com/upload/video/17.mp4"];
    
    //    http://www.bj5800.com/upload/video/17.mp4
    NSURL *url = [[NSURL alloc] initWithString:apUrl];
    AVURLAsset *movieAsset = [AVURLAsset assetWithURL:url];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(0, 0, 480, 320);
    playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:playerLayer];
    [player play];
}


-(void)getVideoWithUrl:(NSString *)mediaUrl
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"%@.mp4",mediaUrl]];
    operation.useCache = YES;
    operation.updateCache = NO;
//    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    AppDelegate * appDegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSOperationQueue * lpOperationQueue = appDegate.operationQueue;
    [lpOperationQueue addOperation:operation];
}

-(NSString *)getVideoSaveName
{
    return [mpInfoDic objectForKey:@"GUID"];
}


-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    NSLog(@"%@",info);
    
    if (tag==100) {
        if ([info ifInvolveStr:@"result"]) {
            NSDictionary * tempDic = [[NSDictionary alloc] initWithDictionary:[info JSONValue]];
            if ([tempDic[@"result"] intValue] == 1) {
//                NSString * lpName = tempDic[@"Name"];
                NSString * lpBrief = tempDic[@"Brief"];
                NSString * lpDetail = tempDic[@"Detail"];
//                NSString * lpMediaUrl =[serverIp stringByAppendingFormat:@"%@",tempDic[@"MediaUrl"]];
                NSString * lpMediaUrl = tempDic[@"MediaUrl"];
                NSString * htmlTwo = nil;
                
                if (lpMediaUrl) {
                    NSArray * strArray =[lpMediaUrl componentsSeparatedByString:@"="];
                    
//                    NSString * movieName =[strArray lastObject];
                    NSString * movieName =[self getVideoSaveName];

                    
                    BOOL isDownload =[DownloadHelper readDataFromSqlite:movieName];
                    
                    if (!isDownload)
                    {
                        [DownloadHelper writeDataToSqlite:movieName with:@"no"];
                        
                        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@.mp4",lpMediaUrl]];
                        DownloadManager *dm = [[DownloadManager alloc] initWithURL:url];
                        dm.imageName = [NSString stringWithFormat:@"%@.mp4",movieName];
                        [dm start];
                    } else {
                        NSString * path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                        movieName = [NSString stringWithFormat:@"%@.mp4",movieName];
                        path =[path stringByAppendingPathComponent:movieName];
                        lpMediaUrl =[NSString stringWithFormat:@"file://%@",path];
                    }

                    
                    
//                    [self getVideoWithUrl:lpMediaUrl];
//                    NSArray * strArray =[lpMediaUrl componentsSeparatedByString:@"="];
                    
//                    NSString * movieName =[strArray lastObject];
                    htmlTwo = [NSString stringWithFormat:@"<body><section class=\"introduction\"><h3>简介</h3><div>%@</div></section><section class=\"video\"><video width=\"600\" height=\"450\" controls=\"controls\"><source type=\"video/ogg\" src=\"%@\"><source type=\"video/mp4\" src=\"%@\">您的浏览器不支持该标签.</video></section><section class=\"detail\"><h3>详情</h3><div>%@</div></section></body>", lpBrief, lpMediaUrl, lpMediaUrl, lpDetail];
				} else {
					htmlTwo = [NSString stringWithFormat:@"<body><section class=\"introduction\"><h3>简介</h3><div>%@</div></section><section class=\"detail\"><h3>详情</h3><div>%@</div></section></body>", lpBrief, lpDetail];
				}
//                [self playMovie:lpMediaUrl];
                
//                NSString * htmlTwo = [NSString stringWithFormat:@"<body><section class=\"introduction\"><h3>%@</h3><div>%@</div></section><section class=\"video\"><video width=\"300\" height=\"240\" controls=\"controls\"><source type=\"video/ogg\" src=\"%@\"><source type=\"video/mp4\" src=\"%@\">您的浏览器不支持该标签.</video></section><section class=\"detail\"><h3>详情</h3><div>%@</div></section></body>", lpName, lpBrief, lpMediaUrl, lpMediaUrl, lpDetail];
                
                NSString * path =[[NSBundle mainBundle] pathForResource:@"thirdViewo1" ofType:@"html"];
                NSMutableString * htmlStr =[[NSMutableString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
                [htmlStr appendFormat:@"%@%@</html>", htmlStr, htmlTwo];
                [mpWebView loadHTMLString:htmlStr baseURL:nil];
            }
        }
    } else if (tag == 101) {
        
    } else if (tag == 102) {
        if ([info ifInvolveStr:@"\"result\":\"1\""]) {
            [iLoadAnimationView showItoastMesage:@"打分成功"];
        }
        
    }
    
//        {
//            Brief = "\U4eba\U4e8b\U6863\U6848\U7ba1\U7406\U5c31\U662f\U5c06\U4eba\U4e8b\U6863\U6848\U7684\U6536\U96c6\U3001\U6574\U7406\U3001\U4fdd\U7ba1\U3001\U9274\U5b9a\U3001\U7edf\U8ba1\U548c\U63d0\U4f9b\U5229\U7528\U7684\U6d3b\U52a8\U3002";
//            Detail = "\U4eba\U4e8b\U6863\U6848\U7ba1\U7406\U5c31\U662f\U5c06\U4eba\U4e8b\U6863\U6848\U7684\U6536\U96c6\U3001\U6574\U7406\U3001\U4fdd\U7ba1\U3001\U9274\U5b9a\U3001\U7edf\U8ba1\U548c\U63d0\U4f9b\U5229\U7528\U7684\U6d3b\U52a8\U3002\U4eba\U4e8b\U6863\U6848\U662f\U4eba\U4e8b\U7ba1\U7406\U6d3b\U52a8\U4e2d\U5f62\U6210\U7684\Uff0c\U8bb0\U8ff0\U548c\U53cd\U6620\U4e2a\U4eba\U7ecf\U5386\U548c\U5fb7\U624d\U8868\U73b0\Uff0c\U4ee5\U4e2a\U4eba\U4e3a\U5355\U4f4d\U7ec4\U5408\U8d77\U6765\Uff0c\U4ee5\U5907\U8003\U5bdf\U7684\U6587\U4ef6\U6750\U6599\U3002";
//            GUID = "64df1be2-9463-4bc0-bd12-7e90793f4106";
//            MediaUrl = "/Course/Media.action?GUID=64df1be2-9463-4bc0-bd12-7e90793f4106";
//            Name = "\U4eba\U4e8b\U6863\U6848\U5229\U7528\U7684\U65b9\U5f0f";
//            result = 1;
//        }
        
//        {"result":"1","GUID":"64df1be2-9463-4bc0-bd12-7e90793f4106","Name":"人事档案利用的方式","Brief":"人事档案管理就是将人事档案的收集、整理、保管、鉴定、统计和提供利用的活动。","Detail":"人事档案管理就是将人事档案的收集、整理、保管、鉴定、统计和提供利用的活动。人事档案是人事管理活动中形成的，记述和反映个人经历和德才表现，以个人为单位组合起来，以备考察的文件材料。","MediaUrl":"/Course/Media.action?GUID=64df1be2-9463-4bc0-bd12-7e90793f4106"}
    
//    NSString * htmlStr2 = @"<body><section class=\"introduction\"><h3>人事档案利用的方式</h3><div>人事档案管理就是将人事档案的收集、整理、保管、鉴定、统计和提供利用的活动。</div></section><section class=\"video\"><video width=\"320\" height=\"240\" controls=\"controls\"><source type=\"video/ogg\" src=\"http://116.90.86.104/Course/Media.action?GUID=64df1be2-9463-4bc0-bd12-7e90793f4106\"><source type=\"video/mp4\" src=\"http://116.90.86.104/Course/Media.action?GUID=64df1be2-9463-4bc0-bd12-7e90793f4106\">您的浏览器不支持该标签.</video></section><section class=\"detail\"><h3>详情</h3><div>人事档案管理就是将人事档案的收集、整理、保管、鉴定、统计和提供利用的活动。人事档案是人事管理活动中形成的，记述和反映个人经历和德才表现，以个人为单位组合起来，以备考察的文件材料</div></section></body>";
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    
}


-(void)getDataFromService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/KnowledgeView.action"];
    operation.useCache = YES;
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"GUID"];
    operation.downInfoDelegate = self;
    operation.tag =100;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}

-(void)getVideoData
{
    NSString * mediastr = [contentDict objectForKey:@"GUID"];
    NSString * guidstr =[contentDict objectForKey:@"MediaUrl"];
    NSLog(@"%@ %@",mediastr,guidstr);
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/Media.action"];
    [operation.argumentDic setValue:guidstr forKey:@"GUID"];
    operation.downInfoDelegate = self;
    operation.tag =101;
    operation.useCache = YES;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}

-(void)initData
{
    mpDictionary = [[NSMutableDictionary alloc] init];
    contentDict = [[NSMutableDictionary alloc] init];
}

- (BOOL) shouldAutorotate {
    UIViewController *controller = self.navigationController;
    if ([controller isKindOfClass:[UINavigationController class]])
        controller = [(UINavigationController *)controller visibleViewController];
    if ([controller isKindOfClass:NSClassFromString(@"MPInlineVideoFullscreenViewController")]) {
        return YES;
    } else {
        return NO;
    }
}


-(void)addWebView
{
    int version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    mpWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, appFrameWidth-60, appFrameHeigh-44)];
    mpWebView.delegate = self;
    [mpBaseView addSubview:mpWebView];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [mpWebView stringByEvaluatingJavaScriptFromString:@""];
}


-(void)scoredBtnClick
{
    int number = 0;
    for (int i = 0; i < 5; i++) {
        UIButton * btn = (UIButton *)[mpScoredView viewWithTag:101 + i];
        if (btn.selected) {
            number += 1;
        }
    }
    
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/Course/KnowledgeView.action"];
    [operation.argumentDic setValue:[mpInfoDic objectForKey:@"GUID"] forKey:@"GUID"];
    operation.downInfoDelegate = self;
    operation.tag = 102;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];


    [UIView animateWithDuration:0.5 animations:^{
        mpScoredView.alpha = 0.0;
    } completion:^(BOOL f){
        mpScoredView.userInteractionEnabled = NO;
    }];

}

-(void)resetTitle
{
//    return;
//    int number = 0;
//    for (int i = 0; i < 5; i++) {
//        UIButton * btn = (UIButton *)[mpFootView2 viewWithTag:101 + i];
//        if (btn.selected) {
//            number += 1;
//        }
//    }
//    mpLabel.text = [NSString stringWithFormat:@"%d星",number];
}


-(void)starBtnClick:(UIButton *)apBtn
{
    for (int i = 0; i < 5; i++) {
        UIButton * btn = (UIButton *)[mpScoredView viewWithTag:101 + i];
        [btn setBackgroundImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        btn.selected = NO;
    }
    
    for (int i = 0; i <= apBtn.tag - 101; i++) {
        UIButton * btn = (UIButton *)[mpScoredView viewWithTag:101 + i];
        [btn setBackgroundImage:[UIImage imageNamed:@"yellowStar.png"] forState:UIControlStateNormal];
        btn.selected = YES;
    }
}


-(void)addScoredView
{
    mpScoredView = [[UIView alloc] initWithFrame:CGRectMake(140, 160, 600, 300)];
//    mpScoredView.backgroundColor = [UIColor grayColor];
    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 140)];
    lpView.backgroundColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:0.98];
    [mpScoredView addSubview:lpView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 600, 50)];
    label.textColor = [UIColor colorWithRed:0x58/255.0f green:0x42/255.0f blue:0x2e/255.0f alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:22];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.text = @"打分";
    [lpView addSubview:label];
    
    for (int i = 0; i < 5; i++) {
        UIButton * lpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lpBtn.frame = CGRectMake(60 + i * 110, 60, 45, 45);
        [lpBtn setBackgroundImage:[UIImage imageNamed:@"whiteStar.png"] forState:UIControlStateNormal];
        lpBtn.tag = 101 + i;
        lpBtn.selected = NO;
        [lpBtn addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [mpScoredView addSubview:lpBtn];
    }

    
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(250, 200, 100, 50);
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [submitBtn addTarget:self action:@selector(scoredBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpScoredView addSubview:submitBtn];
    
    [mpBaseView addSubview:mpScoredView];
    
    mpScoredView.userInteractionEnabled = NO;
    mpScoredView.alpha = 0.0;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    mpTitleLabel.text = [mpInfoDic objectForKey:@"Name"];
    mpBaseView.backgroundColor = [UIColor whiteColor];
    [self addLeftButton];
    [self addWebView];
//    [self addMenuViews];
    [self addScoredView];
    [self getDataFromService];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
