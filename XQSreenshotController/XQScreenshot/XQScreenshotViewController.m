//
//  XQScreenshotViewController.m
//  EasyFamily
//
//  Created by mac-2016 on 17/3/29.
//  Copyright © 2017年 GXQ. All rights reserved.
//

#import "XQScreenshotViewController.h"

@interface XQScreenshotViewController () <UIScrollViewDelegate>

@property(nonatomic, weak) UIView *screenshotView;

@property(nonatomic, weak) UIImageView *iocnView;

@property(nonatomic, weak) UIScrollView *scrollView;

@end

@implementation XQScreenshotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"移动和缩放";
    

    [self setupScrollView];
    [self setupIconView];
    [self setupScreenshotView];
    [self setupMaskView];
    
    [self toolView];
    
    [self setupBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupIconView
{
    CGFloat screenshotViewWH = self.view.frame.size.width * 0.7;
    
    NSInteger scale = [UIScreen mainScreen].scale;
    
    CGFloat iocnViewW = self.image.size.width / scale;
    CGFloat iocnViewH = self.image.size.height / scale;
    
    if (iocnViewW > self.view.frame.size.width) {
        iocnViewH = self.view.frame.size.width / iocnViewW * iocnViewH;
        iocnViewW = self.view.frame.size.width;
    }
    
    if (iocnViewW < screenshotViewWH) {
        iocnViewH = screenshotViewWH / iocnViewW * iocnViewH;
        iocnViewW = screenshotViewWH;
    }
    if (iocnViewH < screenshotViewWH) {
        iocnViewW = screenshotViewWH / iocnViewH * iocnViewW;
        iocnViewH = screenshotViewWH;
    }
    
    UIImageView *iocnView = [[UIImageView alloc] initWithImage:self.image];
    iocnView.frame = CGRectMake(0, 0, iocnViewW, iocnViewH);
    [self.scrollView addSubview:iocnView];
    self.iocnView = iocnView;
    
    // scrollView set
    self.scrollView.contentSize = iocnView.frame.size;
    
    CGFloat InsetTop = (self.view.frame.size.height - screenshotViewWH) * 0.5;
    if (!self.navigationController.navigationBar.hidden &&  [UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        InsetTop -= self.navigationController.navigationBar.frame.size.height;
    }
    if (![UIApplication sharedApplication].statusBarHidden) {
        InsetTop -=  [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    CGFloat InsetBottom = (self.view.frame.size.height - screenshotViewWH) * 0.5;
    CGFloat InsetLeftRight = (self.view.frame.size.width - screenshotViewWH) * 0.5;
    self.scrollView.contentInset = UIEdgeInsetsMake(InsetTop, InsetLeftRight, InsetBottom, InsetLeftRight);
    
    CGFloat minimumZoomScale = 1;
    
    if (iocnViewW > screenshotViewWH && iocnViewH > screenshotViewWH) {
        
        minimumZoomScale = screenshotViewWH / MIN(iocnViewW, iocnViewH);
        
    }
    
    self.scrollView.minimumZoomScale = minimumZoomScale;
}

- (void) setupBackButton
{
    if (self.navigationController.navigationBar.hidden) {
        UIButton *backButton = [[UIButton alloc] init];
        
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(backButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        backButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:backButton];
        
        [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:backButton
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1
                                                                  constant:16],
                                    
                                    [NSLayoutConstraint constraintWithItem:backButton
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1
                                                                  constant:10],
                                    
                                    [NSLayoutConstraint constraintWithItem:backButton
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeWidth
                                                                multiplier:1
                                                                  constant:60],
                                    
                                    [NSLayoutConstraint constraintWithItem:backButton
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeHeight
                                                                multiplier:1
                                                                  constant:44]
                                    ]];

        
    }
}

-(void)setupScrollView
{
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.bouncesZoom = NO;
    scrollView.minimumZoomScale = 0.7;
    scrollView.maximumZoomScale = 3.0;
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:scrollView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:scrollView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:scrollView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:scrollView
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:0]
                                ]];
    
    self.scrollView = scrollView;
}

-(void)setupScreenshotView
{
    
    UIView *screenshotView = [[UIView alloc] init];
    screenshotView.layer.borderWidth = 1;
    screenshotView.layer.borderColor = [UIColor whiteColor].CGColor;
    screenshotView.layer.cornerRadius = 3;
    screenshotView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:screenshotView];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:screenshotView
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:0.7
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:screenshotView
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:0.7
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:screenshotView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:screenshotView
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1
                                                              constant:0]
                                ]];
    
    
    self.screenshotView = screenshotView;
}

-(void)setupMaskView
{
    
    // top
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:topView];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:topView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:topView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.screenshotView
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:topView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:topView
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:0]
                                ]];
    
    // left
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    leftView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:leftView];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:leftView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:topView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:leftView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:leftView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:leftView
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.screenshotView
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1
                                                              constant:0]
                                ]];
    
    // bottom
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:bottomView];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:bottomView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.screenshotView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:bottomView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:bottomView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:leftView
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:bottomView
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:0]
                                ]];
    
    // right
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    rightView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:rightView];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:rightView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:topView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:rightView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:bottomView
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:rightView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.screenshotView
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:rightView
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:0]
                                ]];
}

-(void)toolView
{
    
    CGFloat toolViewH = 50;
    
    UIView *toolView = [[UIView alloc] init];
    toolView.backgroundColor = [UIColor whiteColor];
    toolView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:toolView];
    
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:toolView
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:1
                                                              constant:toolViewH],
                                
                                [NSLayoutConstraint constraintWithItem:toolView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:toolView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:toolView
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:0]
                                ]];
    
    UIView *maskView = [[UIView alloc] init];
    maskView.translatesAutoresizingMaskIntoConstraints = NO;
    maskView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    [toolView addSubview:maskView];
    
    [toolView addConstraints:@[[NSLayoutConstraint constraintWithItem:maskView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:toolView
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:maskView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:toolView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:maskView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:toolView
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:maskView
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:toolView
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:0]
                                ]];
    
    UIButton *commitButton = [[UIButton alloc] init];
    commitButton.layer.borderWidth = 1;
    commitButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    commitButton.layer.cornerRadius = 3;
    commitButton.clipsToBounds = YES;
    commitButton.backgroundColor = [UIColor whiteColor];
    [commitButton addTarget:self action:@selector(commitButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    commitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [toolView addSubview:commitButton];

    [toolView addConstraints:@[[NSLayoutConstraint constraintWithItem:commitButton
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:toolView
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:0.65
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:commitButton
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:toolView
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:commitButton
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:toolView
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:1.2
                                                              constant:0],
                                
                                [NSLayoutConstraint constraintWithItem:commitButton
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:toolView
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:-toolViewH * 0.35]
                                ]];
    
    
}

#pragma mark - scrollView delegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return self.iocnView;
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}


#pragma mark - 点击事件
-(void)commitButtonDidClick
{
    if([self.delegate respondsToSelector:@selector(screenshotViewController:didImage:)]){
        self.screenshotView.layer.borderWidth = 0;
        [self.delegate screenshotViewController:self didImage:[self imageFromView:self.screenshotView]];
    }
}

- (void)backButtonDidClick:(UIButton *) btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获得某个范围内的屏幕图像
- (UIImage *)imageFromView: (UIView *) theView
{
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 创建一个context
    CGImageRef sourceImageRef = [image CGImage];
    CGRect frame = theView.frame;
    frame.origin.y -= self.scrollView.contentOffset.y;
    frame.origin.x -= self.scrollView.contentOffset.x;
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, frame);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    return newImage;
    
    
}

@end
