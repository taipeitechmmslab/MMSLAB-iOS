//
//  OrderViewController.m
//  Lab4-DrinkShop
//
//  Created by 張力元 on 2019/2/13.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sweetnessSelect;
@property (strong, nonatomic) IBOutlet UISegmentedControl *iceSelect;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;

@end

@implementation OrderViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_myDrink) {
        //如果有傳入飲料資訊 要顯示要修改的飲料資訊
        _nameTextField.text = _myDrink.name;
        [_sweetnessSelect setSelectedSegmentIndex:_myDrink.sweetSelectIndex];
        [_iceSelect setSelectedSegmentIndex:_myDrink.iceSelectIndex];
        _priceTextField.text = [NSString stringWithFormat:@"%d",_myDrink.price];
    }
}

- (IBAction)sendBtnClick:(id)sender {
    if (!_myDrink) {
        //如果飲料物件沒有初始化 要初始化
        _myDrink = [[drink alloc]init];
    }
    //將要傳遞的資料寫入飲料物件
    _myDrink.name = _nameTextField.text;
    _myDrink.sweetSelectIndex = (int)_sweetnessSelect.selectedSegmentIndex;
    _myDrink.sweetness = [_sweetnessSelect titleForSegmentAtIndex:_myDrink.sweetSelectIndex];
    _myDrink.iceSelectIndex = (int)_iceSelect.selectedSegmentIndex;
    _myDrink.ice = [_iceSelect titleForSegmentAtIndex:_myDrink.iceSelectIndex];
    _myDrink.price = [_priceTextField.text intValue];
    //使用委派傳遞飲料物件
    [_delegate sendOrder:_myDrink];
    //返回上一頁
    [self.navigationController popViewControllerAnimated:true];
}

@end
