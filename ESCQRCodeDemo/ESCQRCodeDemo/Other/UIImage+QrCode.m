//
//  UIImage+sss.m
//  QrCode
//
//  Created by xiangmingsheng on 16/10/27.
//  Copyright © 2016年 xiangmingsheng. All rights reserved.
//

#import "UIImage+QrCode.h"

@implementation UIImage (QrCode)

+(UIImage*)getQrCodeImageWithData:(NSData*)data{
    CIFilter* filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    CIImage* ciImage = filter.outputImage;
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformMakeScale(15, 15)];
    
    UIImage* QrCodeimage = [UIImage imageWithCIImage:ciImage];
    return QrCodeimage;
}

-(UIImage*)addImageAtCenterWithImage:(UIImage*)image andSize:(CGSize)size{
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGFloat centerImageX = self.size.width / 2 - size.width / 2;
    CGFloat centerImageY = self.size.height / 2 - size.height / 2;
    [image drawInRect:CGRectMake(centerImageX, centerImageY, size.width, size.height)];
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

@end
