//
//  ViewController.m
//  Lab2-PaperScissorStone
//
//  Created by 張力元 on 2019/1/17.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *userSelectSegment;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *winnerLabel;
@property (strong, nonatomic) IBOutlet UILabel *mySelectLabel;
@property (strong, nonatomic) IBOutlet UILabel *pcSelectLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)startBtnClick:(id)sender {
    //點擊「猜拳」按鈕的監聽事件如下：
    //判斷是否有輸入姓名
    if (![_nameField.text isEqualToString:@""]) {
        //有輸入姓名，則顯示玩家姓名
        //使用nameField.text屬性讀取輸入的文字，將文字設定至nameLabel.text
        _nameLabel.text = [NSString stringWithFormat:@"名字\n%@",_nameField.text];
        //顯示我方出拳
        //使用getSelectByIndex副程式，將userSelectSegment所選的Index轉為字串，存放在mySelect字串變數中
        NSString *mySelect = [self getSelectByIndex:(int)_userSelectSegment.selectedSegmentIndex];
        //顯示我方出拳結果，將mySelect結果，顯示在mySelectLabel上
        _mySelectLabel.text = [NSString stringWithFormat:@"我方出拳\n%@",mySelect];
        //模擬電腦出拳，產生一個 0~2 之間的隨機整數
        int pcIndex = arc4random() % 3;
        //透過getSelectByIndex副程式，將產生的隨機整數轉為字串
        NSString *pcSelect = [self getSelectByIndex:pcIndex];
        //顯示電腦出拳結果於pcSelectLabel上
        _pcSelectLabel.text = [NSString stringWithFormat:@"電腦出拳\n%@",pcSelect];
        //讀取使用者所選擇的Index
        int selectIndex =(int)_userSelectSegment.selectedSegmentIndex;
        //執行showWinner副程式，判斷玩家的勝負
        [self showWinnerByMySelect:selectIndex andPCSelect:pcIndex];
    }
    else{
        //未輸入姓名則顯示提示
        _textLabel.text = @"請輸入玩家姓名";
    }
}

// - (輸出的類別)副程式名稱:(輸數參數的類別)輸入參數的名稱
- (NSString *)getSelectByIndex:(int)index{
    //出拳 index = 0:剪刀 1:石頭 2:布
    return [_userSelectSegment titleForSegmentAtIndex:index];
           //                 輸出的參數
}

//判斷勝負
- (void)showWinnerByMySelect:(int)myIndex andPCSelect:(int)pcIndex{
    if (myIndex == pcIndex){
        //平手
        _textLabel.text = @"平手，請再試一次";
        _winnerLabel.text = @"勝利者\n平手";
    }
    else if ((myIndex == 0 && pcIndex == 2)||
             (myIndex == 1 && pcIndex == 0)||
             (myIndex == 2 && pcIndex == 1)){
        //玩家獲勝
        _textLabel.text = @"恭喜你獲得勝利了！！！";
        _winnerLabel.text = [NSString stringWithFormat:@"勝利者\n%@",_nameField.text];
        
    }
    else{
        //電腦獲勝
        _textLabel.text = @"可惜，電腦獲勝了";
        _winnerLabel.text = @"勝利者\n電腦";
    }
}




@end
