//
//  JiHuaTwoViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-7-22.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "JiHuaTwoViewController.h"
#import "DrawUpPlanCell.h"
#import "FirstViewController.h"
#import "LPPopup.h"
#import "XuanZeCell.h"
#define cellheight 44


@interface JiHuaTwoViewController ()

@end

@implementation JiHuaTwoViewController

@synthesize theTitle = _theTitle;

-(void)dealloc
{
    [endDateStr release];
    [startDateStr release];
    [currentDateStr release];
    [CourseIDStr release];
    [datePicker release],datePicker= nil;
    [myTableView  release],myTableView = nil;
    [leftDisArr release];
    [super dealloc];
}

- (id)init
{
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        screenWidth = [UIScreen mainScreen].bounds.size.width;
        leftDisArr =[NSArray arrayWithObjects:@"计划描述",@"选择科目",@"开始时间",@"结束时间", nil];
        [leftDisArr retain];
        CourseIDStr = [[NSMutableString alloc] init];
        startDateStr= [[NSMutableString alloc] init];
        endDateStr= [[NSMutableString alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mpTitleLabel.text = _theTitle;
    [self addLeftButton];
    [self addRightButton:@"提交"];
    [self addSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addSubviews
{
    
    CGRect rect = CGRectMake(0,44,screenWidth,screenHeight-44);

    myTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    myTableView.backgroundView=nil;
    
    UIColor * color =[UIColor colorWithRed:190.0f/255.0 green:190.0f/255.0 blue:190.0f/255.0 alpha:1];
    
    
    myTableView.backgroundColor=color;
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:myTableView];
    
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    currentDateStr = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate date]]];
    [formatter release];
    [currentDateStr retain];
    
    rect = CGRectMake(0, screenHeight, screenWidth, 166);
    datePicker=[[UIDatePicker alloc]initWithFrame:rect];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [datePicker addTarget:self
                   action:@selector(selectDate:)
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    
    color = [UIColor colorWithRed:27.0/255 green:27.0/255 blue:27.0/255 alpha:0.8];
    [[LPPopup appearance] setPopupColor:color];
    
    

}



-(void)addRightButton:(NSString *)title
{
    UIButton * lpRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth-80,3, 70, 38)];
    [lpRightBtn setTitle:title forState:UIControlStateNormal];
    [lpRightBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [lpRightBtn setBackgroundColor:[UIColor orangeColor]];
    [lpRightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mpNavitateView addSubview:lpRightBtn];
    [lpRightBtn release];
}



-(void)rightBtnClick
{
    [self reSetView];
    [self sendHttpRequest];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [leftDisArr count]+1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isGetSource)
        return cellheight;
    
    else
    {
        
        if (indexPath.row==1)
            return 1.5 * cellheight;
        else
            return cellheight;
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
    
      
    if (indexPath.row!=4)
    
    {
        
        DrawUpPlanCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell==nil) {
            
            cell=[[[DrawUpPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        
        [self configureCell:cell atIndexPath:indexPath];
        
        return cell;
    }
    else
    {
        XuanZeCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell==nil) {
            
            cell=[[[XuanZeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    }
    
   
    
}

- (void)configureCell:( DrawUpPlanCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    cell.cellStyle = indexPath.row;
    [cell.leftLabel setText:[leftDisArr objectAtIndex:indexPath.row]];
    cell.isGetSource = isGetSource;
    [cell setNeedsDisplay];
}



#pragma mark - http

-(void)sendHttpRequest
{
      
    if (isShowAlert) return;
    
    isShowAlert = YES;
    
    NSArray * tmpArr1 = nil;
    NSArray * tmpArr2 = nil;
    
    for (int i =0; i<[leftDisArr count]; ++i  )
    {
        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:i inSection:0];
        DrawUpPlanCell * cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
        
        NSString * text = cell.rightTextField.text;
        
        if ([text length]==0)
        {
            [self showAlert:@"\n请认真填写各项\n\n"];
            return;
            
        }
        
        if (indexPath.row==2) {
            NSLog(@"%@",text);
            tmpArr1 =[text componentsSeparatedByString:@"-" ];
        }
        if (indexPath.row==3) {
            
            tmpArr2 =[text componentsSeparatedByString:@"-" ];
            
            if (![self checkTime:tmpArr1 end:tmpArr2]) {
                [self showAlert:@"\n时间填写错误\n\n"];
                return;
            }
        }
    
    
       
        
    }
    
    
    NSString * urlString = nil;
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    urlString = @"/User/CreateStudyPlan.action";
    operation.tag = 30006;
   
    operation.urlStr = [serverIp stringByAppendingString:urlString];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    
    
    NSIndexPath * indexPath = nil;
    DrawUpPlanCell * cell = nil;
    
    
    
    
    
    [operation.argumentDic setValue:CourseIDStr forKey:@"CourseID"];
    
    indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
    cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
    [operation.argumentDic setValue:cell.rightTextField.text forKey:@"Brief"];
    
    indexPath =[NSIndexPath indexPathForRow:2 inSection:0];
    cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
    
    [operation.argumentDic setValue:cell.rightTextField.text forKey:@"StartDate"];
    
    indexPath =[NSIndexPath indexPathForRow:3 inSection:0];
    cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
    
    [operation.argumentDic setValue:cell.rightTextField.text forKey:@"CompleteDate"];
    
    [[Common getOperationQueue] addOperation:operation];
    [operation release];
    
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    isShowAlert = NO;
}
-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    isShowAlert = NO;
      
    [myTableView reloadData];
    
}
-(void)FreshDataWithInfo:(NSString *)info with:(NSInteger)tag
{
 
}



-(void)WillAppeare:(NSInteger)tag
{
    
    uptag = tag;

    [self reSetView];
    
    if (tag==1)
    {
        [self showLocateView];

    }
    else if (tag==2 || tag==3)
    {
       CGRect rect = CGRectMake(0,screenHeight-236, screenWidth, 216);
        [datePicker setFrame:rect];
        
        NSString * text=[[NSString stringWithFormat:@"%@",[datePicker date]] substringToIndex:10];
        
        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:uptag inSection:0];
        DrawUpPlanCell * cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
        cell.rightTextField.text = text;
        [myTableView reloadData];
    }
    
    
}


#pragma mark - UIActionSheetDelegate

- (void)showLocateView
{
    
    if (isPickerAppear) return;
    isPickerAppear = YES;
    isKnowledge = NO;
    knowledgeCount = 0;
    
    NSArray * topArr =[FirstViewController getOriginalDataAry];
    NSString * title =@"选择科目";
    TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:title
                                                             Array:topArr
                                                          delegate:self];
    [locateView showInView:self.view];
    [locateView setFrame:CGRectMake(0,screenHeight-280, screenWidth, 166)];
    [locateView release];
}

#pragma knowl



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [myTableView setFrame:CGRectMake(0,44,screenWidth,screenHeight-44)];
    
    if (buttonIndex!=0)
    {
        
        isGetSource = YES;
        
        TSLocateView * locateView = (TSLocateView *)actionSheet;
        
        if (!isKnowledge)
        {
            NSIndexPath * indexPath =[NSIndexPath indexPathForRow:1 inSection:0];
            DrawUpPlanCell * cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
            
            NSString * nameStr =[NSString stringWithFormat:@"   %@",locateView.location.name];
            cell.rightTextField.text = nameStr;
            
            
            [CourseIDStr setString:locateView.location.value];
            
            NSString * countStr =[NSString stringWithFormat:@"      %@ 个知识点",locateView.location.KnowledgeCount];
            
            knowledgeCount = [locateView.location.KnowledgeCount integerValue];
            [cell.rightLabel setText:countStr];
            
        }else
        {
            knowledgeCount = [locateView.location.name integerValue];
        }
        
        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:4 inSection:0];
        XuanZeCell * cell =(XuanZeCell *)[myTableView cellForRowAtIndexPath:indexPath];
        cell.midLabel.text = [NSString stringWithFormat:@"%d",knowledgeCount];
        
    }else{
        
        
        isGetSource = NO;
        
        
        if (!isKnowledge)
        {
            NSIndexPath * indexPath =[NSIndexPath indexPathForRow:1 inSection:0];
            DrawUpPlanCell * cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
            cell.rightTextField.text = @"";
            [CourseIDStr setString:@""];
            [cell.rightLabel setText:@""];
            
        }else
        {
            NSIndexPath * indexPath =[NSIndexPath indexPathForRow:4 inSection:0];
            XuanZeCell * cell =(XuanZeCell *)[myTableView cellForRowAtIndexPath:indexPath];
            cell.midLabel.text = @"";
        }
        
        
    }
    
    [myTableView reloadData];
    
    isKnowledge = NO;
    isPickerAppear = NO;
}

#pragma mark - datepicker

-(void)selectDate:(id)sender
{
    NSString * text=[[NSString stringWithFormat:@"%@",[sender date]] substringToIndex:10];
    
     
    NSArray * tmpArr =[currentDateStr componentsSeparatedByString:@"-"];
    NSArray * tmpArr1 =[text componentsSeparatedByString:@"-"];

    
    
    NSIndexPath * indexPath =[NSIndexPath indexPathForRow:uptag inSection:0];
    DrawUpPlanCell * cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
    
    
    
    if (uptag==2
        &&([self checkTime:tmpArr end:tmpArr1]))
    {
        cell.rightTextField.text = text;
    }
    else
    {
         [self showAlert:@"\n时间填写错误\n\n"];
    }
     
    [myTableView reloadData];

}


-(void)reSetView
{
    
    [myTableView setFrame:CGRectMake(0,44,screenWidth,screenHeight-44)];
    CGRect rect = CGRectMake(0,screenHeight, screenWidth, 216);
    [datePicker setFrame:rect];
        
    for (UIView * view in [self.view subviews])
    {
        if ([view isKindOfClass:[TSLocateView class]])
        {
            TSLocateView * ts =(TSLocateView *)view;
            [ts cancel:nil];
        }
    }
    
    for (int i =0; i<[leftDisArr count]; ++i  )
    {
        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:i inSection:0];
        DrawUpPlanCell * cell =(DrawUpPlanCell *)[myTableView cellForRowAtIndexPath:indexPath];
        [ cell.rightTextField  resignFirstResponder];
        
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self reSetView];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self reSetView];
}

#pragma mark  - Alert


-(void)showAlert:(NSString *)msg
{
    LPPopup * popup = [LPPopup popupWithText:msg];
    
    CGPoint point = self.view.center;
    
    [popup showInView:self.view
        centerAtPoint:point
             duration:kLPPopupDefaultWaitDuration
           completion:^(void){
               
               isShowAlert = NO;
               
           }];
}


-(BOOL)checkTime:(NSArray *)startTime end:(NSArray *)endTime
{
    
    for (int i =0; i<[startTime count]; i++)
    {
        NSInteger value1 =[[startTime objectAtIndex:i] integerValue];
        NSInteger value2 =[[endTime objectAtIndex:i] integerValue];
        
        if (value2>=value1)
        {
           
            while(i==[startTime count]-1)
                return YES;
            
        }
        else
        {
            return NO;
        }
        
    }
    
    return NO;
}

@end
