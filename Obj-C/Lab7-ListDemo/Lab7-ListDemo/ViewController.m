//
//  ViewController.m
//  Lab7-ListDemo
//
//  Created by 張力元 on 2019/3/4.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *swichBtn;
@property (strong, nonatomic) IBOutlet UIView *tableViewContainer;
@property (strong, nonatomic) IBOutlet UIView *collectionViewContainer;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //一開始將Collection View的功能隱藏
    _collectionViewContainer.hidden = true;
    //初始化水果名稱陣列
    NSArray *friutArr = [[NSArray alloc]initWithObjects:@"apple",@"avocado",@"banana",@"cherries",@"coconut",@"grapes",@"lemon",@"orange",@"peach",@"pineapple",@"strawberry",@"tomato", nil];
    //儲存進UserDefault這個Dictionary中，方便之後讀取資料
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:friutArr forKey:@"friutName"];
}

- (IBAction)swichBtnClick:(id)sender {
    //判斷現在顯示的是TableView 還是CollectionView
    if (_swichBtn.tag == 0) {
        //顯示Collection View
        _swichBtn.tag = 1;
        _collectionViewContainer.hidden = false;
        _tableViewContainer.hidden = true;
        self.title = @"Demo Collection View";
    }
    else{
        //顯示Table View
        _swichBtn.tag = 0;
        _collectionViewContainer.hidden = true;
        _tableViewContainer.hidden = false;
        self.title = @"Demo Table View";
    }
}
@end
