//
//  JiHuaOneViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "JiHuaOneViewController.h"

@interface JiHuaOneViewController ()

@end

@implementation JiHuaOneViewController
@synthesize theTitle = _theTitle;
@synthesize infoDic = _infoDic;


-(void)dealloc
{
    [_infoDic release];
    [_theTitle release];
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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mpTitleLabel.text = _theTitle;
    [self addLeftButton];
    [self addSubview];
}


-(void)addSubview
{
    
    
    UIImageView * imageview =[[UIImageView alloc] init];
    [imageview setBackgroundColor:[UIColor colorWithRed:220.0f/255 green:220.0f/255 blue:220.0f/255 alpha:1]];
    [imageview setFrame:CGRectMake(10, 10+44, screenWidth-20, 220)];
    [self.view addSubview:imageview];
    [imageview release];
    
    
    for (int i=0; i<6; ++i) {
        
       UILabel * timelabel =[[UILabel alloc] init];
        [timelabel setFont:[UIFont systemFontOfSize:18]];
        [timelabel setTextColor:[UIColor blackColor]];
        [timelabel setBackgroundColor:[UIColor clearColor]];
        [timelabel setTextAlignment:UITextAlignmentRight];
        
        
        if (i==0)
            timelabel.text =@"计划描述:";
        if (i==1)
            timelabel.text =@"选择科目:";
        if (i==2)
            timelabel.text =@"开始时间:";
        if (i==3)
            timelabel.text =@"结束时间:";
        if (i==4)
            timelabel.text =@"总知识点数量:";
        if (i==5)
            timelabel.text =@"每天知识点数量:";
        
        [timelabel setFrame:CGRectMake(5, 10+44+5 +35*i, 140, 30)];
        [self.view  addSubview:timelabel];
        [timelabel release];

        
    }
    
    for (int i=0; i<6; ++i) {
        
        UILabel * timelabel =[[UILabel alloc] init];
        [timelabel setFont:[UIFont systemFontOfSize:18]];
        [timelabel setTextColor:[UIColor blackColor]];
        [timelabel setBackgroundColor:[UIColor clearColor]];
        [timelabel setTextAlignment:UITextAlignmentLeft];
             
        
        if (i==0)
            timelabel.text =[_infoDic objectForKey:@"Brief"];
        if (i==1)
            timelabel.text =[_infoDic objectForKey:@"Name"];
        if (i==2)
        {
            NSArray * tmpArr =[[_infoDic objectForKey:@"StartDate"] componentsSeparatedByString:@" "];
            timelabel.text =[tmpArr objectAtIndex:0];
        }
        if (i==3)
        {
            NSArray * tmpArr =[[_infoDic objectForKey:@"CompleteDate"] componentsSeparatedByString:@" "];
            timelabel.text =[tmpArr objectAtIndex:0];
        }
        if (i==4)
            timelabel.text =[_infoDic objectForKey:@"Count"];
        if (i==5)
            timelabel.text =@"";
        
        
        
        [timelabel setFrame:CGRectMake(150, 10+44+5 +35*i, 170, 30)];
        [self.view  addSubview:timelabel];
        [timelabel release];
        
    }
    
    
    
    
    UILabel * timelabel =[[UILabel alloc] init];
    [timelabel setFont:[UIFont systemFontOfSize:18]];
    [timelabel setTextColor:[UIColor blackColor]];
    [timelabel setBackgroundColor:[UIColor clearColor]];
    [timelabel setTextAlignment:UITextAlignmentLeft];
    
    [timelabel setFrame:CGRectMake(10, 280, screenWidth-20, 30)];
    [timelabel setText:@""];
    [self.view  addSubview:timelabel];
    [timelabel release];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
