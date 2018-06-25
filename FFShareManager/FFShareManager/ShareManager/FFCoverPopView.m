//
//  FFCoverPopView.m
//  FFCoverPopView
//
//  Created by lovepinyao on 16/8/30.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "FFCoverPopView.h"

@interface FFCoverPopView ()

@property (nonatomic,strong) UIImageView *maskView;

@property (nonatomic,assign) CGFloat currentSubHeight;

@property (nonatomic,assign) BOOL isCenterPop;

@end

@implementation FFCoverPopView

- (instancetype)init{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        [self setup];
    }
    return self;
}

- (void)setup{
    
    self.maskView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.5;
    [self addSubview:self.maskView];
    
    self.maskView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCoverPopViewTap:)];
    [self.maskView addGestureRecognizer:tap];
}

-(void)setMaskColor:(UIColor *)maskColor{
    self.maskView.backgroundColor = maskColor;
}

-(void)setAlpha:(CGFloat)alpha{
    self.maskView.alpha = alpha;
}

- (void)hiddenCoverPopViewTap:(UITapGestureRecognizer *)sender{
    [self hiddenCoverPopView];
}

- (void)showCoverPopView{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window == nil) {
        window = [UIApplication sharedApplication].windows.firstObject;
    }
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [window addSubview:self];
    
    } completion:^(BOOL finished) {
        
    }];
         
}

- (void)hiddenCoverPopView{
    if (self.isCenterPop) {
        [self hiddenPopShowView];
    }else{
        [self coverPopViewHiddenSubView:self.currentSubView subViewHeight:self.currentSubHeight];
    }
    
}

- (void)coverPopViewShowSubView:(UIView *)subView subViewHeight:(CGFloat)sHeight{
    
    self.currentSubHeight = sHeight;
    self.currentSubView = subView;
    
    subView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, sHeight);
    
    [self addSubview:subView];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        subView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - sHeight, [UIScreen mainScreen].bounds.size.width, sHeight);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self showCoverPopView];
}

- (void)coverPopViewHiddenSubView:(UIView *)subView subViewHeight:(CGFloat)sHeight{
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        subView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, sHeight);
        
    } completion:^(BOOL finished) {

    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [subView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)popShowView:(UIView *)subView subViewSize:(CGSize)aSize topMargin:(CGFloat)topMargin{
    self.isCenterPop = YES;
    self.currentSubHeight = aSize.height;
    self.currentSubView = subView;
    
    CGFloat height = aSize.height;
    CGFloat width = aSize.width;
    CGFloat main_width = [UIScreen mainScreen].bounds.size.width;
    
    subView.frame = CGRectMake((main_width - width)/2.0, topMargin, width, height);
    [self addSubview:subView];
    
    [self showCoverPopView];
}

- (void)hiddenPopShowView{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.currentSubView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)showCoverPopViewWithContentView:(UIView *)contentView frame:(CGRect)frame{
    
    
    contentView.frame = frame;
    [self addSubview:contentView];
    
    [self showCoverPopView];
}

@end
