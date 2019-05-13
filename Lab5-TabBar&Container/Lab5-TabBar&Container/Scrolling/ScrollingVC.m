//
//  ScrollingVC.m
//  Lab5-TabBar&Container
//
//  Created by 張力元 on 2019/2/21.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "ScrollingVC.h"

@interface ScrollingVC ()
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ScrollingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    //滑動Scroll View會呼叫此方法
    //使用Scroll View左上角的X位置/Scroll View的寬度取得目前在第幾頁
    int page = sender.contentOffset.x/sender.frame.size.width;
    //設定Page Control的頁數顯示
    _pageControl.currentPage = page;
}
@end
