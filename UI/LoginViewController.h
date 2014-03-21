//
//  LoginViewController.h
//  Examination
//
//  Created by gurdjieff on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>


@interface LoginViewController : BaseViewController
<downLoadDelegate, TencentSessionDelegate>
{
    UITextField * mpName;
    UITextField * mpPassword;
    CGPoint center;
    TencentOAuth * _tencentOAuth;
}

@end
