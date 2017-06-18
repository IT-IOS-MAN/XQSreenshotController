//
//  XQScreenshotViewController.h
//  EasyFamily
//
//  Created by mac-2016 on 17/3/29.
//  Copyright © 2017年 GXQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XQScreenshotViewController;

@protocol XQScreenshotViewControllerDelegate <NSObject>

@optional
-(void)screenshotViewController:(XQScreenshotViewController *) screenshotViewController didImage:(UIImage *) image;

@end

@interface XQScreenshotViewController : UIViewController

@property(nonatomic, retain) UIImage *image;

@property(nonatomic, weak) id<XQScreenshotViewControllerDelegate> delegate;

@end
