//
//  UIImage+scale.m
//  decode
//
//  Created by xiangmingsheng on 2016/10/31.
//  Copyright © 2016年 xiangmingsheng. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (scale)

/**
 缩放图片
 
 @param scale 缩放比例
 @return 缩放后的图片
 */
-(UIImage*)scaleImageWithScale:(CGFloat)scale{
    CGSize imageSize = self.size;
    CGSize scaleSize = CGSizeMake(imageSize.width * scale, imageSize.height * scale);
    UIGraphicsBeginImageContext(scaleSize);
    [self drawInRect:CGRectMake(0, 0, scaleSize.width, scaleSize.height)];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 缩放图片
 
 @param size 缩放后的大小
 @return 缩放后的图片
 */
-(UIImage*)scaleImageWithSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
