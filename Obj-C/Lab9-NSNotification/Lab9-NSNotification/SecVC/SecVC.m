//
//  SecVC.m
//  Lab9-NSNotification
//
//  Created by 張力元 on 2019/3/19.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "SecVC.h"

@interface SecVC ()
@property (strong, nonatomic) IBOutlet UITextField *msgTextField;
@property (strong, nonatomic) IBOutlet UILabel *sender;
@property (strong, nonatomic) IBOutlet UILabel *msg;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *keyboardNotificationBtn;
@end

@implementation SecVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPublicMsg:) name:@"publicNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRegionMsg:) name:@"regionNotification" object:nil];
    [_keyboardNotificationBtn setTitle:@"開啟系統鍵盤通知" forState:UIControlStateNormal];
    [_keyboardNotificationBtn setTitle:@"關閉系統鍵盤通知" forState:UIControlStateSelected];
}

- (IBAction)registerKeyboardNotification:(UIButton *)btn {
    if (!btn.selected) {
        //註冊鍵盤開啟通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow) name:UIKeyboardWillShowNotification object:nil];
        //註冊鍵盤關閉通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
        [btn setSelected:true];
    }
    else{
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [btn setSelected:false];
    }
}

- (IBAction)regionNotificationSend:(id)sender {
    //傳送資料物件
    NSMutableDictionary *sendDic = [self getSendData];
    //Name:通知名稱 object:資料物件
    [[NSNotificationCenter defaultCenter] postNotificationName:@"regionNotification" object:sendDic];
}

- (NSMutableDictionary *)getSendData{
    NSString *sendMsg = _msgTextField.text;
    NSMutableDictionary *sendDic = [NSMutableDictionary new];
    [sendDic setValue:sendMsg forKey:@"msg"];
    [sendDic setValue:@"畫面二" forKey:@"sender"];
    return sendDic;
}

- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:true];
}

- (void)keyboardShow{
    NSLog(@"觸發顯示鍵盤");
    _sender.text = @"系統";
    _msg.text = @"顯示鍵盤";
}

- (void)keyboardHide{
    NSLog(@"觸發隱藏鍵盤");
    _sender.text = @"系統";
    _msg.text = @"隱藏鍵盤";
}

- (void)getRegionMsg:(NSNotification *)notification{
    //收到regionNotification的執行函式
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
