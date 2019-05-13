//
//  FirstVC.m
//  Lab9-NSNotification
//
//  Created by 張力元 on 2019/3/19.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "FirstVC.h"

@interface FirstVC ()
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UIButton *startTimer;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int time;
@end

@implementation FirstVC
- (void)viewDidLoad {
    [super viewDidLoad];
    //設定按鈕選取與未選取時所顯示的名稱
    [_registerBtn setTitle:@"開啟通知" forState:UIControlStateNormal];
    [_registerBtn setTitle:@"關閉通知" forState:UIControlStateSelected];
    [_startTimer setTitle:@"開始計時" forState: UIControlStateNormal];
    [_startTimer setTitle:@"關閉計時" forState:UIControlStateSelected];
}

- (IBAction)registerPublicNotification:(UIButton *)btn {
    //btn.selected用來判斷通知是否開啟 true:開啟 false:關閉
    if (!btn.selected) {
        //開啟通知
        //Observer:對象(多半是自己)
        //selector:要執行的副程式名稱
        //name:通知名稱，與發送時相同
        //object:指定發送對象，多半設為nil
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPublicMsg:) name:@"publicNotification" object:nil];
        [btn setSelected:true];
    }
    else{
        //關閉通知
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"publicNotification" object:nil];
        [btn setSelected:false];
    }
}

- (IBAction)startCount:(UIButton *)btn{
    //btn.selected用來判斷是否開始計時 true:開啟 false:關閉
    if (!btn.selected) {
        _time = 0;
        //TimeInterval:計數時間(單位為秒)
        //target:發送訊息的目標 基本上是selector內函式的位置
        //selector:要執行的函式
        //userInfo:傳遞資料
        //repeats:是否重複
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(count) userInfo:nil repeats:true];
        //開始計時
        [_timer fire];
        [btn setSelected:true];
    }
    else{
        [_timer invalidate];
        _timer = nil;
        [btn setSelected:false];
    }
}

- (void)count{
    _time++;
    NSMutableDictionary *timeDic = [NSMutableDictionary new];
    [timeDic setValue:[NSNumber numberWithInt:_time/3600] forKey:@"hour"];
    [timeDic setValue:[NSNumber numberWithInt:_time/60] forKey:@"min"];
    [timeDic setValue:[NSNumber numberWithInt:_time%60] forKey:@"sec"];
    //Name:通知名稱 object:資料物件
    [[NSNotificationCenter defaultCenter] postNotificationName:@"publicNotification" object:timeDic];
}

- (void)getPublicMsg:(NSNotification *)notification{
    NSDictionary *timeData = notification.object;
    [self showTime:timeData];
}

- (void)showTime:(NSDictionary *)timeData{
    int hour = [[timeData valueForKey:@"hour"] intValue];
    int min = [[timeData valueForKey:@"min"] intValue];
    int sec = [[timeData valueForKey:@"sec"] intValue];
    _timeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hour,min,sec];
}

@end
