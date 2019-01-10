//
//  ViewController.m
//  ZYLBtnTimeInterval
//
//  Created by gxd on 2019/1/10.
//  Copyright © 2019年 zyl. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+ZYLBtnTimeInterval.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn=[UIButton new];
    btn.qi_eventInterval=0.5;
    [self.view addSubview:btn];
}


@end
