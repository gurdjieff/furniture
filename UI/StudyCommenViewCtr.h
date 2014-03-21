//
//  StudyCommenViewCtr.h
//  ExaminationIpad
//
//  Created by gurd on 13-9-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "BaseViewController.h"

@interface StudyCommenViewCtr : BaseViewController
<downLoadDelegate>
{
    UITextView * mpTextView;
    NSDictionary * mpInfoDic;
    float screenWidth;
    float screenHeight;
}
@property(nonatomic, retain) NSDictionary * infoDic;

@end
