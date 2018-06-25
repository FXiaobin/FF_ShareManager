//
//  CFShareView.h
//  CaiFuMap
//
//  Created by fanxiaobin on 2017/8/8.
//  Copyright © 2017年 wanghongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

///分享数据模型
@interface ShareModel : NSObject

@property  (nonatomic,strong) UIViewController *targetVC;
@property  (nonatomic,strong) NSString *shareTitle;
@property  (nonatomic,strong) NSString *shareContent;
@property  (nonatomic,strong) NSString *shareImageStr;
@property  (nonatomic,strong) NSString *shareUrl;

@end

///定义一个带返回值的block变量
typedef ShareModel * (^shareInfoBlock)(ShareModel *model);


@interface CFShareView : UIView


@property (nonatomic,strong) ShareModel *shareModel;

@property (nonatomic,copy) void (^shareBtnActionBlock) (UIButton *sender, NSInteger tag);

#pragma mark - 这两种写法都可以 都可以从外面获取到分享的数据 唯一的区别就是第二中需要return model;将赋值后的model返回来
///1.分享数据赋值
- (void)shareInfoWithModel:(void (^)(ShareModel *model))block;

///2.分享数据赋值
- (void)shareInfo:(shareInfoBlock)block;


@end
