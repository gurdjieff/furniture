//
//  UserInfoViewCtr.m
//  ExaminationIpad
//
//  Created by gurdjieff on 13-9-15.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "UserInfoViewCtr.h"
#import "UserInfoOneCell.h"
#import "UserInfoTwoCell.h"
#import "UIImageView+WebCache.h"
#import "CustomKeyboardOne.h"


@interface UserInfoViewCtr ()

@end

@implementation UserInfoViewCtr

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDataFromService];
}

-(void)keyboardMesgChangeWithStr:(NSDictionary *)meg withTag:(int)tag
{
    mpTextField3.text = meg[@"mesg"];
}

-(void)keyboardBtnClick
{
    [mpTextField3 resignFirstResponder];
}

-(void)modifyNickName
{
    [mpTextField1 resignFirstResponder];
    [self saveNickNameToService];
}

-(void)modifyPhoneNum
{
    [mpTextField2 resignFirstResponder];
    [self savePhoneNumToservice];
}

-(void)modifyBirthDay
{
    [mpTextField3 resignFirstResponder];
    [self saveBirthDateToService];
}

-(void)addSubviews
{
    float width = (1024-60)/2;
    mpBaseView.backgroundColor = cellBackColor;
    
    modifyNickNameView = [[UIView alloc] initWithFrame:CGRectMake(width, 0, width, 748-44)];
    modifyNickNameView.backgroundColor = cellBackColor;
    mpTextField1 = [[UITextField alloc] initWithFrame:CGRectMake(20, 30, width-40, 32)];
    mpTextField1.backgroundColor = [UIColor whiteColor];
	[mpTextField1 setFont:[UIFont systemFontOfSize:16]];
    mpTextField1.borderStyle = UITextBorderStyleRoundedRect;
    mpTextField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	mpTextField1.textAlignment =NSTextAlignmentCenter;
    [modifyNickNameView addSubview:mpTextField1];
    
    UILabel* pLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, width-20, 30)];
    pLabel.backgroundColor = [UIColor clearColor];
    pLabel.font = [UIFont boldSystemFontOfSize:18];
//	[pLabel setTextAlignment:UITextAlignmentCenter];
	[pLabel setText:@"好名字会让更多的朋友记住你"];
    pLabel.textColor = [UIColor grayColor];
//    [modifyNickNameView addSubview:pLabel];

    UIButton *modifyBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    modifyBtn1.frame= CGRectMake(width/2-30, pLabel.buttom + 20, 60, 30);
    [modifyBtn1 addTarget:self
                    action:@selector(modifyNickName)
          forControlEvents:UIControlEventTouchUpInside];
    [modifyBtn1 setTitle:@"确定" forState:UIControlStateNormal];
    [modifyBtn1 setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [modifyNickNameView addSubview:modifyBtn1];

//********************************************    
    
    
    modifyPhoneNumView = [[UIView alloc] initWithFrame:CGRectMake((1024-60)/2, 0, (1024-60)/2, 748-44)];
    modifyPhoneNumView.backgroundColor = cellBackColor;
    mpTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(20, 30, width-40, 32)];
    mpTextField2.backgroundColor = [UIColor whiteColor];
	[mpTextField2 setFont:[UIFont systemFontOfSize:16]];
    mpTextField2.keyboardType = UIKeyboardTypeNumberPad;
    mpTextField2.borderStyle = UITextBorderStyleRoundedRect;
    mpTextField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	mpTextField2.textAlignment =NSTextAlignmentCenter;
    [modifyPhoneNumView addSubview:mpTextField2];
    
    UILabel* pLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, width-20, 30)];
    pLabel2.backgroundColor = [UIColor clearColor];
    pLabel2.font = [UIFont boldSystemFontOfSize:18];
	[pLabel2 setTextAlignment:UITextAlignmentCenter];
	[pLabel2 setText:@"填写你的手机号码吧"];
    pLabel2.textColor = [UIColor grayColor];
    [modifyPhoneNumView addSubview:pLabel2];
    
    UIButton *modifyBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    modifyBtn2.frame= CGRectMake(width/2-30, pLabel.buttom + 20, 60, 30);
    [modifyBtn2 addTarget:self
                   action:@selector(modifyPhoneNum)
         forControlEvents:UIControlEventTouchUpInside];
    [modifyBtn2 setTitle:@"确定" forState:UIControlStateNormal];
    [modifyBtn2 setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [modifyPhoneNumView addSubview:modifyBtn2];

//********************************************


    modifyBirthDayView = [[UIView alloc] initWithFrame:CGRectMake((1024-60)/2, 0, (1024-60)/2, 748-44)];
    modifyBirthDayView.backgroundColor = cellBackColor;
    mpTextField3 = [[UITextField alloc] initWithFrame:CGRectMake(20, 30, width-40, 32)];
    mpTextField3.backgroundColor = [UIColor whiteColor];
	[mpTextField3 setFont:[UIFont systemFontOfSize:16]];
    CustomKeyboardOne * keykoardView = [[CustomKeyboardOne alloc] init];
    [keykoardView resetPickerViewFrame];
    keykoardView.delegate = self;
    keykoardView->mpDatePicker.maximumDate = [NSDate date];
    keykoardView->mpDatePicker.minimumDate = nil;

    [keykoardView datePickerChange];
    mpTextField3.inputView = keykoardView;
    mpTextField3.borderStyle = UITextBorderStyleRoundedRect;
    mpTextField3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	mpTextField3.textAlignment =NSTextAlignmentCenter;
    [modifyBirthDayView addSubview:mpTextField3];
    
    UILabel* pLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, width-20, 30)];
    pLabel3.backgroundColor = [UIColor clearColor];
    pLabel3.font = [UIFont boldSystemFontOfSize:18];
	[pLabel3 setTextAlignment:UITextAlignmentCenter];
	[pLabel3 setText:@"填写你的生日吧"];
    pLabel3.textColor = [UIColor grayColor];
    [modifyBirthDayView addSubview:pLabel3];
    
    UIButton *modifyBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    modifyBtn3.frame= CGRectMake(width/2-30, pLabel.buttom + 20, 60, 30);
    [modifyBtn3 addTarget:self
                   action:@selector(modifyBirthDay)
         forControlEvents:UIControlEventTouchUpInside];
    [modifyBtn3 setTitle:@"确定" forState:UIControlStateNormal];
    [modifyBtn3 setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [modifyBirthDayView addSubview:modifyBtn3];    
    
//********************************************

    modifyNickNameView.hidden = YES;
    modifyPhoneNumView.hidden = YES;
    modifyBirthDayView.hidden = YES;

    [mpBaseView addSubview:modifyNickNameView];
    [mpBaseView addSubview:modifyPhoneNumView];
    [mpBaseView addSubview:modifyBirthDayView];
}

-(void)addTableViewHeadView
{
    UIView * lpVew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 150)];
    
    mpLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, (1024-60)/2-40, 40)];
    mpLabel.backgroundColor = [UIColor clearColor];
    mpLabel.font = [UIFont systemFontOfSize:26];
    mpLabel.textColor = purpleColor;
    mpImabeView1 = [[UIImageView alloc] initWithFrame:CGRectMake(200, mpLabel.buttom+10, 58, 73)];
    mpImabeView2 = [[UIImageView alloc] initWithFrame:CGRectMake(mpImabeView1.right+10, mpLabel.buttom+10, 58, 73)];
    mpImabeView3 = [[UIImageView alloc] initWithFrame:CGRectMake(mpImabeView2.right+10, mpLabel.buttom+10, 58, 73)];
    UILabel * lpLabel = [[UILabel alloc] initWithFrame:CGRectMake(mpImabeView3.right+10, mpImabeView1.buttom-30, 40, 30)];
    lpLabel.backgroundColor = [UIColor clearColor];
    lpLabel.text = @"天";
    lpLabel.font = [UIFont systemFontOfSize:26];
    lpLabel.textColor = purpleColor;
    [lpVew addSubview:lpLabel];

    
    [lpVew addSubview:mpLabel];
    [lpVew addSubview:mpImabeView1];
    [lpVew addSubview:mpImabeView2];
    [lpVew addSubview:mpImabeView3];
    mpTableView.tableHeaderView = lpVew;
}

-(void)addTableView
{
    mpTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 748-44) style:UITableViewStyleGrouped];
    mpTableView.tag = 101;
    mpTableView.showsVerticalScrollIndicator = NO;
    mpTableView.delegate = self;
    mpTableView.dataSource = self;
    mpTableView.separatorColor = [UIColor clearColor];
    mpTableView.backgroundColor = cellBackColor;
//    mpTableView.bounces = NO;
    [mpBaseView addSubview:mpTableView];
    [self addTableViewHeadView];
}

-(NSInteger)getCurrentYear:(NSDate *)apDate
{
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * components = [cal components:NSYearCalendarUnit
                                     | NSMonthCalendarUnit
                                     | NSDayCalendarUnit
                                     | NSHourCalendarUnit
                                     | NSMinuteCalendarUnit
                                     | NSWeekdayCalendarUnit fromDate:apDate];
    NSInteger year = [components year];
    return year;
}

-(void)resetTableHeaderView
{
    NSString * ExamDate = mpUserInfo[@"ExamDate"];
    int examDate = [ExamDate intValue];
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:examDate*24*60*60];
    int year = [self getCurrentYear:date];
    
    NSString * str = [NSString stringWithFormat:@"距离%d年考研还有", year];
    mpLabel.text = str;
    
    int temp1 = examDate/100;
    int temp2 = (examDate%100)/10;
    int temp3 = (examDate%10);

    mpImabeView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.png", temp1]];
    mpImabeView2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.png", temp2]];
    mpImabeView3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.png", temp3]];
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if ([info ifInvolveStr:@"\"result\":\"1\""]) {
        if (tag==101) {
//            $0 = 0x08ca5840 {"result":"1","UserID":"4f02e993-1e3f-4dc2-ac70-7cd359413578","UserRole":"0","UserName":"11111111","NickName":"Yyyyyy","Mobile":"18810082453","BirthDate":"2013-09-06","HeadPhotoUrl":"http://116.90.86.104:81/User/Ico.action?UserID=4f02e993-1e3f-4dc2-ac70-7cd359413578&635148602950000000","ExamDate":"261","StudyRate":"6%"}

            [mpUserInfo setDictionary:[info JSONValue]];
            [self resetTableHeaderView];
        }
		
		if (tag==102) {
            [iLoadAnimationView showItoastMesage:@"上传成功"];
            [self getDataFromService];
		}
        
		if (tag==103) {
            [iLoadAnimationView showItoastMesage:@"提交成功"];
            [self getDataFromService];		}
        
        if (tag==104) {
            [iLoadAnimationView showItoastMesage:@"提交成功"];
            [self getDataFromService];		}
        
        if (tag==105) {
            [iLoadAnimationView showItoastMesage:@"提交成功"];
            [self getDataFromService];		}
     }
    
	[mpTableView reloadData];
}


-(void)getDataFromService
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.urlStr = [serverIp stringByAppendingFormat:@"/User/UserInfo.action"];
    operation.tag = 101;
    operation.useCache = YES;
    [operation.argumentDic setValue:[userDefaults objectForKey:@"UserName"] forKey:@"UserName"];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    [mpOperationQueue addOperation:operation];
}

-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)saveNickNameToService
{
    if (mpTextField1.text.length == 0) {
        [NewItoast showItoastWithMessage:@"昵称不得为空!"];
		return;
    }

		
	
	commonDataOperation * operation = [[commonDataOperation alloc] init];
    operation.tag = 103;
	operation.urlStr = [serverIp stringByAppendingFormat:@"/User/UpdateUserInfo.action"];
	
//	[operation.argumentDic setObject:mpUserInfo[@"NickName"] forKey:@"NickName"];
	[operation.argumentDic setObject:mpUserInfo[@"Mobile"] forKey:@"Mobile"];
    [operation.argumentDic setObject:mpUserInfo[@"BirthDate"] forKey:@"BirthDate"];
    [operation.argumentDic setObject:mpTextField1.text forKey:@"NickName"];
 	
	operation.downInfoDelegate = self;
	[mpOperationQueue addOperation:operation];
}

- (BOOL) validateUserPhone:(NSString *)str
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^1[3|4|5|8][0-9][0-9]{8}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
	
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
		
    if(numberofMatch > 0) {
        return YES;
	}
    return NO;
}


-(void)savePhoneNumToservice
{
    if (![self validateUserPhone:mpTextField2.text]) {
        [NewItoast showItoastWithMessage:@"请输入正确的手机号码!"];
        return;
    }
    
    commonDataOperation * operation = [[commonDataOperation alloc] init];
	operation.urlStr = [serverIp stringByAppendingFormat:@"/User/UpdateUserInfo.action"];
	
	[operation.argumentDic setObject:mpUserInfo[@"NickName"] forKey:@"NickName"];
//	[operation.argumentDic setObject:mpUserInfo[@"Mobile"] forKey:@"Mobile"];
    [operation.argumentDic setObject:mpUserInfo[@"BirthDate"] forKey:@"BirthDate"];
    [operation.argumentDic setObject:mpTextField2.text forKey:@"Mobile"];
    operation.tag = 104;
	operation.downInfoDelegate = self;
	[mpOperationQueue addOperation:operation];
}

-(void)saveBirthDateToService
{
    commonDataOperation * operation = [[commonDataOperation alloc] init];
	operation.urlStr = [serverIp stringByAppendingFormat:@"/User/UpdateUserInfo.action"];
    operation.tag = 105;
	[operation.argumentDic setObject:mpUserInfo[@"NickName"] forKey:@"NickName"];
	[operation.argumentDic setObject:mpUserInfo[@"Mobile"] forKey:@"Mobile"];
//    [operation.argumentDic setObject:mpUserInfo[@"BirthDate"] forKey:@"BirthDate"];
    [operation.argumentDic setObject:mpTextField3.text forKey:@"BirthDate"];
 	
	operation.downInfoDelegate = self;
	[mpOperationQueue addOperation:operation];
}

-(void)saveDataToServiceWithImage:(UIImage *)headerImage
{
	commonDataOperation * operation = [[commonDataOperation alloc] init];
	operation.urlStr = [serverIp stringByAppendingFormat:@"/User/UploadHeadPhoto.action"];
	operation.tag = 102;
	operation.isPOST = YES;
	operation.isImage = YES;
	UIImage * newimage =[self imageWithImageSimple:headerImage scaledToSize:CGSizeMake(200, 200)];
	operation.newimage = newimage;
	operation.downInfoDelegate = self;
	[mpOperationQueue addOperation:operation];
}

-(void)initData
{
    labelNameArr = [[NSArray alloc] initWithObjects:@"科目已占学比(知识点)",@"昵称",@"手机",@"出生日期", nil];
    mpUserInfo = [[NSMutableDictionary alloc] init];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self addLeftButton];
    mpTitleLabel.text = @"用户中心";
    [self addTableView];
    [self addSubviews];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
		return 1;
	}
	else
		return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section==0) {
		return 233/2;
	}else
		return 84/2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        NSString *CellIdentifier = @"Cell";
        UserInfoOneCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell=[[UserInfoOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell->mpLabel.text = @"头像";
        [cell->mpImageView setImageWithURL:[NSURL URLWithString:mpUserInfo[@"HeadPhotoUrl"]] placeholderImage:nil];
        return cell;

    } else {
        NSString *CellIdentifier = @"Cell";
        UserInfoTwoCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell=[[UserInfoTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell->mpLabel.text = labelNameArr[indexPath.row];
        if (indexPath.row == 1) {
            cell->mpLabel2.text = mpUserInfo[@"NickName"];
        } else if (indexPath.row == 2) {
            cell->mpLabel2.text = mpUserInfo[@"Mobile"];
        } else if (indexPath.row == 3) {
            cell->mpLabel2.text = mpUserInfo[@"BirthDate"];
        } else if (indexPath.row == 0) {
            cell->mpLabel.frame = CGRectMake(10, 5, 200, 30);
            cell->mpLabel2.text = mpUserInfo[@"StudyRate"];
        }
        
        
//        /            $0 = 0x08ca5840 {"result":"1","UserID":"4f02e993-1e3f-4dc2-ac70-7cd359413578","UserRole":"0","UserName":"11111111","NickName":"Yyyyyy","Mobile":"18810082453","BirthDate":"2013-09-06","HeadPhotoUrl":"http://116.90.86.104:81/User/Ico.action?UserID=4f02e993-1e3f-4dc2-ac70-7cd359413578&635148602950000000","ExamDate":"261","StudyRate":"6%"}

        
        return cell;
    }
}


-(void)userHeaderImageSet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",
								  @"从相册选择照片",@"取消",nil];
    actionSheet.tag = 100;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag ==100){
        if (buttonIndex == 0) {
            [self selectImage:0];
        } else if (buttonIndex == 1) {
            [self selectImage:1];
        } else if (buttonIndex == 2) {
            
        }
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [mpPopover dismissPopoverAnimated:YES];
	[self saveDataToServiceWithImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [mpPopover dismissPopoverAnimated:YES];
}


- (void) selectImage:(int)type
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    mpPopover = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
    if (type == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.delegate = self;
            [self presentModalViewController:imagePickerController animated:YES];
        }else{
            [NewItoast showItoastWithMessage:@"相机不可用!"];
        }

    } else if (type == 1) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.delegate = self;
        [mpPopover presentPopoverFromRect:CGRectMake(0, 0, 300, 300) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [mpTextField1 resignFirstResponder];
    [mpTextField2 resignFirstResponder];
    [mpTextField3 resignFirstResponder];

    if (indexPath.section==0) {
		[self userHeaderImageSet];
	} else {
        if (indexPath.row == 1) {
            modifyNickNameView.hidden = NO;
            [mpBaseView bringSubviewToFront:modifyNickNameView];
            [mpTextField1 becomeFirstResponder];
        } else if (indexPath.row == 2) {
            modifyPhoneNumView.hidden = NO;
            [mpBaseView bringSubviewToFront:modifyPhoneNumView];
            [mpTextField2 becomeFirstResponder];
        } else if (indexPath.row == 3) {
            modifyBirthDayView.hidden = NO;
            [mpBaseView bringSubviewToFront:modifyBirthDayView];
            [mpTextField3 becomeFirstResponder];
        }
    }
	
	//		NickNameViewController * nvc =[[NickNameViewController alloc] init];
//		
//		nvc.delegate =self;
//		if (self.infoDict != nil) {
//			nvc.infoDic = self.infoDict;
//		}
//		
//		if (indexPath.row==0) {
//			nvc._style = nickname;
//			nvc.mpLabel=@"好名字会让更多的朋友记住你";
//			[nvc.textField setText:self.NickNameLabel.text];
//		}
//		
//		if (indexPath.row==1) {
//			nvc._style= nicktel;
//			nvc.mpLabel=@"填写你的手机号码吧";
//			[nvc.textField setText:self.NickNameLabel.text];
//		}
        
//		if (indexPath.row==2) {
//			nvc._style = nickdate;
//			nvc.mpLabel=@"填写你的生日吧";
//			[nvc.textField setText:self.NickNameLabel.text];
//		}
//		
//		[self.navigationController pushViewController:nvc animated:YES];
//        
//		[nvc release];
//		
//	}
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mpTextField1 resignFirstResponder];
    [mpTextField2 resignFirstResponder];
    [mpTextField3 resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
