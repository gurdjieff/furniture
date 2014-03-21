//
//  MultiLineTextViewController.m
//  MultiLineText
//
//  Created by Henry Yu on 3/29/09.
//  Copyright 2009 Sevenuc.com. All rights reserved.
//

#import "MultiLineTextViewController.h"

@implementation MultiLineTextViewController
@synthesize string;
@synthesize textView;
@synthesize delegate;
@synthesize infoDict = _infoDict;
@synthesize theTitle = _theTitle;


#pragma mark -

- (void)dealloc
{
    [_theTitle  release];
    [_infoDict release];
    [string release];
    [textView release];
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

    [self addSubViews];
    [self addLeftButton];
    [self sendHttpRequest];
}

- (void)addSubViews
{
    self.view.backgroundColor = [UIColor colorWithRed:190.0f/255 green:190.0f/255 blue:190.0f/255 alpha:0.6];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,44,screenWidth,screenHeight) style:UITableViewStyleGrouped];
    myTableView.backgroundView=nil;
    myTableView.backgroundColor=[UIColor whiteColor];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    myTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:myTableView];
    
//    NSUInteger firstRowIndices[] = {0,0};
//	NSIndexPath *firstRowPath = [NSIndexPath indexPathWithIndexes:firstRowIndices length:2];
//	UITableViewCell *firstCell = [myTableView cellForRowAtIndexPath:firstRowPath];
//	UITextView *firstCellTextField = nil;
//	for (UIView *oneView in firstCell.contentView.subviews)
//	{
//		if ([oneView isMemberOfClass:[UITextView class]]){
//			firstCellTextField = (UITextView *)oneView;
//		}
//	}
//    
//	[firstCellTextField becomeFirstResponder];
}


#pragma mark Tableview methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    NSString *LongTextFieldCellIdentifier = @"LongTextFieldCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LongTextFieldCellIdentifier];
    if (cell == nil) 
    {
//        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:LongTextFieldCellIdentifier] autorelease];
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LongTextFieldCellIdentifier] autorelease];
        
		UITextView *theTextView = [[UITextView alloc] initWithFrame:CGRectMake(10.0, 10.0, 280.0, 161.0)];
		theTextView.scrollEnabled = NO;
		//theTextView.textColor = [UIColor colorWithWhite:1 alpha:1];
		//theTextView.backgroundColor = [UIColor clearColor];
		//theTextView.textAlignment = UITextAlignmentLeft;
		//theTextView.font = [UIFont systemFontOfSize:13];
		
		theTextView.editable = NO;
		theTextView.text = string;
		theTextView.font = [UIFont systemFontOfSize:14.0]; 
		
		[theTextView becomeFirstResponder];		
		self.textView = theTextView;		
		[[cell contentView] addSubview:theTextView];
		[theTextView release];
    }
	
    // This doesn't work - no matter where I put it. It's almost as if this property is readonly
	   
//    self.textView.text = string;

    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Nothing for now
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 181.0;
}


#pragma mark - http



-(void)sendHttpRequest
{
    
    
    
    /*
     
     说明：获取/提交笔记。若GUID和Brief均为空，则获取CourseID知识点的笔记；若GUID不为空，Brief为空，则删除此知识点的笔记；只要Brief不为空，则记录此知识点的笔记。
     请求地址：/Course/Note.action
     请求参数
     
     
     {
     GUID = "64df1be2-9463-4bc0-bd12-7e90793f4106";
     IsRead = False;
     Name = "\U4eba\U4e8b\U6863\U6848\U5229\U7528\U7684\U65b9\U5f0f";
     }
     
     */
    
    NSString * urlString = nil;
    commonDataOperation * operation = [[commonDataOperation alloc] init];
    urlString = @"/Course/Note.action";
    operation.tag = 30007;
    operation.urlStr = [serverIp stringByAppendingString:urlString];
    operation.downInfoDelegate = self;
    operation.isPOST = YES;
    
    
    NSLog(@"%@",_infoDict);
    
    [operation.argumentDic setValue:@"" forKey:@"GUID"];
    [operation.argumentDic setValue:@"" forKey:@"Brief"];
    
    [operation.argumentDic setValue:[_infoDict objectForKey:@"GUID"]
                             forKey:@"CourseID"];


    [[Common getOperationQueue] addOperation:operation];
    [operation release];
    
    
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
        
}
-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",info);
    
    @try {
        
        
        //名家讲坛
        
        if (tag==30007)
        {
            
            if ([[info JSONValue] objectForKey:@"Brief"])
            {
                self.textView.text  = [[info JSONValue] objectForKey:@"Brief"];

            }
            

        }
        
        
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception reason]);
    }
    @finally {
        ;
    }
    
    
    [myTableView reloadData];
    
}






@end

