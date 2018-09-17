//
//  UIImage+sss.h
//  QrCode
//
//  Created by xiangmingsheng on 16/10/27.
//  Copyright © 2016年 xiangmingsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QrCode)

/**
 生成对象data对象的二维码图片

 @param data data数据

 @return 生成的二维码图片
 */
+(UIImage*)getQrCodeImageWithData:(NSData*)data;

/**
 在图片中心点添加另一个图片

 @param image 被添加的图片
 @param size  被添加图片的大小

 @return 添加图片后的图片
 */
-(UIImage*)addImageAtCenterWithImage:(UIImage*)image andSize:(CGSize)size;

@end
