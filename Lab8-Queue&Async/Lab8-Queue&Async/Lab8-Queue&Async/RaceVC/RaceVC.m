//
//  RaceVC.m
//  Lab8-Queue&Async
//
//  Created by 張力元 on 2019/3/15.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "RaceVC.h"

@interface RaceVC ()
@property (strong, nonatomic) IBOutlet UIProgressView *rabbitProgress;
@property (strong, nonatomic) IBOutlet UIProgressView *tortoiseProgress;
@property (assign, nonatomic) double rabbitDis;
@property (assign, nonatomic) double tortoiseDis;
@property (assign, nonatomic) BOOL finishFlag;
@end

@implementation RaceVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)startBtnClick:(id)sender {
    //初始化烏龜、兔子走的距離與完成旗標
    _rabbitDis = 0;
    _tortoiseDis = 0;
    _finishFlag = false;
    self.rabbitProgress.progress = 0;
    self.tortoiseProgress.progress = 0;
    //dispatch_get_global_queue(佇列的優先權,旗標)
    dispatch_queue_t secQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_async(secQueue, ^{
        //兔子跑
        while(self.rabbitDis<100 &&
              self.tortoiseDis<100){
            [self rabbitRun];
            [self showProgress];
        }
        [self showWiner];
    });
    
    dispatch_async(secQueue, ^{
        //烏龜跑
        while(self.rabbitDis<100 &&
              self.tortoiseDis<100){
            [self tortoiseRun];
            [self showProgress];
        }
        [self showWiner];
    });
}

- (void)rabbitRun{
    //兔子走隨機(1~10) 休隨機(1~10)
    int move = arc4random()%10+1;
    _rabbitDis = _rabbitDis + move;
    int sleepTime = arc4random()%10+1;
    //如果烏龜跑超過八成則變成只休息1
    if (_tortoiseDis>80)
        sleepTime = 1;
    NSLog(@"兔子走%d休息%d",move,sleepTime);
    //設定休息時間 單位為微秒
    usleep(sleepTime*50000);
}

- (void)tortoiseRun{
    //烏龜穩定走二休一
    _tortoiseDis = _tortoiseDis + 2;
    usleep(50000);
}

- (void)showProgress{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //在主執行緒顯示畫面更新
    dispatch_async(mainQueue, ^{
        self.rabbitProgress.progress = self.rabbitDis/100;
        self.tortoiseProgress.progress = self.tortoiseDis/100;
    });
}

- (void)showWiner{
    if (!_finishFlag) {
        _finishFlag = true;
        NSString *winMsg;
        if (_rabbitDis > _tortoiseDis)
            winMsg = @"兔子勝利";
        else if (_tortoiseDis > _rabbitDis)
            winMsg = @"烏龜勝利";
        else
            winMsg = @"平手";
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        //在主執行緒顯示畫面更新
        dispatch_async(mainQueue, ^{
            UIAlertController *msgView = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",winMsg] message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [msgView addAction:determineAction];
            [self presentViewController:msgView animated:true completion:nil];
        });
    }
}

@end
