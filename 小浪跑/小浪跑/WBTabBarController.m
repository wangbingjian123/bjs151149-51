//
//  WBTabBarController.m
//  百思不得姐
//
//  Created by lanou3g on 16/3/18.
//  Copyright © 2016年 wangbingjian. All rights reserved.
//

#import "WBTabBarController.h"
#import "HomeViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "UIImage+Extension.h"
//#import "WBTabBar.h"
#import <objc/message.h>
@interface WBTabBarController ()

@end

@implementation WBTabBarController

+ (void)initialize
{
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加所有子控制器
    [self setUpAllChildViewController];
//    WBTabBar *tabBar = [[WBTabBar alloc]initWithFrame:self.tabBar.frame];
//    
//    //利用KVC把readly的属性修改
//    [self setValue:tabBar forKeyPath:@"tabBar"];
//    objc_msgSend();
//    NSLog(@"%@",self.tabBar);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)setUpAllChildViewController
{
    //精华
    HomeViewController *attentionVC = [[HomeViewController alloc]init];
    [self setUpOneChildViewController:attentionVC image:[UIImage imageNamed:@"tabBar_essence_icon.png"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_essence_click_icon.png"] title:@"精华"];
    attentionVC.navigationItem.title = nil;
    
    //最新
    SecondViewController *creamVC = [[SecondViewController alloc]init];
    [self setUpOneChildViewController:creamVC image:[UIImage imageNamed:@"tabBar_new_icon.png"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_new_click_icon.png"] title:@"最新"];
    creamVC.navigationItem.title = nil;
    
    //关注
    ThirdViewController *newestVC = [[ThirdViewController alloc]init];
    [self setUpOneChildViewController:newestVC image:[UIImage imageNamed:@"tabBar_friendTrends_icon.png"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_friendTrends_click_icon.png"] title:@"关注"];
    
    //我
    FourViewController *mineVC = [[FourViewController alloc]init];
    [self setUpOneChildViewController:mineVC image:[UIImage imageNamed:@"tabBar_me_icon.png"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_me_click_icon.png"] title:@"我"];
    
}

- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
//    WBNavigationController *nav = [[WBNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:vc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
