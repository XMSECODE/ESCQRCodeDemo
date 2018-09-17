//
//  UIView+XMSView.h
//  lotteryApp
//
//  Created by xiangmingsheng on 16/8/20.
//  Copyright © 2016年 xiangmingsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XMSView)

@property(nonatomic,assign)CGFloat X;

@property(nonatomic,assign)CGFloat Y;

@property(nonatomic,assign)CGFloat W;

@property(nonatomic,assign)CGFloat H;

+(UIImageView*)imageViewWithFrame:(CGRect)frame andSuperView:(UIView*)superView;
+(UIImageView*)imageViewWithFrame:(CGRect)frame;

+(UILabel*)labelWithFrame:(CGRect)frame andSuperView:(UIView*)superView;
+(UILabel*)labelViewWithFrame:(CGRect)frame;

+(UIButton*)buttonWithFrame:(CGRect)frame andSuperView:(UIView*)superView;
+(UIButton*)buttonViewWithFrame:(CGRect)frame;
@end
