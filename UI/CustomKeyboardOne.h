//
//  CustomKeyboardOne.h
//  ExaminationIpad
//
//  Created by gurd on 13-9-2.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KeyboardDelegate <NSObject>
@required
-(void)keyboardMesgChangeWithStr:(NSDictionary *)meg withTag:(int)tag;
-(void)keyboardBtnClick;

@end


@interface CustomKeyboardOne : UIView
{
    id <KeyboardDelegate> mpDelegate;
    @public
    UIDatePicker * mpDatePicker;
}
@property id <KeyboardDelegate> delegate;
-(void)datePickerChange;
-(void)resetPickerViewFrame;
-(void)setMinimumDate:(NSDate *)date;



@end
