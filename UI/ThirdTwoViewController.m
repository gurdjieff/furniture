//
//  SecondTwoViewController.m
//  Examination
//
//  Created by Zhang Bo on 13-7-3.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "ThirdTwoViewController.h"
#import "BaiKuangCell.h"
#import "JiaoLiuCell.h"
#import "JiHuaOneViewController.h"
#import "WebViewController.h"
#import "JiHuaTwoViewController.h"
#import "FirstViewController.h"
#import "MultiLineTextViewController.h"
#import "JiaoLiuViewController.h"

#define cellHight 44

@interface ThirdTwoViewController ()


@end

@implementation ThirdTwoViewController
@synthesize theTitle = _theTitle;
@synthesize LS;
@synthesize infoDict = _infoDict;

- (void)dealloc
{
    [_infoDict release];
    [CourseIDStr release];
    [theTitle release];

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
        cellSourceArr = [[NSMutableArray alloc] init];
        screenHeight = [UIScreen mainScreen].bounds.size.height;
        screenWidth = [UIScreen mainScreen].bounds.size.width;
        CourseIDStr = [[NSMutableString alloc] init];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    mpTitleLabel.text = _theTitle;
    [self addLeftButton];
    
    [self addSubViews];
    
    if (LS==xuexijihua
        || LS ==xuexijiaoliu) {
        
        NSString * title = nil;
        if (LS==xuexijihua) {
            title = @"制定计划";
        }
        if (LS==xuexijiaoliu) {
            title= @"交流";
        }
        [self addRightButton:title];
    }
    
       [self sendHttpRequest];

}




- (void)addSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,44,screenWidth,screenHeight) style:UITableViewStylePlain];
    myTableView.backgroundView=nil;
    myTableView.backgroundColor=[UIColor whiteColor];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    
    if (LS ==mingjiajiangtang
        || LS == xuexiaoxinxi) {
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else{
        myTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

    }
    [self.view addSubview:myTableView];
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
    if (LS ==xuexijihua) {

        JiHuaTwoViewController  * vc =[[JiHuaTwoViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.theTitle = @"制定计划";
        
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        
    }
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
 
    return [cellSourceArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (LS==mingjiajiangtang
        ||LS==xuexiaoxinxi)
    {
        return 20+cellHight;
    }
    
    else if (LS ==xuexijiaoliu)
    {
        return 2 * cellHight;
    }
    else
        return cellHight;
}



- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
    
    
    //名家讲坛
    if (LS ==mingjiajiangtang
        || LS == xuexiaoxinxi) {
        
        BaiKuangCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            
            cell=[[[BaiKuangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        

        
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
        
        cell.timulabel.text =[dic objectForKey:@"Name"];
        
        return cell;
        
        
    }
    

    
    //学习计划
    else if (LS == xuexijihua)
    {
        
        UITableViewCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            
            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor =[UIColor clearColor];
            cell.textLabel.backgroundColor =[UIColor clearColor];
            cell.textLabel.textAlignment = UITextAlignmentLeft;
            cell.backgroundColor =[UIColor groupTableViewBackgroundColor];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font =[UIFont systemFontOfSize:16];
            
        }
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
        
        cell.textLabel.text =[dic objectForKey:@"Name"];
        
        
        return cell;
    }
    
    
    //书签列表1
    
    
    if (LS==shuqianbiji)
    {
        
        UITableViewCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            
            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor =[UIColor clearColor];
            cell.textLabel.backgroundColor =[UIColor clearColor];
            cell.textLabel.textAlignment = UITextAlignmentLeft;
            cell.backgroundColor =[UIColor groupTableViewBackgroundColor];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font =[UIFont systemFontOfSize:16];
            
        }

        
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
        cell.textLabel.text =[dic objectForKey:@"Name"];;
        return cell;


    }
    

    
    //学习交流列表
    
    if (LS ==xuexijiaoliu) {
        
        
        JiaoLiuCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            
            cell=[[[JiaoLiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        
        
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
        
        cell.timulabel.text =[dic objectForKey:@"Brief"];
        cell.namelabel.text=[[dic objectForKey:@"User"]objectForKey:@"UserName"];
        
        cell.timelabel.text =[dic objectForKey:@"PostDate"];
        
        return cell;

    }

    
    
    if ( LS ==xuexiaoliebiao) {
        
        BaiKuangCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            
            cell=[[[BaiKuangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        
        
        cell.timulabel.text =[[cellSourceArr objectAtIndex:indexPath.row] objectForKey:@"a"];
        
        
        return cell;

        
    }
    
    
    
    else
    {
        UITableViewCell *cell = [tableViews dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            
            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor =[UIColor clearColor];
            cell.textLabel.backgroundColor =[UIColor clearColor];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.backgroundColor =[UIColor groupTableViewBackgroundColor];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font =[UIFont systemFontOfSize:16];

        }
        
    
        cell.textLabel.text =[[cellSourceArr objectAtIndex:indexPath.row] objectForKey:@"a"];
        
        
        return cell;

    }
    
}




-(void)tableView:(UITableView *)tableViews didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (LS==mingjiajiangtang)
    {
        
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
        WebViewController  * vc =[[WebViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.theTitle =[dic objectForKey:@"Name"];
        vc.requestDic = dic;
        vc.LS = LS;
        
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        
    }

    else if (LS ==xuexiaoxinxi)
    {
        
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
        WebViewController  * vc =[[WebViewController alloc] init];
        vc.requestDic = dic;
        vc.hidesBottomBarWhenPushed = YES;
        vc.theTitle =[dic objectForKey:@"Name"];
        vc.LS = LS;
        
        
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        
     }
    
    
    
    if (LS==xuexijihua) {
        
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];

        JiHuaOneViewController  * vc =[[JiHuaOneViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.theTitle =[dic objectForKey:@"Name"];
        vc.infoDic = dic;
        
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }
    
    
//    if (LS == shuqianbiji) {
//        
//        NSArray * topArr =[FirstViewController getOriginalDataAry];
//        NSDictionary * dic =[topArr objectAtIndex:indexPath.row];
//        
//        ThirdTwoViewController  * vc =[[ThirdTwoViewController alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.theTitle = [dic objectForKey:@"Name"];
//        vc.infoDict = dic;
//        vc.LS = shuqianliebiao;
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        [vc release];
//    }
//    
    
    
    if (LS== shuqianbiji) {
        
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];



    	MultiLineTextViewController *controller =
        [[MultiLineTextViewController alloc] init];
//        controller.delegate = self;
        controller.theTitle = [dic objectForKey:@"Name"];
        controller.infoDict = dic;
        
        
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    
    }
    
    if (LS ==xuexijiaoliu) {
        
        NSDictionary * dic =[cellSourceArr objectAtIndex:indexPath.row];
        
        JiaoLiuViewController  * vc =[[JiaoLiuViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
       
        vc.theTitle = @"学习交流";
        vc.requestDic = dic;
        
        
        
        vc.LS = LS;
        
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    
    }
    
    
   
    
}




-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (LS ==xuexijihua)
        return YES;
    else
        return NO;
}


-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"删除";
}

//编辑tableview
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    @try {
        
        //如果编辑style==删除style
        if (editingStyle==UITableViewCellEditingStyleDelete)
        {

    
            if (LS == xuexijihua)
            {
                
                LS = xuexijihuabianji;
                deleteRow = indexPath.row;
                CourseIDStr =[[cellSourceArr objectAtIndex:indexPath.row] objectForKey:@"CourseID"];
                [self sendHttpRequest];
            }
        

            
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",[exception reason]);
    }
    @finally {
        ;
    }
    
    
    
    
}




#pragma mark - http



-(void)sendHttpRequest
{

    
    
    /*
     
     8.1名家讲堂列表
     说明：获得名教师列表。
     请求地址：/Application/TeacherList.action
     
     
     */
    
   if (LS == mingjiajiangtang)
    {
        NSString * urlString = nil;
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        urlString = @"/Application/TeacherList.action";
        operation.tag = 30001;
        operation.urlStr = [serverIp stringByAppendingString:urlString];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [[Common getOperationQueue] addOperation:operation];
        [operation release];
    }
    
    /*
     
     8.3学校列表
     说明：获得学校列表。
     请求地址：/Application/SchoolList.action
     
     */
    
    
    
    else if (LS ==xuexiaoxinxi)
    {
        NSString * urlString = nil;
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        urlString = @"/Application/SchoolList.action";
        operation.tag = 30003;
        operation.urlStr = [serverIp stringByAppendingString:urlString];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [[Common getOperationQueue] addOperation:operation];
        [operation release];

    }
    
    /*
     
     5.5学习计划列表
     说明：
     请求地址：/User/StudyPlanList.action
     
     */
    
    else if (LS ==xuexijihua)
    {
        
        NSString * urlString = nil;
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        urlString = @"/User/StudyPlanList.action";
        operation.tag = 30005;
        operation.urlStr = [serverIp stringByAppendingString:urlString];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [[Common getOperationQueue] addOperation:operation];
        [operation release];
    }
    
    /*
     
     5.7删除学习计划
     说明：
     请求地址：/User/DeleteStudyPlan.action
     
     */

    else if (LS == xuexijihuabianji)
    {
        NSString * urlString = nil;
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        urlString = @"/User/DeleteStudyPlan.action";
        operation.tag = 30006;
        operation.urlStr = [serverIp stringByAppendingString:urlString];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [operation.argumentDic setValue:CourseIDStr forKey:@"CourseID"];
        [[Common getOperationQueue] addOperation:operation];
        [operation release];
    }
    
    else  if (LS ==shuqianliebiao)
    {

        NSString * urlString = nil;
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        urlString = @"/Course/KnowledgeList.action";
        operation.tag = 30007;
        operation.urlStr = [serverIp stringByAppendingString:urlString];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [operation.argumentDic setValue:[_infoDict objectForKey:@"GUID"]
                                 forKey:@"ParentID"];
        [[Common getOperationQueue] addOperation:operation];
        [operation release];

    }
    
    /*
     
     
     6.7知识点评论列表/学习交流帖子列表（分页）
     说明：
     请求地址：/Course/RemarkList.action
     是
     知识点编码(学习交流列表时留空)
     

     
     */
    
    else if (LS == xuexijiaoliu)
    {
        NSString * urlString = nil;
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        urlString = @"/Course/RemarkList.action";
        operation.tag = 30009;
        operation.urlStr = [serverIp stringByAppendingString:urlString];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [operation.argumentDic setValue:@""
                                 forKey:@"CourseID"];
        [[Common getOperationQueue] addOperation:operation];
        [operation release];

    }
    
    else if(LS ==shuqianbiji)
    {
        NSString * urlString = nil;
        commonDataOperation * operation = [[commonDataOperation alloc] init];
        urlString = @"/Course/NoteList.action";
        operation.tag = 30011;
        operation.urlStr = [serverIp stringByAppendingString:urlString];
        operation.downInfoDelegate = self;
        operation.isPOST = YES;
        [[Common getOperationQueue] addOperation:operation];
        [operation release];
        
    }
        else;
    

    
}

-(void)requestFailed:(NSString *)info withTag:(NSInteger)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",info);
    
    if (tag == 30006)
    {
        LS = xuexijihua;
    }
    
}
-(void)downLoadWithInfo:(NSString *)info with:(NSInteger)tag
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",info);
    
    @try {
        
        
        //名家讲坛
        
        if (tag==30001)
        {
            
            [cellSourceArr removeAllObjects];
            
            if (info !=nil )
            {
                NSArray * list =[[info JSONValue] objectForKey:@"list"];
                if (list != nil && [list count]!=0)
                {
                    for (NSDictionary * dic  in list)
                    {
                        [cellSourceArr addObject:dic];
                    }
                }
            }
        }
        
        //学校列表
        
        
       else if (tag ==30003)
        {
            [cellSourceArr removeAllObjects];
            
            if (info !=nil )
            {
                NSArray * list =[[info JSONValue] objectForKey:@"list"];
                if (list != nil && [list count]!=0)
                {
                    for (NSDictionary * dic  in list)
                    {
                        [cellSourceArr addObject:dic];
                    }
                }
            }

        }
        
       // 学习计划列表
       else if (tag ==30005)
       {
           [cellSourceArr removeAllObjects];
           
           if (info !=nil )
           {
               NSArray * list =[[info JSONValue] objectForKey:@"list"];
               if (list != nil && [list count]!=0)
               {
                   for (NSDictionary * dic  in list)
                   {
                       [cellSourceArr addObject:dic];
                   }
               }
           }

       }
        
        
        else if (tag==30006)
        {
            
            NSLog(@"%@",info);
            
            NSIndexPath *  indexPath =[NSIndexPath indexPathForRow:deleteRow inSection:0];
            
            [myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                               withRowAnimation:UITableViewRowAnimationRight];
            
            LS = xuexijihua;
        }
        
        
        else if(tag==30007)
        {
            
            [cellSourceArr removeAllObjects];
            
            if (info !=nil )
            {
                NSArray * list =[[info JSONValue] objectForKey:@"list"];
                if (list != nil && [list count]!=0)
                {
                    for (NSDictionary * dic  in list)
                    {
                        [cellSourceArr addObject:dic];
                    }
                }
            }

        }
        
        
        else if (tag==30009)
        {

            [cellSourceArr removeAllObjects];
            
            if (info !=nil )
            {
                NSArray * list =[[info JSONValue] objectForKey:@"list"];
                if (list != nil && [list count]!=0)
                {
                    for (NSDictionary * dic  in list)
                    {
                        [cellSourceArr addObject:dic];
                    }
                }
            }

        }
        
        else if (tag==30011)
        {
            
            [cellSourceArr removeAllObjects];
            
            if (info !=nil )
            {
                NSArray * list =[[info JSONValue] objectForKey:@"list"];
                if (list != nil && [list count]!=0)
                {
                    for (NSDictionary * dic  in list)
                    {
                        [cellSourceArr addObject:dic];
                    }
                }
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
