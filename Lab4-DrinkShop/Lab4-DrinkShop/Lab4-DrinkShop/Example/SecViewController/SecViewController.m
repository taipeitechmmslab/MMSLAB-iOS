//
//  SecViewController.m
//  Lab4-DrinkShop
//
//  Created by 張力元 on 2019/2/1.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "SecViewController.h"

@interface SecViewController ()
@property (strong, nonatomic) IBOutlet UILabel *showDataLabel;
@property (strong, nonatomic) IBOutlet UITextField *testTextField;

@end

@implementation SecViewController

- (void)loadView{
    [super loadView];
    NSLog(@"VC%d loadView",_count);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"VC%d viewDidLoad",_count);
    _showDataLabel.text = _data;
    //可撰寫在這個View Controller只會執行一次的程式
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"VC%d viewWillAppear",_count);
    //每次都會在這個View Controller出現前執行(多次)
    //可用來整理畫面上的元件
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"VC%d viewDidAppear",_count);
    //接續在viewWillAppear後執行(多次)
    //可用來顯示畫面的動畫
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"VC%d viewWillDisappear",_count);
    //觸發離開View Controller時會執行
    //可用來儲存畫面設定
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"VC%d viewDidDisappear",_count);
    //離開View Controller後會執行
    //仍可於背景控制元件，等到下次進入時才會被使用者發現
}

- (void)dealloc{
    NSLog(@"VC%d dealloc",_count);
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    NSLog(@"VC%d didReceiveMemoryWarning",_count);
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        //iOS 6.0後的版本才需要紀自行釋放記憶體
        if (self.isViewLoaded && !self.view.window)// 是否是正在顯示
        {
            self.view = nil;// 使下次進入時可以呼叫viewDidLoad
        }
    }
}

- (IBAction)aaa:(id)sender {
    NSLog(@"使用者觸發下一頁");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecViewController *aa = [storyboard instantiateViewControllerWithIdentifier:@"SecViewController"];
//    aa.modalTransitionStyle = (_count+1) % 4;
    aa.count = _count+1;
    NSLog(@"VC%d init",aa.count);
    [self presentViewController:aa animated:true completion:nil];
}

- (IBAction)bbbb:(id)sender {
    NSLog(@"使用者觸發上一頁");
    [self dismissViewControllerAnimated:true completion:nil];
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)ccccc:(id)sender {
    //    NSLog(@"%@",NSStringFromClass([self.presentingViewController class]));
    if([self.presentingViewController isKindOfClass:[SecViewController class]]){
        SecViewController *bb = (SecViewController *)self.presentingViewController;
        [bb didReceiveMemoryWarning];
    }
}

- (IBAction)change:(UITextField *)textField {
    NSString *lastTitle = textField.text;
    if (_block) {
        _block(lastTitle);
    }
    else{
        [_delegate changeTitle:lastTitle];
    }
    
    
}


@end
