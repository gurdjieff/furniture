//
//  CustomKeyboardTwo.m
//  ExaminationIpad
//
//  Created by gurd on 13-9-2.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "CustomKeyboardTwo.h"

@implementation CustomKeyboardTwo
@synthesize delegate = mpDelegate;
@synthesize dataAry = mpDataAry;
-(void)addPickerView
{
    mpPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(306, 40, appFrameWidth-562, 260)];
    mpPickerView.delegate = self;
    mpPickerView.dataSource = self;
    mpPickerView.showsSelectionIndicator = YES;
    [self addSubview:mpPickerView];
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
//        self.backgroundColor = [UIColor grayColor] ;
        mpDataAry = [[NSMutableArray alloc] init];
        [self addPickerView];

    }
    return self;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [mpDataAry count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
     NSString * title = mpDataAry[row][@"Name"];
    UILabel * label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    [label setText:title];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor blackColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

-(void)pickerviewDidSelect
{
    NSDictionary * message = mpDataAry[0];
    if ([mpDelegate respondsToSelector:@selector(keyboardMesgChangeWithStr:withTag:)]) {
        [mpDelegate keyboardMesgChangeWithStr:message withTag:self.tag];
    }

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary * message = mpDataAry[row];
    if ([mpDelegate respondsToSelector:@selector(keyboardMesgChangeWithStr:withTag:)]) {
        [mpDelegate keyboardMesgChangeWithStr:message withTag:self.tag];
    }
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
