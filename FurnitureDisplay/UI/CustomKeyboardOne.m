//
//  CustomKeyboardOne.m
//  ExaminationIpad
//
//  Created by gurd on 13-9-2.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "CustomKeyboardOne.h"
#import "BaseViewController.h"

@implementation CustomKeyboardOne
@synthesize delegate = mpDelegate;

-(void)datePickerChange
{
    NSDate * date = mpDatePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"上午"];
    [formatter setPMSymbol:@"下午"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDictionary * tempDic = @{@"data":mpDatePicker.date, @"mesg":[formatter stringFromDate:date]};
    
    if ([mpDelegate respondsToSelector:@selector(keyboardMesgChangeWithStr:withTag:)]) {
        [mpDelegate keyboardMesgChangeWithStr:tempDic withTag:self.tag];
    }
}

-(void)addPickerView
{
    mpDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(306, 40, appFrameWidth-562, 260)];
    mpDatePicker.datePickerMode = UIDatePickerModeDate;
    mpDatePicker.date = [NSDate date];
    mpDatePicker.minimumDate = [NSDate date];
    [mpDatePicker addTarget:self action:@selector(datePickerChange) forControlEvents:UIControlEventValueChanged];
    [self addSubview:mpDatePicker];
}

-(void)setMinimumDate:(NSDate *)date{
    mpDatePicker.date = date;
}

-(void)resetPickerViewFrame
{
    mpDatePicker.frame = CGRectMake(558, 0, appFrameWidth-574, 260);

}

-(void)keyboardBtnClick
{
    if ([mpDelegate respondsToSelector:@selector(keyboardBtnClick)]) {
        [mpDelegate keyboardBtnClick];
    }
}

-(id)init
{
    if ((self = [super init])) {
        self.frame = CGRectMake(0, 0, appFrameWidth, 260);
        UIButton * btn = [[UIButton alloc] initWithFrame:self.frame];
        [btn addTarget:self action:@selector(keyboardBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];

//        self.backgroundColor = [UIColor colorWithRed:96/255.0f
//                                               green:96/255.0f
//                                                blue:96/255.0f alpha:1.0f];
//        
        [self addPickerView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
