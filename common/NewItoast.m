//
//  NewItoast.m
//  Examination
//
//  Created by gurdjieff on 13-8-12.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "NewItoast.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomTabBarViewCtr.h"
#import "Common.h"
#import "BaseViewController.h"

@implementation NewItoast
@synthesize message = mpMessage;

-(void)addLabel
{
    UIFont *font = [UIFont boldSystemFontOfSize:16];
    mpLabel = [[UILabel alloc] init];
    mpLabel.backgroundColor = [UIColor clearColor];
	mpLabel.textColor = [UIColor whiteColor];
	mpLabel.font = font;
    mpLabel.textAlignment = NSTextAlignmentCenter;
	mpLabel.text = mpMessage;
	mpLabel.numberOfLines = 0;
    [self addSubview:mpLabel];
}

-(id)init
{
    if ((self = [super init])) {
        [self addTarget:self action:@selector(hideToast) forControlEvents:UIControlEventTouchDown];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        self.layer.cornerRadius = 5;
        self.alpha = 0.0;
        [self addLabel];
    }
    return self;
}

+(NewItoast *)sharedNewItoast
{
    static NewItoast * instance = nil;
    if (instance == nil) {
        instance = [[NewItoast alloc] init];
    }
    return instance;
}

-(void)show
{
    CGSize textSize;
    UIFont *font = [UIFont systemFontOfSize:20];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:20]};
    
    int version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        textSize = [mpMessage boundingRectWithSize:CGSizeMake(100, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    } else {
    	textSize = [mpMessage sizeWithFont:font constrainedToSize:CGSizeMake(280, 60)];
    }
    
    
	
    mpLabel.frame = CGRectMake(0, 0, textSize.width + 5, textSize.height + 5);
	mpLabel.text = mpMessage;
	
	self.frame = CGRectMake(0, 0, textSize.width + 50, textSize.height + 50);
	self.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
	
    CGPoint point = CGPointMake((appFrameWidth)/2, appFrameHeigh/2 - 60);

    self.center = point;
    mpLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self performSelector:@selector(hideToast) withObject:nil afterDelay:1.0];
		
}

- (void) hideToast
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL f) {
        
    }];
}

+(void)showItoastWithMessage:(NSString *)message
{
    NewItoast * toast = [NewItoast sharedNewItoast];
    if ([toast superview]) {
        [toast removeFromSuperview];
    }
    toast.alpha = 1.0;
    UIView * lpView = [CustomTabBarViewCtr shareTabBarViewCtr].view;
    [lpView addSubview:toast];   
    toast.message = message;
    [toast show];
}

+(void)showItoastWithMessage:(NSString *)message inView:(UIView *)apView
{
    NewItoast * toast = [NewItoast sharedNewItoast];
    if ([toast superview]) {
        [toast removeFromSuperview];
    }
    toast.alpha = 1.0;
    [apView addSubview:toast];
    toast.message = message;
    [toast show];
}




-(void)dealloc
{
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
