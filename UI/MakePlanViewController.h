//
//  MakePlanViewController.h
//  ExaminationIpad
//
//  Created by gurd on 13-9-2.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomKeyboardOne.h"

@interface MakePlanViewController : BaseViewController
<downLoadDelegate,UITextFieldDelegate, KeyboardDelegate>
{
    UILabel * mpLabel1;
    UILabel * mpLabel2;

    UITextField * mpTextField1;
    UITextField * mpTextField2;
    UITextField * mpTextField3;
    UITextField * mpTextField4;
}

@end
