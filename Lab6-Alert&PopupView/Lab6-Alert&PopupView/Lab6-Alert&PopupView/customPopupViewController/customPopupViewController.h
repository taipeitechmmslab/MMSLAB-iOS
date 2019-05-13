//
//  customPopupViewController.h
//  Lab6-Alert&PopupView
//
//  Created by 張力元 on 2019/2/25.
//  Copyright © 2019 張力元. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^selectHandler)(NSString *food);

@interface customPopupViewController : UIViewController
@property (copy, nonatomic) selectHandler block;
- (void)showInVC:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
