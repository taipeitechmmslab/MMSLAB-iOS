//
//  Container1ViewController.m
//  Lab5-TabBar&Container
//
//  Created by 張力元 on 2019/2/19.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "Container1ViewController.h"

@interface Container1ViewController ()

@end

@implementation Container1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@ viewDidLoad",[self class]);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@ viewWillAppear",[self class]);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%@ viewDidAppear",[self class]);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%@ viewWillDisappear",[self class]);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"%@ viewDidDisappear",[self class]);
}

- (void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
}

@end
