//
//  CFShareView.m
//  CaiFuMap
//
//  Created by fanxiaobin on 2017/8/8.
//  Copyright © 2017年 wanghongwei. All rights reserved.
//

#import "CFShareView.h"
#import <Masonry.h>
#import "UIButton+SSEdgeInsets.h"

#import <UMShare/UMShare.h>

@implementation ShareModel



@end

@interface CFShareView ()

@property  (nonatomic,strong) UILabel *titleLabel;

@property  (nonatomic,strong) UIButton *cancelBtn;


@end

@implementation CFShareView

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = @"分享到";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

-(UIButton *)cancelBtn{
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _cancelBtn.tag = 9999;
    }
    return _cancelBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
       
        [self addSubview:self.titleLabel];
        [self addSubview:self.cancelBtn];
        
        UIView *centerView = [[UIView alloc] init];
        centerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:centerView];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(self);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(40);
        }];
       
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(40);
        }];
        
        [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(0.5);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.cancelBtn.mas_top).offset(-0.5);
        }];
        
        NSArray *arr = @[@"share_wx",@"share_timeLine",@"share_qq",@"share_qqzone",@"share_sina"];
        NSArray *titles = @[@"微信",@"朋友圈",@"QQ",@"QQ空间",@"微博"];
        
        CGFloat width = CGRectGetWidth(self.frame) / titles.count;
        for (int i = 0; i < arr.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(width * i, (CGRectGetHeight(self.frame) - 80 - width)/2.0, width, width)];
            btn.tag = 10000 + i;
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:10];
            [btn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
            [centerView addSubview:btn];
            
            [btn setImagePositionWithType:SSImagePositionTypeTop spacing:5];
        }
        
    }
    return self;
}

- (void)shareInfoWithModel:(void (^)(ShareModel *))block{
    ///创建一个数据模型 用全局属性引用它 并把它传到外面来接收外界的赋值数据
    ShareModel *model = [[ShareModel alloc] init];
    self.shareModel = model;
    
    if (block) {
        block(model);
    }
}

-(void)shareInfo:(shareInfoBlock)block{
    ///创建一个数据模型 将它传递出去接收数据然后再return回来给全局变量self.shareModel来引用
    ShareModel *model = [[ShareModel alloc] init];
    self.shareModel = block(model);
    
}

- (void)shareBtnAction:(UIButton *)sender{
    
    NSInteger index = sender.tag - 9999;
 
    switch (index) {
            // 0 取消
        case 1: {
            [self shareWithType:UMSocialPlatformType_WechatSession];
        } break;
        case 2: {
            [self shareWithType:UMSocialPlatformType_WechatTimeLine];
        } break;
        case 3: {
            [self shareWithType:UMSocialPlatformType_QQ];
        } break;
        case 4: {
            [self shareWithType:UMSocialPlatformType_Qzone];
        } break;
        case 5: {
            [self shareWithType:UMSocialPlatformType_Sina];
        } break;
        
        default:
            break;
    }
    
    if (self.shareBtnActionBlock) {
        self.shareBtnActionBlock(sender, index);
    }
}

#pragma mark - 根据不同分享平台 分享
- (void)shareWithType:(UMSocialPlatformType)platformType {
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareModel.shareTitle descr:self.shareModel.shareContent thumImage:self.shareModel.shareImageStr];
    //设置网页地址
    shareObject.webpageUrl = self.shareModel.shareUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self.shareModel.targetVC completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];

}


@end
