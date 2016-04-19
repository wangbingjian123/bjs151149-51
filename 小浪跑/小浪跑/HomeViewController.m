//
//  HomeViewController.m
//  小浪跑
//
//  Created by lanou3g on 16/3/29.
//  Copyright © 2016年 wangbingjian. All rights reserved.
//

#import "HomeViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface HomeViewController ()
@property (nonatomic,strong)UILabel *label;
@end

@implementation HomeViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    self.label.backgroundColor = [UIColor cyanColor];
    if (![CMStepCounter isStepCountingAvailable]) {
        return;
    }
    CMStepCounter *stepCounter = [[CMStepCounter alloc]init];
    [stepCounter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue] updateOn:5 withHandler:^(NSInteger numberOfSteps, NSDate * _Nonnull timestamp, NSError * _Nullable error) {
        self.label.text = [NSString stringWithFormat:@"%ld",(long)numberOfSteps];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
