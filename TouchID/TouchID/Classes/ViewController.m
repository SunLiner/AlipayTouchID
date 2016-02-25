//
//  ViewController.m
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

#import "ViewController.h"
#import "HomeViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <sys/utsname.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Finger"]];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    imgView.center = CGPointMake(screenSize.width * 0.5, screenSize.height * 0.4);
    [self.view addSubview:imgView];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"点击进行指纹解锁";
    [tipLabel sizeToFit];
    tipLabel.center = CGPointMake(screenSize.width * 0.5, CGRectGetMaxY(imgView.frame) + 30);
    [self.view addSubview:tipLabel];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchID];
}

- (void)touchID {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    // 第一步判断是否支持Touch ID 或者 本机是否已经录入指纹
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请验证已有指纹" reply:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                NSLog(@"验证失败"); // 系统会自动给错误提示
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 进入主页面
                    HomeViewController *home = [[HomeViewController alloc] init];
                    [self presentViewController:home animated:YES completion:nil];
                });
            }
        }];
    }else {
        if (self.isSimulator) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请用真机测试~" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"不支持Touch ID~" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        }
    }
}

- (BOOL)isSimulator{
     struct utsname systemInfo;
     uname(&systemInfo);
     NSString *deviceMachine = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceMachine isEqualToString:@"i386"] || [deviceMachine isEqualToString:@"x86_64"])       {
        return YES;
    }
    return NO;
}
@end
