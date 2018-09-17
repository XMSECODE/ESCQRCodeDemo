//
//  UIView+XMSView.m
//  lotteryApp
//
//  Created by xiangmingsheng on 16/8/20.
//  Copyright © 2016年 xiangmingsheng. All rights reserved.
//

#import "UIView+XMSView.h"

@implementation UIView (XMSView)

#pragma mark - 开始对控件的frame进行赋值与取值
-(void)setY:(CGFloat)Y{
    CGRect temframe = self.frame;
    temframe.origin.y = Y;
    self.frame = temframe;
}
-(CGFloat)Y{
    return  self.frame.origin.y;
}

-(void)setX:(CGFloat)X{
    CGRect temframe = self.frame;
    temframe.origin.x = X;
    self.frame = temframe;
}
-(CGFloat)X{
    return  self.frame.origin.x;
}

-(void)setW:(CGFloat)W{
    CGRect temframe = self.frame;
    temframe.size.width = W;
    self.frame = temframe;
}
-(CGFloat)W{
    return  self.frame.size.width;
}

-(void)setH:(CGFloat)H{
    CGRect temframe = self.frame;
    temframe.size.height = H;
    self.frame = temframe;
}
-(CGFloat)H{
    return  self.frame.size.height;
}

#pragma mark - 快速创建控件对象的类方法
+(UIImageView*)imageViewWithFrame:(CGRect)frame andSuperView:(UIView*)superView{
    UIImageView* view = [[UIImageView alloc] init];
    view.frame = frame;
    [superView addSubview:view];
    return view;
}
+(UIImageView*)imageViewWithFrame:(CGRect)frame{
    UIImageView* view = [[UIImageView alloc] init];
    view.frame = frame;
    return view;
}

+(UILabel*)labelWithFrame:(CGRect)frame andSuperView:(UIView*)superView{
    UILabel* view = [[UILabel alloc] init];
    view.frame = frame;
    [superView addSubview:view];
    view.textAlignment = NSTextAlignmentCenter;
    return view;
}
+(UILabel*)labelViewWithFrame:(CGRect)frame{
    UILabel* view = [[UILabel alloc] init];
    view.frame = frame;
    view.textAlignment = NSTextAlignmentCenter;
    return view;
}

+(UIButton*)buttonWithFrame:(CGRect)frame andSuperView:(UIView*)superView{
    UIButton* view = [[UIButton alloc] init];
    view.frame = frame;
    [superView addSubview:view];
    return view;
}
+(UIButton*)buttonViewWithFrame:(CGRect)frame{
    UIButton* view = [[UIButton alloc] init];
    view.frame = frame;
    return view;
}
@end
