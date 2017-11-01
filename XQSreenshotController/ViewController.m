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

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, XQScreenshotViewControllerDelegate, UIActionSheetDelegate>

@property(nonatomic, weak) UINavigationController * nav;

@property(nonatomic, weak) UIViewController * picker;

@property (weak, nonatomic) IBOutlet UIImageView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

- (IBAction)selectImage:(id)sender {
    
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"图库",  nil];
    [sheet showInView:self.view];
    
    
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    
    imgPicker.delegate = self;
    
    if (buttonIndex == 0) {
        [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        [self presentViewController:imgPicker animated:YES completion:nil];
    } else if (buttonIndex == 1) {
        [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentViewController:imgPicker animated:YES completion:nil];
    }
    self.picker = imgPicker;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(id)info
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
