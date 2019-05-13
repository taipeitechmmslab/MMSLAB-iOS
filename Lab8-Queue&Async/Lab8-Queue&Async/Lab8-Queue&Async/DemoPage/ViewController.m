//
//  ViewController.m
//  Lab8-Queue&Async
//
//  Created by 張力元 on 2019/3/13.
//  Copyright © 2019 張力元. All rights reserved.
//
//要使用本頁面請將Storyboard的初始畫面設為本頁面
//
#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIProgressView *progress1;
@property (strong, nonatomic) IBOutlet UIProgressView *progress2;
@property (strong, nonatomic) IBOutlet UIProgressView *progress3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)testQueue:(id)sender {
    dispatch_queue_t secQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    NSLog(@"開始");
    dispatch_async(secQueue, ^{
        //任務一
        NSLog(@"任務一");
        sleep(1);
        NSLog(@"任務一完成");
    });
    dispatch_async(secQueue, ^{
        //任務二
        NSLog(@"任務二");
        sleep(2);
        NSLog(@"任務二完成");
    });
    NSLog(@"主執行緒空閒");
}

- (IBAction)testGroupQueue:(id)sender {
    //建立佇列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //建立一個佇列組
    dispatch_group_t groupQueue = dispatch_group_create();
    NSLog(@"開始");
    //dispatch_group_async(佇列組名稱, 執行佇列, 程式內容(Block))
    dispatch_group_async(groupQueue, globalQueue, ^{
        //隨機睡1~5秒
        int sleepTime = arc4random()%5+1;
        NSLog(@"任務一：睡%d秒",sleepTime);
        sleep(sleepTime);
        NSLog(@"任務一完成");
    });
    dispatch_group_async(groupQueue, globalQueue, ^{
        //隨機睡1~5秒
        int sleepTime = arc4random()%5+1;
        NSLog(@"任務二：睡%d秒",sleepTime);
        sleep(sleepTime);
        NSLog(@"任務二完成");
    });
    //dispatch_group_notify(佇列組名稱, 執行佇列, 程式內容(Block))
    dispatch_group_notify(groupQueue, mainQueue, ^{
        //回主執行緒刷新
        NSLog(@"兩個任務皆已完成");
    });
    NSLog(@"主執行緒空閒");
}

- (IBAction)startBtnClick:(id)sender {
    //dispatch_get_global_queue(佇列的優先權,旗標)
    dispatch_queue_t secQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_async(secQueue, ^{
        //任務一
        double i = 0;
        while(i<100){
            DELAY(10000000);
            i++;
            [self showProgress:1 value:i/100];
            NSLog(@"MS1-%.1f",i);
        }
    });
    
    dispatch_async(secQueue, ^{
        //任務二
        double i = 0;
        while(i<100){
            DELAY(20000000);
            i++;
            [self showProgress:2 value:i/100];
            NSLog(@"MS2-%.1f",i);
        }
    });
    
    dispatch_async(secQueue, ^{
        //任務三
        double i = 0;
        while(i<100){
            DELAY(40000000);
            i++;
            [self showProgress:3 value:i/100];
            NSLog(@"MS3-%.1f",i);
        }
    });
}

- (void)showProgress:(int)index value:(double)value{
    //主執行緒的佇列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        switch (index) {
            case 1:
                self.progress1.progress = value;
                break;
            case 2:
                self.progress2.progress = value;
                break;
            case 3:
                self.progress3.progress = value;
                break;
            default:
                break;
        }
    });
}


@end
