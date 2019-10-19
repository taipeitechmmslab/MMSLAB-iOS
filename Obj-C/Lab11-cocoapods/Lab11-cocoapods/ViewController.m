//
//  ViewController.m
//  Lab11-cocoapods
//
//  Created by 張力元 on 2019/4/2.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "ViewController.h"
#import <Toast.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)showToastBtnClick:(id)sender {
    NSString *showStr = _textField.text;
    if (![showStr isEqualToString:@""]) {
        [self.view makeToast:showStr];
    }
    else{
        [self.view makeToast:@"請於上方Text Field中輸入要顯示的文字"];
    }
    NSDictionary *aa = [NSDictionary new];
    [aa setValue:@"aa" forKey:@"aaaa"];
}

@end
