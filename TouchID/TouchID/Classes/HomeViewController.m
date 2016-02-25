//
//  HomeViewController.m
//  TouchID
//
//  Created by ALin on 16/2/25.
//  Copyright (c) 2016年 ALin. All rights reserved.
//================================================================
//
//  github: https://github.com/SunLiner
//  个人网站: http://www.coderalin.com
//  简书地址: http://www.jianshu.com/users/9723687edfb5/latest_articles
//  新浪微博: http://weibo.com/5589163526/profile?topnav=1&wvr=6&is_all=1
//
//================================================================

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)loadView
{
    UIImageView *homeImgView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    homeImgView.image = [UIImage imageNamed:@"home"];
    self.view =  homeImgView;
}

@end
