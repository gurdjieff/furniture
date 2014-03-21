//
//  UserInfoViewCtr.h
//  ExaminationIpad
//
//  Created by gurdjieff on 13-9-15.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomKeyboardOne.h"

@interface UserInfoViewCtr : BaseViewController
<downLoadDelegate, UITableViewDataSource, UITableViewDelegate,
UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate
,KeyboardDelegate>
{
    UITableView * mpTableView;
    NSMutableArray * mpDataAry;
    NSArray * labelNameArr;
    NSMutableDictionary * mpUserInfo;
    UIPopoverController *mpPopover;
    UIView * modifyNickNameView;
    UIView * modifyPhoneNumView;
    UIView * modifyBirthDayView;

    UITextField * mpTextField1;
    UITextField * mpTextField2;
    UITextField * mpTextField3;

    UILabel * mpLabel;
    UIImageView * mpImabeView1;
    UIImageView * mpImabeView2;
    UIImageView * mpImabeView3;
}

@end
