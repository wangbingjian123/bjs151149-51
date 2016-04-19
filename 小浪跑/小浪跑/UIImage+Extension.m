//
//  UIImage+Extension.m
//  百思不得姐
//
//  Created by lanou3g on 16/3/18.
//  Copyright © 2016年 wangbingjian. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
