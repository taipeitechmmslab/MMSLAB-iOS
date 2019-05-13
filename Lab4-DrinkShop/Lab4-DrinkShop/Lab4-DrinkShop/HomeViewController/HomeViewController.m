//
//  HomeViewController.m
//  Lab4-DrinkShop
//
//  Created by 張力元 on 2019/2/13.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "HomeViewController.h"
#import "OrderViewController.h"
#import "CompleteViewController.h"

@interface HomeViewController ()<OrderViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *startBtn;
@property (strong, nonatomic) IBOutlet UILabel *showOrderLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *completeBtn;
@property (strong, nonatomic) drink *myDrink;
@end

@implementation drink
//飲料資訊的物件
//因為沒有任何函式 所以不用寫
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //設定尚未點餐的提示文字，只有第一次點餐時會顯示
    _showOrderLabel.text = @"您尚未點餐，\n請點選開始點餐進行點餐作業";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //判斷有沒有訂飲料
    if (_myDrink) {
        //有訂飲料 修改按鈕文字 顯示訂單資料 啟動完成按鈕
        [_startBtn setTitle:@"修改訂單" forState:UIControlStateNormal];
        _showOrderLabel.text = [NSString stringWithFormat:@"您的飲料：%@\n甜度為：%@\n冰量為：%@\n售價：%d",_myDrink.name,_myDrink.sweetness,_myDrink.ice,_myDrink.price];
        _completeBtn.enabled = true;
    }
    else{
        //沒訂飲料 顯示開始點餐 關閉完成按鈕
        [_startBtn setTitle:@"開始點餐" forState:UIControlStateNormal];
        _completeBtn.enabled = false;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //判斷使用哪個segue跳轉頁面
    if([segue.identifier isEqualToString:@"OrderSegue"]){
        //取得要跳轉的頁面
        OrderViewController *VC = (OrderViewController *)segue.destinationViewController;
        //設定要傳遞的參數
        VC.myDrink = _myDrink;
        //設定委派對象是自己
        VC.delegate = self;
    }
}

- (void)sendOrder:(drink *)myOrder{
    //OrderViewController的委派任務
    //將傳遞過來的訂單資訊儲存至此頁面
    _myDrink = myOrder;
}

- (IBAction)completeBtnClick:(id)sender {
    //點擊完成按鈕
    CompleteViewController *VC = [[CompleteViewController alloc]init];
    //傳遞飲料資訊
    VC.myDrink = _myDrink;
    //設定程式塊 目的為清空訂單 與 顯示再次使用提示
    __weak typeof(self) weakSelf = self;
    VC.block = ^(NSString *msg){
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.myDrink = nil;
        strongSelf.showOrderLabel.text = msg;
    };
    //顯示畫面
    [self presentViewController:VC animated:true completion:nil];
}

@end
