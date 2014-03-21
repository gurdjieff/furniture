//
//  SecondTwoViewController.h
//  Examination
//
//  Created by Zhang Bo on 13-7-13.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "ThirdOneViewController.h"
#import "ThirdTwoViewController.h"
#import "ThirdViewController.h"
#import "FirstViewCommentCtr.h"

#define kNum 2
#define kCell_Items_Width 135
#define kCell_Items_Height 80


@implementation ThirdOneViewController
@synthesize helper;

-(void)dealloc
{
    [tbView release];
    [data release];
    [helper release];
    [super dealloc];
}


- (void) initData
{
    data = [[NSArray alloc] initWithObjects:
            @"学习计划",
            @"书签笔记",
            @"名家讲堂",
            @"学习交流",
            @"学校信息",nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if(!tbView){
        tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        tbView.delegate = self;
        tbView.dataSource = self;
        tbView.separatorColor = [UIColor clearColor];
        tbView.backgroundColor = [UIColor clearColor];
        tbView.scrollEnabled = NO;
    }
    [self.view addSubview:tbView];
    [self initData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = ([data count]+kNum-1)/kNum;
    if (bLandScape) {
        count = ([data count]+kNum)/(kNum+1);
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"etuancell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }

    CGFloat x = 15;
    CGFloat y = 5;
    
    NSInteger nowNum = kNum;
    if (bLandScape) {
        nowNum += 1;
    }
    
    NSInteger row = indexPath.row * nowNum;
    
    for (int i = 0; i<nowNum; ++i) {

        if (row >= [data count]) {
            break;
        }
        
        UIImageView *bookView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y-10, kCell_Items_Width, kCell_Items_Height)];
        [bookView setBackgroundColor:[UIColor greenColor]];
        
        bookView.image = [UIImage imageNamed:[NSString stringWithFormat:@"yingyong0%d",row+1]];
        [cell.contentView addSubview:bookView];
        [bookView release];
        
        UILabel *timulabel =[[UILabel alloc] init];
        [timulabel setFont:[UIFont boldSystemFontOfSize:22]];
        [timulabel setTextColor:[UIColor blackColor]];
        [timulabel setBackgroundColor:[UIColor clearColor]];
        [timulabel setTextAlignment:UITextAlignmentCenter];
        [timulabel setFrame:CGRectMake(x, y+kCell_Items_Height -10, kCell_Items_Width, 30)];
        [timulabel setText:[data objectAtIndex:row]];
        [[cell contentView] addSubview:timulabel];
        [timulabel release];


        UIButton *bookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bookButton setBackgroundColor:[UIColor clearColor]];

        bookButton.frame = CGRectMake(x, y-10, kCell_Items_Width, kCell_Items_Height+27);
        bookButton.tag = row;
        [bookButton addTarget:self action:@selector(testButton:) forControlEvents:UIControlEventTouchUpInside];

        
        [cell.contentView addSubview:bookButton];
        
        x += (20+kCell_Items_Width);
        ++row;
    }
    
            
	return cell;
}

- (void) testButton:(id)sender{
    
    UIButton * btn =(UIButton *)sender;
    int index = btn.tag;
    
    
    
    if (index==3)
    {
         FirstViewCommentCtr * lpViewCtr = [[FirstViewCommentCtr alloc] init];
        lpViewCtr.hidesBottomBarWhenPushed = YES;
        lpViewCtr.theTitle = @"学习交流";
        lpViewCtr.ctrStyle = jiaoliu;
        ThirdViewController * v = (ThirdViewController *)helper;
        [v.navigationController pushViewController:lpViewCtr animated:YES];
        [lpViewCtr release];
        
        
        return;
    }
    
    
    
    
    
    ThirdTwoViewController  * vc =[[ThirdTwoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    
    if (index==0)
    {
        vc.theTitle =@"计划列表";
        vc.LS = xuexijihua;
    }
    
    
    else if (index==1)
    {
        vc.theTitle = @"书签笔记";
        vc.LS = shuqianbiji;
        
    }
    
    else if (index==2)
    {
        
        vc.theTitle =@"名家讲堂";
        vc.LS = mingjiajiangtang;
    }
    
    

    
    else  {
        vc.theTitle = @"学校信息";
        vc.LS = xuexiaoxinxi;

    }
    
    ThirdViewController * v = (ThirdViewController *)helper;
    [v.navigationController pushViewController:vc animated:YES];
    [vc release];
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 110;
	return height;
}

#pragma mark -
#pragma mark  rotate
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	bLandScape = NO;
	if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
		bLandScape = YES;
	}
	
	return YES;
}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || 
	   interfaceOrientation == UIInterfaceOrientationLandscapeRight)
	{
		bLandScape = YES;
	}else {
		bLandScape = NO;
	}
	tbView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [tbView reloadData];
}

@end
