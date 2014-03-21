//
//  MultiLineTextViewController.h
//  MultiLineText
//
//  Created by Henry Yu on 3/29/09.
//  Copyright 2009 Sevenuc.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol MultiLineTextViewControllerDelegate <NSObject>
@optional
- (void)takeNewString:(NSString *)newValue;
- (UINavigationController *)navController;  //Return the navigation controller
@end

@interface MultiLineTextViewController :BaseViewController
<UITableViewDataSource,UITableViewDelegate,downLoadDelegate>
{
    float screenWidth;
    float screenHeight;

    NSString    *string;
    UITextView  *textView;    
    id<MultiLineTextViewControllerDelegate>  delegate;
    UITableView * myTableView;

}
@property(nonatomic,retain) NSString * theTitle;


@property (nonatomic, retain) NSString * string;
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, assign)  id <MultiLineTextViewControllerDelegate> delegate;

@property (nonatomic,retain) NSDictionary * infoDict;

//- (void)cancel;
//- (void)save;

@end

