//
//  WBTabBar.m
//  百思不得姐
//
//  Created by lanou3g on 16/3/18.
//  Copyright © 2016年 wangbingjian. All rights reserved.
//


//#import "WBTabBar.h"
//@interface WBTabBar ()
//@property (nonatomic,weak)UIButton *plusButton;
//@end
//@implementation WBTabBar
//
//- (UIButton *)plusButton
//{
//    if (_plusButton == nil) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon.png"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon.png"] forState:UIControlStateHighlighted];
//        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_iconN.png"] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_iconN.png"] forState:UIControlStateHighlighted];
//        //sizeToFit :默认会根据按钮的背景图片或者文字计算出按钮的最合适的尺寸
//        [btn sizeToFit];
//        _plusButton = btn;
//        [self addSubview:_plusButton];
//    }
//    return _plusButton;
//}
//
//- (void)layoutSubviews
//{
//    NSLog(@"%@",self.subviews);
//    [super layoutSubviews];
//    CGFloat w = self.bounds.size.width;
//    CGFloat h = self.bounds.size.height;
//    CGFloat btnx = 0;
//    CGFloat btny = 0;
//    CGFloat btnw = w / (self.items.count + 1);
//    CGFloat btnh = h;
//    int i = 0;
//    for (UIView *tabBarButton in self.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            if (i == 2) {
//                i = 3;
//            }
//            btnx = i * btnw;
//            tabBarButton.frame = CGRectMake(btnx, btny, btnw, btnh);
//            i++;
//        }
//    }
//    //设置添加按钮的位置
//    self.plusButton.center = CGPointMake(w*0.5, h*0.5);
////    self.plusButton.bounds = CGRectMake(0, 0, self.plusButton.currentBackgroundImage.size.width, self.plusButton.currentBackgroundImage.size.height);
//}
//
//@end
