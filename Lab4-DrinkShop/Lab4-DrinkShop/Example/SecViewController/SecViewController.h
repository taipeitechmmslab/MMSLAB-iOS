//
//  SecViewController.h
//  Lab4-DrinkShop
//
//  Created by 張力元 on 2019/2/1.
//  Copyright © 2019 張力元. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//變數類型：寫在interface外面
typedef void (^changeTitleBlock)(NSString *);

//協議內容
@protocol SecViewControllerDelegate <NSObject>
//必定要執行的工作
@optional
//選擇性執行的工作
- (void)changeTitle:(NSString *)title;
@end

@interface SecViewController : UIViewController
@property (strong, nonatomic) NSString *data;
@property (assign, nonatomic) int count;
//變數名稱：宣告在interface裡面
@property (copy, nonatomic) changeTitleBlock block;

//Delegate變數：宣告在interface裡面
@property (assign, nonatomic) id<SecViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
