//
//  MyTableViewCell.m
//  Lab7-ListDemo
//
//  Created by 張力元 on 2019/3/6.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation MyTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCellImage:(NSString *)imageName title:(NSString *)title{
    [_myImageView setImage:[UIImage imageNamed:imageName]];
    _titleLabel.text = title;
}
@end
