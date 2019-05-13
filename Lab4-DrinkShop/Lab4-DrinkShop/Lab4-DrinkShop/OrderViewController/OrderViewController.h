//
//  OrderViewController.h
//  Lab4-DrinkShop
//
//  Created by 張力元 on 2019/2/13.
//  Copyright © 2019 張力元. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@protocol OrderViewDelegate <NSObject>
//公告要委派的任務
- (void)sendOrder:(drink *)myOrder;
@end

@interface OrderViewController : UIViewController
@property (strong, nonatomic) drink *myDrink;
@property (strong, nonatomic) id<OrderViewDelegate> delegate;
@end
