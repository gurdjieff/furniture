//
//  CustomKeyboardTwo.h
//  ExaminationIpad
//
//  Created by gurd on 13-9-2.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomKeyboardOne.h"
#import "Common.h"
#import "BaseViewController.h"

@interface CustomKeyboardTwo : UIView
<UIPickerViewDelegate, UIPickerViewDataSource>
{
    id <KeyboardDelegate> mpDelegate;
    UIPickerView * mpPickerView;
    NSMutableArray * mpDataAry;
}
@property id <KeyboardDelegate> delegate;
@property (nonatomic, strong) NSMutableArray * dataAry;
-(void)pickerviewDidSelect;


@end
