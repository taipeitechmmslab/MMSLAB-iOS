//
//  myCollectionViewCell.m
//  Lab7-ListDemo
//
//  Created by 張力元 on 2019/3/7.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "myCollectionViewCell.h"

@interface myCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation myCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setCellImage:(NSString *)imageName title:(NSString *)title{
    [_imgView setImage:[UIImage imageNamed:imageName]];
    _titleLabel.text = title;
}
@end
