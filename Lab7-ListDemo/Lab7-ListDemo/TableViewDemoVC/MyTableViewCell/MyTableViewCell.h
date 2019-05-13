//
//  MyTableViewCell.h
//  Lab7-ListDemo
//
//  Created by 張力元 on 2019/3/6.
//  Copyright © 2019 張力元. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///客製化的Cell
@interface MyTableViewCell : UITableViewCell
- (void)setCellImage:(NSString *)imageName title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
