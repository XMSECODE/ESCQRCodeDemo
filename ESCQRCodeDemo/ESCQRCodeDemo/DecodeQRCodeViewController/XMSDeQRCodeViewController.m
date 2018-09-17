//
//  XMSDeQRCodeViewController.m
//  decode
//
//  Created by xiangmingsheng on 16/10/29.
//  Copyright © 2016年 xiangmingsheng. All rights reserved.
//

#import "XMSDeQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>
#import "Header.h"

@interface XMSDeQRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//会话
@property(nonatomic,strong)AVCaptureSession* captureSession;

@property(nonatomic,weak)UIImagePickerController* imagePickerController;

/**
 操作上下文
 */
@property(nonatomic,strong)CIContext* context;

@end

@implementation XMSDeQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self RealTimeScanning];
    
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.captureSession startRunning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.captureSession stopRunning];
}

#pragma mark - 设置UI界面
-(void)setupUI{
    self.title = @"扫描二维码";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(enterPhtone)];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"扫描" style:UIBarButtonItemStylePlain target:self action:@selector(startCaptureSession)];
}

#pragma mark - 退出当前控制器
-(void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)startCaptureSession{
    [self.captureSession startRunning];
}

#pragma mark - 进入相册
-(void)enterPhtone{
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    self.imagePickerController = imagePickerController;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - 实时扫描二维码系统设置
-(void)RealTimeScanning{
    
    AVCaptureDevice* video = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError* error;
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:video error:&error];
    if (error) {
        NSLog(@"创建输入端失败,%@",error);
        return;
    }
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    if (![self.captureSession canAddInput:input]) {
        NSLog(@"输入端添加失败");
        return;
    }
    [self.captureSession addInput:input];
    
    AVCaptureVideoPreviewLayer* layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
    
    //创建输出端
    AVCaptureMetadataOutput* output = [[AVCaptureMetadataOutput alloc] init];
    
    if (![self.captureSession canAddOutput:output]) {
        NSLog(@"输出端添加失败");
        return;
    }
    [self.captureSession addOutput:output];
    
    output.metadataObjectTypes = @[@"org.iso.QRCode"];
    
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    CGFloat wh = kScreenWidth - 60;
    CGFloat width = wh / self.view.bounds.size.width;
    CGFloat height = wh / self.view.bounds.size.height;
    CGFloat x = (self.view.bounds.size.width - wh) * 0.5 / self.view.bounds.size.width;
    CGFloat y = (self.view.bounds.size.height - wh) * 0.5 / self.view.bounds.size.height;
    
    output.rectOfInterest = CGRectMake(y, x, height, width);
    
    [self coverButRect:CGRectMake((self.view.bounds.size.width - wh) * 0.5 , (self.view.bounds.size.height - wh) * 0.5, wh, wh)];
}

#pragma mark - 设置阴影遮盖
- (void)coverButRect:(CGRect)rect{
    // Rect为保留的矩形frame值
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat leftWidth = (screenWidth - rect.size.width) / 2;
    
    CAShapeLayer* layerTop   = [[CAShapeLayer alloc] init];
    layerTop.fillColor       = [UIColor blackColor].CGColor;
    layerTop.opacity         = 0.5;
    layerTop.path            = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, screenWidth, rect.origin.y)].CGPath;
    [self.view.layer addSublayer:layerTop];
    
    CAShapeLayer* layerLeft   = [[CAShapeLayer alloc] init];
    layerLeft.fillColor       = [UIColor blackColor].CGColor;
    layerLeft.opacity         = 0.5;
    layerLeft.path            = [UIBezierPath bezierPathWithRect:CGRectMake(0, rect.origin.y, leftWidth, rect.size.height)].CGPath;
    [self.view.layer addSublayer:layerLeft];
    
    CAShapeLayer* layerRight   = [[CAShapeLayer alloc] init];
    layerRight.fillColor       = [UIColor blackColor].CGColor;
    layerRight.opacity         = 0.5;
    layerRight.path            = [UIBezierPath bezierPathWithRect:CGRectMake(screenWidth - leftWidth, rect.origin.y, rect.size.width, rect.size.height)].CGPath;
    [self.view.layer addSublayer:layerRight];
    
    CAShapeLayer* layerBottom   = [[CAShapeLayer alloc] init];
    layerBottom.fillColor       = [UIColor blackColor].CGColor;
    layerBottom.opacity         = 0.5;
    layerBottom.path            = [UIBezierPath bezierPathWithRect:CGRectMake(0, CGRectGetMaxY(rect), screenWidth, screenHeight - CGRectGetMaxY(rect))].CGPath;
    [self.view.layer addSublayer:layerBottom];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    AVMetadataMachineReadableCodeObject* codeObject = metadataObjects.lastObject;
    [self.captureSession stopRunning];
    [self getResult:codeObject.stringValue];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
    [self deQRCode:image];
}

#pragma mark - 相册文件解码
-(void)deQRCode:(UIImage*)image{
    [MBProgressHUD showMessage:@"正在解码"];
    NSDictionary* option = @{CIDetectorAccuracy:CIDetectorAccuracyHigh};
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:self.context options:option];
    CIImage* inputimage = [CIImage imageWithCGImage:image.CGImage];
    NSArray <CIFeature*>*features = [detector featuresInImage:inputimage];
    if (features.count > 0 && [features.firstObject isKindOfClass:[CIQRCodeFeature class]]) {
        CIQRCodeFeature* feature = (CIQRCodeFeature*)features.firstObject;
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"解码完成"];
        [self getResult:feature.messageString];
    }else{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"未发现二维码"];
    }
}

#pragma mark - 处理结果
-(void)getResult:(NSString*)resultString{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"二维码内容" message:resultString preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    UIAlertAction* pastAction = [UIAlertAction actionWithTitle:@"复制到剪贴板" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showSuccess:@"已复制到剪贴板"];
        //复制到剪贴板
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = resultString;
    }];
    [alert addAction:pastAction];
    [self presentViewController:alert animated:YES completion:^{
        [self.captureSession stopRunning];
    }];
}

#pragma mark - 懒加载数据
-(CIContext *)context{
    if (_context == nil) {
        _context = [CIContext context];
    }
    return _context;
}

@end
