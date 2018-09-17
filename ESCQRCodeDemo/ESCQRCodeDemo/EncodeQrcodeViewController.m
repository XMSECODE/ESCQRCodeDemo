//
//  CreateNewQrcodeViewController.m
//  decode
//
//  Created by xiangmingsheng on 16/10/29.
//  Copyright © 2016年 xiangmingsheng. All rights reserved.
//

#import "EncodeQrcodeViewController.h"
#import "UIImage+QrCode.h"
#import "Header.h"

@interface EncodeQrcodeViewController ()

@property(nonatomic,weak)UITextView* textView;

@property(nonatomic,weak)UIImageView* QRCodeImageView;

@end

@implementation EncodeQrcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 设置界面
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"生成二维码";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存到相册" style:UIBarButtonItemStylePlain target:self action:@selector(savePhoto)];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

    
    CGFloat width = kScreenWidth - 100;
    
    UILabel* label = [[UILabel alloc] init];
    label.text = @"请输入要生成二维码的文字";
    
    [label sizeToFit];
    [self.view addSubview:label];
    label.frame = CGRectMake(50, 100, width, 40);
    
    UITextView* textView = [[UITextView alloc] init];
    [self.view addSubview:textView];
    textView.frame = CGRectMake(50, 150, width, 150);
    textView.font = [UIFont systemFontOfSize:20];
    textView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    self.textView = textView;
    
    UIButton* button = [[UIButton alloc] init];
    [button setTitle:@"生成二维码" forState:UIControlStateNormal];
    button.frame = CGRectMake(50, 320, 100, 30);
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(createQRCodeImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 360, width, width)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageView];
    self.QRCodeImageView = imageView;
}

#pragma mark - 触摸屏幕辞去第一响应者方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
}

#pragma mark - 创建一个二维码
-(void)createQRCodeImage{
    NSData* strData = [self.textView.text dataUsingEncoding:NSUTF8StringEncoding];
    UIImage* image = [UIImage getQrCodeImageWithData:strData];
    self.QRCodeImageView.image = image;
    [self.textView resignFirstResponder];
}

#pragma mark - 保存图片的方法
-(void)savePhoto{
    NSLog(@"%@",self.QRCodeImageView.image);
    UIImage* image = self.QRCodeImageView.image;
    UIImage* iamges = [image addImageAtCenterWithImage:nil andSize:CGSizeMake(0, 0)];
    UIImageWriteToSavedPhotosAlbum(iamges, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark - 保存图片的回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [MBProgressHUD showError:@"保存出错"];
    }else{
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}

@end
