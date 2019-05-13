//
//  CollectionViewDemoVC.m
//  Lab7-ListDemo
//
//  Created by 張力元 on 2019/3/4.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "CollectionViewDemoVC.h"
#import "myCollectionViewCell.h"

@interface CollectionViewDemoVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *fruitNameArr;
@end

@implementation CollectionViewDemoVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionViewInit];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _fruitNameArr = [userDefaults arrayForKey:@"friutName"];
}

- (void)collectionViewInit{
    //註冊要使用的Cell
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"myCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"myCollectionViewCell"];
    
    //註冊要使用的UICollectionReusableView
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //設定Collection View要顯示的Cell數量
    if (section == 0)return _fruitNameArr.count;
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //設定Collection View要顯示的Cell內容
    //初始化Cell
    if (indexPath.section == 0) {
        myCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCollectionViewCell" forIndexPath:indexPath];
        [cell setCellImage:_fruitNameArr[indexPath.row] title:_fruitNameArr[indexPath.row]];
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell)
        cell = [UICollectionViewCell new];
    //以下為設定Cell內容
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.text = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    label.textColor = [UIColor redColor];
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:label];
    return cell;
}

#pragma mark --UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //點選後要執行的動作
    NSLog(@"%d - %d",(int)indexPath.section,(int)indexPath.row);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    //設定左右間距
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    //設定上下間距
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    //設定Section Header的高度
    return CGSizeMake(collectionView.bounds.size.width, 50);
}

-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout*)collectionViewLayout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //回傳Collection View Cell的大小
    if (indexPath.section == 0) {
        //讓Collection View一排顯示三個
        //因此寬度為(Collection View的寬度-2個間距)/3
        int width = (_collectionView.frame.size.width-20)/3;
        return CGSizeMake(width,width*1.5);
    }
    //讓Collection View一排顯示五個
    return CGSizeMake((_collectionView.frame.size.width-40)/5, 50);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        //設定Section header要回傳的畫面
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.bounds.size.width, headerView.bounds.size.height)];
        label.text = (indexPath.section == 0)?@"客製化的Collection View Cell":@"原生的Collection View Cell";
        for (id subView in headerView.subviews) {
            [subView removeFromSuperview];
        }
        [headerView addSubview:label];
        return headerView;
    }
    return nil;
}
@end
