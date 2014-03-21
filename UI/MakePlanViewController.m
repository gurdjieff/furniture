//
//  MakePlanViewController.m
//  ExaminationIpad
//
//  Created by gurd on 13-9-2.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "MakePlanViewController.h"
#import "CustomKeyboardTwo.h"
#import "FirstViewController.h"
#import "NewItoast.h"
#import <objc/runtime.h>
#import "StudyPlanCell.h"

@interface MakePlanViewController ()
<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * mpTableViewRight;
    NSArray * mpPlanInfoAry;
    NSArray * mpPlanInfoPicAry;
    UILabel * mpDetailLabel;
}
@end

@implementation MakePlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)rightBtnClick
{
    [self submitPlanToServe];
}

-(void)addRightBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(appFrameWidth-90, 7, 80, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"yellowBack.png"] forState:UIControlStateNormal];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:btn];
}


-(void)initNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboarWilldHidden)
												 name:UIKeyboardWillHideNotification
											   object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

-(void)keyboarWilldHidden
{

}

-(void)keyboardWillShow:(NSNotification *)aNotification
{
   
}

-(void)addTableViewFootView
{
    UIView * lpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (1024-60)/2, 100)];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(150, 40, 197, 41);
    [btn setBackgroundImage:[UIImage imageNamed:@"submitBtn.png"] forState:UIControlStateNormal];
//    [btn setTitle:@"提交" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [lpView addSubview:btn];
    mpTableViewRight.tableFooterView = lpView;
}


-(void)btnClick
{
    [self submitPlanToServe];
}

-(void)addTableViews
{
    mpTableViewRight = [[UITableView alloc] initWithFrame:CGRectMake((1024-60)/4, 60, (1024-60)/2, 748-44) style:UITableViewStylePlain];
    mpTableViewRight.tag = 102;
    mpTableViewRight.showsVerticalScrollIndicator = NO;
    mpTableViewRight.delegate = self;
    mpTableViewRight.dataSource = self;
    mpTableViewRight.bounces = NO;
    mpTableViewRight.separatorColor = [UIColor clearColor];
    mpTableViewRight.backgroundColor = cellBackColor;
    [mpBaseView addSubview:mpTableViewRight];
    [self addTableViewFootView];
}

-(void)initData
{
    mpPlanInfoAry = [[NSArray alloc] initWithObjects:@"计划描述", @"选择科目",@"开始时间",@"结束时间",@"每天学习多少个知识点",nil];
    mpPlanInfoPicAry = [[NSArray alloc] initWithObjects:@"planDisplay.png", @"chapter.png",@"startTime.png",@"endtime.png",@"everyDaystudy.png",@"completeState.png",nil];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    mpTitleLabel.text = @"制定计划";
    mpBaseView.backgroundColor = cellBackColor;
    [self initNotification];
    [self addLeftButton];
//    [self addRightBtn];
    [self addTableViews];
//    [self addLabels];
	// Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mpPlanInfoAry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identify = @"cell";
    StudyPlanCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[StudyPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.row < 4) {
        cell->mpTextField.hidden = NO;
    }
    
    if (indexPath.row == 0) {
        mpTextField1 = cell->mpTextField;
        mpTextField1.tag = 100;
        mpTextField1.delegate = self;
    } else if (indexPath.row == 1) {
        mpTextField2 = cell->mpTextField;
        mpTextField2.delegate = self;

        mpTextField2.tag = 101;
    } else if (indexPath.row == 2) {
        mpTextField3 = cell->mpTextField;
        mpTextField3.delegate = self;

        mpTextField3.tag = 102;
    } else if (indexPath.row == 3) {
        mpTextField4 = cell->mpTextField;
        mpTextField4.delegate = self;

        mpTextField4.tag = 103;
    } else if (indexPath.row == 4) {
        mpDetailLabel = cell->mpLabel;
    }
    
    cell->mpImageView.image = [UIImage imageNamed:[mpPlanInfoPicAry objectAtIndex:indexPath.row]];
    cell->mpLabel.text = [mpPlanInfoAry objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mpTextField1 resignFirstResponder];
    [mpTextField2 resignFirstResponder];
    [mpTextField3 resignFirstResponder];
    [mpTextField4 resignFirstResponder];
}

-(void)addLabels
{
    mpLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(320, 240, 400, 30)];
    mpLabel1.textColor = [UIColor darkGrayColor];
    mpLabel1.backgroundColor = [UIColor clearColor];
    mpLabel1.font = [UIFont boldSystemFontOfSize:18];
    mpLabel1.textAlignment = NSTextAlignmentLeft;
    [mpBaseView addSubview:mpLabel1];
    
    mpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(170, 320+130, 400, 60)];
    mpLabel2.textColor = purpleColor;
    mpLabel2.font = [UIFont boldSystemFontOfSize:22];
    mpLabel2.backgroundColor = [UIColor clearColor];
    mpLabel2.textAlignment = NSTextAlignmentLeft;
    mpLabel2.text = @"每天学                           个知识点";
    [mpBaseView addSubview:mpLabel2];
}

-(void)addSubviews
{
    mpLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(320, 240, 400, 30)];
    mpLabel1.textColor = [UIColor darkGrayColor];
    mpLabel1.backgroundColor = [UIColor clearColor];
    mpLabel1.font = [UIFont boldSystemFontOfSize:18];
    mpLabel1.textAlignment = NSTextAlignmentLeft;
    [mpBaseView addSubview:mpLabel1];
    
    mpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(170, 320+130, 400, 60)];
    mpLabel2.textColor = purpleColor;
    mpLabel2.font = [UIFont boldSystemFontOfSize:22];
    mpLabel2.backgroundColor = [UIColor clearColor];
    mpLabel2.textAlignment = NSTextAlignmentLeft;
    mpLabel2.text = @"每天学                           个知识点";
    [mpBaseView addSubview:mpLabel2];



    NSArray * ary =[NSArray arrayWithObjects:@"计划描述",@"选择科目",@"开始时间",@"结束时间",nil];
    for (int i = 0; i < 4; i++) {
        
        UILabel * lpLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 130+i *80, 180, 60)];
        if (i < 2) {
            lpLabel.frame = CGRectMake(80, 100+i *80, 180, 60);
        } else {
            lpLabel.frame = CGRectMake(80, 130+i *80, 180, 60);
        }
        lpLabel.textColor = purpleColor;
        lpLabel.backgroundColor = [UIColor clearColor];
        lpLabel.font = [UIFont boldSystemFontOfSize:22];
        lpLabel.textAlignment = NSTextAlignmentRight;
        lpLabel.text = ary[i];
        [mpBaseView addSubview:lpLabel];
    }
        
    mpTextField1 = [[UITextField alloc] initWithFrame:CGRectMake(300, 100, 450, 60)];
    mpTextField1.backgroundColor = [UIColor whiteColor];
    mpTextField1.tag = 100;
    mpTextField1.font = [UIFont systemFontOfSize:22];
    mpTextField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    mpTextField1.textAlignment = NSTextAlignmentCenter;
    mpTextField1.delegate = self;
    [mpBaseView addSubview:mpTextField1];
    
    mpTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(300, 100+80, 450, 60)];
    mpTextField2.backgroundColor = [UIColor whiteColor];
    mpTextField2.tag = 101;
    mpTextField2.font = [UIFont systemFontOfSize:22];
    mpTextField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    mpTextField2.textAlignment = NSTextAlignmentCenter;
    mpTextField2.delegate = self;
    [mpBaseView addSubview:mpTextField2];
    
    mpTextField3 = [[UITextField alloc] initWithFrame:CGRectMake(300, 130+80*2, 450, 60)];
    mpTextField3.backgroundColor = [UIColor whiteColor];
    mpTextField3.tag = 102;
    mpTextField3.font = [UIFont systemFontOfSize:22];
    mpTextField3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    mpTextField3.textAlignment = NSTextAlignmentCenter;
    mpTextField3.delegate = self;
    [mpBaseView addSubview:mpTextField3];
    
    mpTextField4 = [[UITextField alloc] initWithFrame:CGRectMake(300, 130+80*3, 450, 60)];
    mpTextField4.backgroundColor = [UIColor whiteColor];
    mpTextField4.tag = 103;
    mpTextField4.font = [UIFont systemFontOfSize:22];
    mpTextField4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    mpTextField4.textAlignment = NSTextAlignmentCenter;
    mpTextField4.delegate = self;
    [mpBaseView addSubview:mpTextField4];
}

-(void)keyboardBtnClick
{
    [mpTextField1 resignFirstResponder];
    [mpTextField2 resignFirstResponder];
    [mpTextField3 resignFirstResponder];
    [mpTextField4 resignFirstResponder];
}

-(void)keyboardMesgChangeWithStr:(NSDictionary *)meg withTag:(int)tag
{
    if (tag == 101) {
        objc_setAssociatedObject(mpTextField2, @"mesg",meg, OBJC_ASSOCIATION_RETAIN);
        mpTextField2.text = meg[@"Name"];
        NSString * count = meg[@"KnowledgeCount"];
        if (count == nil) {
            count = @"0";;
        }
        mpDetailLabel.text = [NSString stringWithFormat:@"每天学习%@个知识点", count];
        mpLabel1.text = [NSString stringWithFormat:@"%@个知识点", count];
//        return;
    }
    
    if (tag == 102) {
        objc_setAssociatedObject(mpTextField3, @"mesg",meg, OBJC_ASSOCIATION_RETAIN);
        mpTextField3.text = meg[@"mesg"];
    } else if (tag == 103) {
        objc_setAssociatedObject(mpTextField4, @"mesg",meg, OBJC_ASSOCIATION_RETAIN);
        mpTextField4.text = meg[@"mesg"];
    }
    
    if (mpTextField3.text.length > 0 && mpTextField4.text.length > 0 && mpTextField2.text.length > 0) {
        NSDictionary* mesg1 = objc_getAssociatedObject(mpTextField3, @"mesg");
        NSDictionary* mesg2 = objc_getAssociatedObject(mpTextField4, @"mesg");
        NSDictionary* mesg3 = objc_getAssociatedObject(mpTextField2, @"mesg");
        
        int count = [mesg3[@"KnowledgeCount"] intValue];

        NSDate * date1 = mesg1[@"data"];
        NSDate * date2 = mesg2[@"data"];
        float time = [date2 timeIntervalSinceDate:date1]+1;
        if (time > 0) {
            int days = time/3600/24+1;
            NSString * info = [NSString stringWithFormat:@"每天学    %i   个知识点", (int)count/days];
            mpDetailLabel.text = info;
        } else {
            mpDetailLabel.text = @"每天学         个知识点";
//            [NewItoast showItoastWithMessage:@"结束时间不能小于开始时间"];
        }
    }
}

-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    if (![info ifInvolveStr:@"\"result\":\"1\""]) {
        return;
    }
    if (tag == 100) {
        [iLoadAnimationView showItoastMesage:@"提交成功"];
        [mpTextField1 resignFirstResponder];
        [mpTextField2 resignFirstResponder];
        [mpTextField3 resignFirstResponder];
        [mpTextField4 resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)submitPlanToServe
{
    if (mpTextField1.text.length == 0 || mpTextField2.text.length == 0
        || mpTextField3.text.length == 0 || mpTextField4.text.length == 0) {
        [NewItoast showItoastWithMessage:@"请认真填写各项"];
        return;
    }
    
    
    NSDictionary* mesg1 = objc_getAssociatedObject(mpTextField3, @"mesg");
    NSDictionary* mesg2 = objc_getAssociatedObject(mpTextField4, @"mesg");
    
    
    
    NSDate * date1 = mesg1[@"data"];
    NSDate * date2 = mesg2[@"data"];
    if ([date1 compare:date2] != NSOrderedAscending) {
        [NewItoast showItoastWithMessage:@"结束时间需要大于开始时间"];
        return;
    }

    
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    NSString * urlString  = @"/User/CreateStudyPlan.action";
    operation.tag = 100;
    operation.urlStr = [serverIp stringByAppendingString:urlString];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
     
       
    NSDictionary* mesg = objc_getAssociatedObject(mpTextField2, @"mesg");
    
    [operation.argumentDic setValue:mesg[@"GUID"] forKey:@"CourseID"];
    [operation.argumentDic setValue:mpTextField1.text  forKey:@"Brief"];
    [operation.argumentDic setValue:mpTextField3.text  forKey:@"StartDate"];
    [operation.argumentDic setValue:mpTextField4.text forKey:@"CompleteDate"];
    [mpOperationQueue addOperation:operation];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 100) {
        
    } else if (textField.tag == 101) {
        CustomKeyboardTwo  * keyBoardView = [[CustomKeyboardTwo alloc] init];
        NSArray * ary = [NSArray arrayWithArray:[FirstViewController getOriginalDataAry]];
        [keyBoardView.dataAry setArray:ary];
        keyBoardView.tag = 101;
        textField.inputView = keyBoardView;
        keyBoardView.delegate = self;
        [textField reloadInputViews];
        [keyBoardView pickerviewDidSelect];
    } else if (textField.tag == 102) {
        CustomKeyboardOne  * keyBoardView = [[CustomKeyboardOne alloc] init];
        keyBoardView.tag = 102;
        textField.inputView = keyBoardView;
        keyBoardView.delegate = self;
        [keyBoardView datePickerChange];
        [textField reloadInputViews];

    } else if (textField.tag == 103) {
        CustomKeyboardOne  * keyBoardView = [[CustomKeyboardOne alloc] init];
        NSDate * date = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
        [keyBoardView setMinimumDate:date];
        keyBoardView.tag = 103;
        textField.inputView = keyBoardView;
        keyBoardView.delegate = self;
        [keyBoardView datePickerChange];
        [textField reloadInputViews];
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mpTextField1 resignFirstResponder];
    [mpTextField2 resignFirstResponder];
    [mpTextField3 resignFirstResponder];
    [mpTextField4 resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
