//
//  MatrixCountVC.m
//  Lab8-Queue&Async
//
//  Created by 張力元 on 2019/3/15.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "MatrixCountVC.h"

@interface MatrixCountVC ()
@property (strong, nonatomic) IBOutlet UILabel *matrix1Lable;
@property (strong, nonatomic) IBOutlet UILabel *matrix2Lable;
@property (strong, nonatomic) IBOutlet UILabel *matrix3Lable;
@property (strong, nonatomic) IBOutlet UIButton *startBtn;
@property (strong, nonatomic) NSMutableArray<NSMutableArray *> *matrix1;
@property (strong, nonatomic) NSMutableArray<NSMutableArray *> *matrix2;
@property (strong, nonatomic) NSMutableArray<NSMutableArray *> *matrix3;
@end

@implementation MatrixCountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)creatMatrix:(UIButton *)btn {
    _startBtn.enabled = false;
    //初始化
    _matrix1 = [NSMutableArray new];
    for (int i=0; i<10; i++) {
        NSMutableArray *tempArr = [NSMutableArray new];
        [_matrix1 addObject:tempArr];
    }
    _matrix2 = [NSMutableArray new];
    for (int i=0; i<10; i++) {
        NSMutableArray *tempArr = [NSMutableArray new];
        [_matrix2 addObject:tempArr];
    }
    _matrix1Lable.text = @"";
    _matrix2Lable.text = @"";
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t secQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    //建立一個佇列組
    dispatch_group_t groupQueue = dispatch_group_create();
    NSLog(@"開始");
    dispatch_group_async(groupQueue,secQueue, ^{
        //新增陣列一內的元素
        for (int i=0; i<10; i++) {
            for (int j=0; j<10; j++) {
                int element = arc4random()%9+1;
                [self.matrix1[i] addObject:[NSNumber numberWithInt:element]];
                usleep(50000);
                [self showMatrix:1 data:element];
            }
            [self showMatrix:1 data:-1];//換行
        }
    });
    dispatch_group_async(groupQueue,secQueue, ^{
        //新增陣列二內的元素
        for (int i=0; i<10; i++) {
            for (int j=0; j<10; j++) {
                int element = arc4random()%9+1;
                [self.matrix2[i] addObject:[NSNumber numberWithInt:element]];
                usleep(80000);
                [self showMatrix:2 data:element];
            }
            [self showMatrix:2 data:-1];//換行
        }
    });
    dispatch_group_notify(groupQueue, mainQueue, ^{
        //產生完成，開始計算乘法
        NSLog(@"兩個陣列生成完畢");
        [self multiplicationArray];
        
    });
}

- (void)multiplicationArray{
    _matrix3Lable.text = @"";
    _matrix3 = [NSMutableArray new];
    for (int i=0; i<10; i++) {
        NSMutableArray *tempArr = [NSMutableArray new];
        [_matrix3 addObject:tempArr];
    }
    //矩陣的乘法：matrix1列向量 · matrix2行向量
    dispatch_queue_t secQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_async(secQueue, ^{
        for (int i=0; i<self.matrix1.count; i++) {
            //取得matrix1的行向量
            NSMutableArray *matrix1Row = self.matrix1[i];
            for (int j=0; j<self.matrix2[i].count; j++) {
                //取得matrix2的列向量
                NSMutableArray *matrix2Col = [NSMutableArray new];
                for (int k=0; k<self.matrix2.count; k++) {
                    [matrix2Col addObject:self.matrix2[k][j]];
                }
                //向量內積
                int dotValue = [self dotVector1:matrix1Row vector2:matrix2Col];
                [self.matrix3[i] addObject:[NSNumber numberWithInt:dotValue]];
                [self showMatrix:3 data:dotValue];
                usleep(50000);
            }
            [self showMatrix:3 data:-1];//換行
        }
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{//計算完要把按鈕打開
            self.startBtn.enabled = true;
        });
    });
}

- (void)showMatrix:(int)index data:(int)data{
    //data = -1則換行
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        if (data == -1) {
            if (index == 1)
                self.matrix1Lable.text = [NSString stringWithFormat:@"%@\n",self.matrix1Lable.text];
            else if (index == 2)
                self.matrix2Lable.text = [NSString stringWithFormat:@"%@\n",self.matrix2Lable.text];
            else
                self.matrix3Lable.text = [NSString stringWithFormat:@"%@\n",self.matrix3Lable.text];
        }
        else if (index == 1)
            self.matrix1Lable.text = [NSString stringWithFormat:@"%@%d ",self.matrix1Lable.text,data];
        else if (index == 2)
            self.matrix2Lable.text = [NSString stringWithFormat:@"%@%d ",self.matrix2Lable.text,data];
        else
            self.matrix3Lable.text = [NSString stringWithFormat:@"%@%d ",self.matrix3Lable.text,data];
    });
}

- (int)dotVector1:(NSMutableArray *)vector1 vector2:(NSMutableArray *)vector2{
    int dotValue = 0;
    for (int i=0; i<vector1.count; i++) {
        //內積=vectory1[0]*vectory2[0]+.....+vectory1[n]*vectory2[n]
        dotValue = dotValue + [vector1[i] intValue]*[vector2[i] intValue];
    }
    return dotValue;
}
@end
