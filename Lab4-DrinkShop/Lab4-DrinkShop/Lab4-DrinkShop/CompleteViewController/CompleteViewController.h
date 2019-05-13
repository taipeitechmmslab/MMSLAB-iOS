//
//  CompleteViewController.h
//  Lab4-DrinkShop
//
//  Created by 張力元 on 2019/2/13.
//  Copyright © 2019 張力元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

//Block變數類型：寫在interface外面
typedef void (^reseatBlock)(NSString *);

@interface CompleteViewController : UIViewController
//傳入的飲料物件
@property (strong, nonatomic) drink *myDrink;
//Block變數名稱：宣告在interface裡面
@property (copy, nonatomic) reseatBlock block;
@end
