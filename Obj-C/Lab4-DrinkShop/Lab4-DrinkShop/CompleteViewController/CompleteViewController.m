//
//  CompleteViewController.m
//  Lab4-DrinkShop
//
//  Created by 張力元 on 2019/2/13.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "CompleteViewController.h"

@interface CompleteViewController ()
@property (strong, nonatomic) IBOutlet UILabel *orderLabel;
@end

@implementation CompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //顯示傳遞進來的飲料物件
    _orderLabel.text = [NSString stringWithFormat:@"您的飲料：%@\n甜度為：%@\n冰量為：%@\n售價：%d",_myDrink.name,_myDrink.sweetness,_myDrink.ice,_myDrink.price];
}

- (IBAction)backToHomePage:(id)sender {
    //傳回完成的提示
    _block(@"您的點餐已送出，\n請點選開始點餐進行下一次點餐作業");
    //關閉此頁
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
