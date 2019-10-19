//
//  ViewController.m
//  Lab6-Alert&PopupView
//
//  Created by 張力元 on 2019/2/23.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "ViewController.h"
#import "customPopupViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (IBAction)demoAlertActionSheet:(id)sender {
    NSLog(@"觸發Alert Action Sheet按鈕");
    //初始化Alert Controller 設定Title、Message、呈現方式（Action Sheet或Alert）
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"Title" message:@"Message" preferredStyle:UIAlertControllerStyleActionSheet];
    //設定動作按鈕 Title：要顯示的文字 style：動作按鈕的外觀
    UIAlertAction *commonAction = [UIAlertAction actionWithTitle:@"Default Style" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //Style Default普通外觀
        //白底藍字
    }];
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"Destructive Style" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //Style Destructive提示使用者此動作為危險操作
        //白底紅字
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel Style" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //Style Cancel取消操作
        //白底藍字 置於最底層 與上述兩種外觀有間隔
    }];
    //將Action加入Alert Controller
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:commonAction];
    [actionSheetController addAction:destructiveAction];
    //顯示Alert Controller
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

- (IBAction)demoAlertView:(id)sender {
    NSLog(@"觸發Alert View按鈕");
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Title" message:@"Message" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *commonAction = [UIAlertAction actionWithTitle:@"Default Style" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"Destructive Style" style:UIAlertActionStyleDestructive handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel Style" style:UIAlertActionStyleCancel handler:nil];
    [alertViewController addAction:cancelAction];
    [alertViewController addAction:commonAction];
    [alertViewController addAction:destructiveAction];
    [self presentViewController:alertViewController animated:YES completion:nil];
}

- (IBAction)login:(id)sender {
    //初始化
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"登入" message:@"输入帳號密碼登入" preferredStyle:UIAlertControllerStyleAlert];
    //新增帳號輸入的TextField
    [actionSheetController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"請輸入帳號";
    }];
    //新增密碼輸入的TextField
    [actionSheetController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"請輸入密碼";
        //因為是密碼輸入，所以要設定以「＊」顯示
        textField.secureTextEntry = YES;
    }];
    //確定按鈕
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //讀取設定的TextField，先加入的為序號0
        UITextField *account = actionSheetController.textFields[0];
        UITextField *password = actionSheetController.textFields[1];
        //顯示相關提示
        [self showLoginAccount:account.text password:password.text];
        
    }];
    //取消按鈕
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //加入上述設定的Action
    [actionSheetController addAction:determineAction];
    [actionSheetController addAction:cancelAction];
    //顯示
    [self presentViewController:actionSheetController animated:YES completion:nil];
}

- (void)showLoginAccount:(NSString *)account password:(NSString *)password{
    //用Alert顯示剛剛輸入的帳號密碼
    UIAlertController *msgView = [UIAlertController alertControllerWithTitle:@"登入成功" message:[NSString stringWithFormat:@"帳號：%@\n密碼：%@",account,password] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [msgView addAction:determineAction];
    [self presentViewController:msgView animated:true completion:nil];
}

- (IBAction)showCustomPopupView:(id)sender {
    //初始化
    customPopupViewController *vc = [customPopupViewController new];
    //設定Block
    vc.block = ^(NSString * _Nonnull food){
        //用Log檢查傳入的值
        NSLog(@"%@",food);
        //用Alert顯示傳入的字串
        [self showStringData:food];
    };
    //顯示Popup View
    [vc showInVC:self];
}

- (void)showStringData:(NSString *)str{
    //用Alert顯示輸入字串
    UIAlertController *msgView = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",str] message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [msgView addAction:determineAction];
    [self presentViewController:msgView animated:true completion:nil];
}

@end
