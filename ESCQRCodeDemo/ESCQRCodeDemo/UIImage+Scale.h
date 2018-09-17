//
//  UIImage+scale.h
//  decode
//
//  Created by xiangmingsheng on 2016/10/31.
//  Copyright © 2016年 xiangmingsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (scale)


/**
 缩放图片

 @param scale 缩放比例
 @return 缩放后的图片
 */
-(UIImage*)scaleImageWithScale:(CGFloat)scale;


/**
 缩放图片

 @param size 缩放后的大小
 @return 缩放后的图片
 */
-(UIImage*)scaleImageWithSize:(CGSize)size;

@end
