# XQSreenshotController


#CocoPods
```
pod 'XQSreenshotController', '~> 0.0.2'
```

### 头像选择器

在使用 XQSreenshotController 只需要通过 image 设置一张图片，便可以在 delegate 中获取到你想要截取的图片

支持iOS6+
```
@property(nonatomic, retain) UIImage *image;  
```
实现此代理方法
```
-(void)screenshotViewController:(XQScreenshotViewController *) screenshotViewController didImage:(UIImage *) image;  
```
### 如此简单

意见反馈邮箱：917709989@qq.com

项目环境： xcode8.1

gif 图片加载中...

![gif](https://github.com/weakGG/XQSreenshotController/blob/master/gif/selectimage.gif)
