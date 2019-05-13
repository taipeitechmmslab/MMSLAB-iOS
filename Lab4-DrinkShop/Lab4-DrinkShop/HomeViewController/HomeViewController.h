//
//  HomeViewController.h
//  Lab4-DrinkShop
//
//  Created by 張力元 on 2019/2/13.
//  Copyright © 2019 張力元. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//設定飲料有哪些資訊要傳遞
@interface drink : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *sweetness;
@property (assign, nonatomic) int sweetSelectIndex;
@property (strong, nonatomic) NSString *ice;
@property (assign, nonatomic) int iceSelectIndex;
@property (assign, nonatomic) int price;
@end

@interface HomeViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
