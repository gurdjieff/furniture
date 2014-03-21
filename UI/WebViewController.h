//
//  WebViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "ApiAccount.h"

@interface WebViewController : BaseViewController
    <downLoadDelegate,UIWebViewDelegate>
{
    float screenWidth;
    float screenHeight;
    UIWebView *contentWebView;

}
@property(nonatomic,assign) ListStyle LS;
@property(nonatomic,retain) NSString * theTitle;
@property(nonatomic,retain) NSDictionary * requestDic;


@end
