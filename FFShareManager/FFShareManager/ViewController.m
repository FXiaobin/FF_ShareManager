//
//  ViewController.m
//  FFShareManager
//
//  Created by mac on 2018/6/23.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "ViewController.h"
#import "FFCoverPopView.h"
#import "CFShareView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"点我分享" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    
    
    
}

- (void)share:(UIButton *)sender{
    FFCoverPopView *pop = [[FFCoverPopView alloc] init];
    
    CFShareView *shareView = [[CFShareView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180)];
    //shareView.targetVC = self;
    [pop coverPopViewShowSubView:shareView subViewHeight:180];
    
    shareView.shareBtnActionBlock = ^(UIButton *sender, NSInteger tag) {
        [pop hiddenCoverPopView];
    };
    
//    [shareView shareInfoWithModel:^(ShareModel *model) {
//        model.targetVC = self;
//        model.shareTitle = @"分享标题";
//        model.shareUrl = @"http://www.baidu.com";
//        model.shareContent = @"这种写法很不错，呵呵呵~~";
//        model.shareImageStr = @"https://pic.ibaotu.com/00/54/91/40n888piCXp5.jpg-0.jpg!ww700";
//
//    }];
    
    [shareView shareInfo:^ShareModel *(ShareModel *model) {
        model.targetVC = self;
        model.shareTitle = @"分享标题111";
        model.shareUrl = @"http://www.baidu.com";
        model.shareContent = @"这种写法很不错，呵呵呵~~1111";
        model.shareImageStr = @"https://pic.ibaotu.com/00/54/91/40n888piCXp5.jpg-0.jpg!ww700";
        
        return model;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
