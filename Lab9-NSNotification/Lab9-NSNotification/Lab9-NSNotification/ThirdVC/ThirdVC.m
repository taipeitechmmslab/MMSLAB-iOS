//
//  ThirdVCVC.m
//  Lab9-NSNotification
//
//  Created by 張力元 on 2019/3/19.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "ThirdVC.h"

@interface ThirdVC ()
@property (strong, nonatomic) IBOutlet UILabel *sender;
@property (strong, nonatomic) IBOutlet UILabel *msg;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //註冊區域通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRegionMsg:) name:@"regionNotification" object:nil];
    //註冊全域通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPublicMsg:) name:@"publicNotification" object:nil];
}

- (void)getRegionMsg:(NSNotification *)notification{
    NSDictionary *msgData = notification.object;
    [self showMsg:msgData];
}

- (void)showMsg:(NSDictionary *)msgData{
    _sender.text = [msgData valueForKey:@"sender"];
    _msg.text = [msgData valueForKey:@"msg"];
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
