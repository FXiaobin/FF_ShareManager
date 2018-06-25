//
//  FFCoverPopView.h
//  FFCoverPopView
//
//  Created by lovepinyao on 16/8/30.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFCoverPopView : UIView


@property (nonatomic,strong) UIView *currentSubView;

//遮罩层颜色 默认黑色半透明
@property (nonatomic,strong) UIColor *maskColor;
@property (nonatomic,assign) CGFloat maskAlpha;

///底部弹出
- (void)coverPopViewShowSubView:(UIView *)subView subViewHeight:(CGFloat)sHeight;
///中间弹出
- (void)popShowView:(UIView *)subView subViewSize:(CGSize)aSize topMargin:(CGFloat)topMargin;

- (void)showCoverPopView;

- (void)hiddenCoverPopView;

///自定义位置弹出 frame:相对于整个屏幕设置的
- (void)showCoverPopViewWithContentView:(UIView *)contentView frame:(CGRect)frame;


@end
