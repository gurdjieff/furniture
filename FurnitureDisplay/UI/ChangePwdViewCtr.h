//
//  ChangePwdViewCtr.h
//  Examination
//
//  Created by gurd on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangePwdViewCtr : BaseViewController
<downLoadDelegate>
{
    UITextField * mpOldPassword;
    UITextField * mpPassword;
    UITextField * mpPassword2;
    CGPoint center;
    
}
@end
