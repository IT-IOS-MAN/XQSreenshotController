//
//  ViewController.m
//  XQSreenshotController
//
//  Created by mac-2016 on 17/6/17.
//  Copyright © 2017年 mac-2016. All rights reserved.
//

#import "ViewController.h"
#import "XQScreenshotViewController.h"

#define WeakSelf __weak typeof(self) weakSelf = self;

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, XQScreenshotViewControllerDelegate>

@property(nonatomic, weak) UINavigationController * nav;

@property(nonatomic, weak) UIViewController * picker;

@property (weak, nonatomic) IBOutlet UIImageView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

- (IBAction)selectImage:(id)sender {
    
    WeakSelf
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    
    imgPicker.delegate = self;
    
    
    // 添加图片
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        [weakSelf presentViewController:imgPicker animated:YES completion:nil];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [weakSelf presentViewController:imgPicker animated:YES completion:nil];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [weakSelf presentViewController:alert animated:YES completion:nil];
    
    self.picker = imgPicker;
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIViewController *)picker didFinishPickingMediaWithInfo:(id)info
{
    
    if ([picker isMemberOfClass:nil]) {
        
    } else {
        
        UIImage * headerImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        XQScreenshotViewController *vc = [[XQScreenshotViewController alloc] init];
        vc.delegate = self;
        vc.image = headerImage;
        [self.nav pushViewController:vc animated:YES];
    }
    
    
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    [navigationController.navigationBar setTitleTextAttributes:
//     
//     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
//       
//       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.nav = navigationController;
}

#pragma mark - XQScreenshotViewControllerDelegate
-(void)screenshotViewController:(XQScreenshotViewController *)screenshotViewController didImage:(UIImage *)image
{
    _headerView.image = image;
    
    [self.picker dismissViewControllerAnimated:YES completion:nil];

}


@end
