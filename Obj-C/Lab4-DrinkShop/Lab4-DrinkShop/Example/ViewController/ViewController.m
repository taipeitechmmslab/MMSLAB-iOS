//
//  ViewController.m
//  Lab4-DrinkShop
//
//  Created by 張力元 on 2019/1/24.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "ViewController.h"
#import "SecViewController.h"
#import "ThirdViewController.h"

@interface ViewController ()<SecViewControllerDelegate>

@end

@implementation ViewController

- (void)loadView{
    [super loadView];
    NSLog(@"VC loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"VC viewDidLoad");
    //可撰寫在這個View Controller只會執行一次的程式
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"VC viewWillAppear");
    //每次都會在這個View Controller出現前執行(多次)
    //可用來整理畫面上的元件
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"VC viewDidAppear");
    //接續在viewWillAppear後執行(多次)
    //可用來顯示畫面的動畫
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"VC viewWillDisappear");
    //觸發離開View Controller時會執行
    //可用來儲存畫面設定
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"VC viewDidDisappear");
    //離開View Controller後會執行
    //仍可於背景控制元件，等到下次進入時才會被使用者發現
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //判斷使用哪個segue跳轉頁面
    if([segue.identifier isEqualToString:@"showSecPage"]){
        //取得要跳轉的頁面
        SecViewController *controller = (SecViewController *)segue.destinationViewController;
        //設定要傳遞的參數
        controller.data = @"使用segue傳遞資料 Delegate";
        controller.count = 0;
        controller.delegate = self;
    }
}

- (IBAction)nextPage:(id)sender {
    //讀取Storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //View Controller初始化
    SecViewController *VC = [storyboard instantiateViewControllerWithIdentifier:@"SecViewController"];
    //設定傳入的資料
    VC.data = @"使用程式碼傳遞資料 設定Block";
    VC.count = 0;
    __weak typeof(self) weakSelf = self;
    VC.block = ^(NSString *content){
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.title = content;
    };
//    [self.navigationController pushViewController:VC animated:true];
    [self presentViewController:VC animated:true completion:nil];
}


- (void)changeTitle:(NSString *)title{
    self.title = title;
}

@end
