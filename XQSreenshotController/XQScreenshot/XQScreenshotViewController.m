//
//  XQScreenshotViewController.m
//  EasyFamily
//
//  Created by mac-2016 on 17/3/29.
//  Copyright © 2017年 GXQ. All rights reserved.
//

#import "XQScreenshotViewController.h"
#import "Masonry.h"
#import "UIView+XQFrame.h"

#define WeakSelf __weak typeof(self) weakSelf = self;

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupIconView
{
    CGFloat screenshotViewWH = self.view.xq_width * 0.7;
    
    NSInteger scale = [UIScreen mainScreen].scale;
    
    CGFloat iocnViewW = self.image.size.width / scale;
    CGFloat iocnViewH = self.image.size.height / scale;
    
    if (iocnViewW < screenshotViewWH) {
        iocnViewH = screenshotViewWH / iocnViewW * iocnViewH;
        iocnViewW = screenshotViewWH;
    }
    if (iocnViewH < screenshotViewWH) {
        iocnViewW = screenshotViewWH / iocnViewH * iocnViewW;
        iocnViewH = screenshotViewWH;
    }
    
    UIImageView *iocnView = [[UIImageView alloc] initWithImage:self.image];
    iocnView.xq_size = CGSizeMake(iocnViewW, iocnViewH);
    [self.scrollView addSubview:iocnView];
    self.iocnView = iocnView;
    
    // scrollView set
    self.scrollView.contentSize = iocnView.xq_size;
    
    CGFloat InsetTopBottom = (self.view.xq_height - screenshotViewWH) * 0.5 - self.navigationController.navigationBar.xq_height - [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat InsetLeftRight = (self.view.xq_width - screenshotViewWH) * 0.5;
    self.scrollView.contentInset = UIEdgeInsetsMake(InsetTopBottom, InsetLeftRight, InsetTopBottom, InsetLeftRight);
    
    CGFloat minimumZoomScale = 1;
    
    if (iocnViewW > screenshotViewWH && iocnViewH > screenshotViewWH) {
        
        minimumZoomScale = screenshotViewWH / MIN(iocnViewW, iocnViewH);
        
    }
    
    self.scrollView.minimumZoomScale = minimumZoomScale;
}

-(void)setupScrollView
{
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.bouncesZoom = NO;
    scrollView.minimumZoomScale = 0.7;
    scrollView.maximumZoomScale = 3.0;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.scrollView = scrollView;
}

-(void)setupScreenshotView
{
    WeakSelf
    
    UIView *screenshotView = [[UIView alloc] init];
    screenshotView.layer.borderWidth = 1;
    screenshotView.layer.borderColor = [UIColor whiteColor].CGColor;
    screenshotView.layer.cornerRadius = 3;
    [self.scrollView addSubview:screenshotView];
    [screenshotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(weakSelf.view.xq_width * 0.7);
        make.center.mas_equalTo(weakSelf.view);
    }];
    self.screenshotView = screenshotView;
}

-(void)setupMaskView
{
    WeakSelf
    
    // top
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.scrollView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.screenshotView.mas_top);
    }];
    
    // left
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.scrollView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.screenshotView.mas_left);
        make.bottom.equalTo(weakSelf.view);
    }];
    
    // bottom
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.scrollView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.screenshotView.mas_bottom);
        make.left.equalTo(leftView.mas_right);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
    
    // right
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.scrollView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(weakSelf.screenshotView.mas_right);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(bottomView.mas_top);
    }];
}

-(void)toolView
{
    
    WeakSelf
    CGFloat toolViewH = 50;
    
    UIView *toolView = [[UIView alloc] init];
    toolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolView];
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(toolViewH);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
    
    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    [toolView addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
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
    [self.view addSubview:commitButton];
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(toolViewH * 0.65);
        make.right.equalTo(toolView).with.offset(-toolViewH * 0.35);
        make.centerY.equalTo(toolView);
        make.width.mas_equalTo(toolViewH * 1.2);
    }];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
