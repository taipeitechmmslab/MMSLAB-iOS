//
//  ZoomVC.m
//  Lab5-TabBar&Container
//
//  Created by 張力元 on 2019/2/21.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "ZoomVC.h"

@interface ZoomVC ()
@property (strong, nonatomic) IBOutlet UIView *containerView;
@end

@implementation ZoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

//Scroll View Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    //設定要縮放的畫面
    return _containerView;
}
@end
