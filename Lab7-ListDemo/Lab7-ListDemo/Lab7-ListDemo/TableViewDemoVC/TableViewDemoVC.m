//
//  TableViewDemoVC.m
//  Lab7-ListDemo
//
//  Created by 張力元 on 2019/3/4.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "TableViewDemoVC.h"
#import "MyTableViewCell.h"

@interface TableViewDemoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSArray *fruitNameArr;
@end

@implementation TableViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _fruitNameArr = [userDefaults arrayForKey:@"friutName"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //設定每個Section有幾筆資料要顯示
    if (section == 0)
        return _fruitNameArr.count;
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //設定每個Cell要顯示的資料與畫面
    //Cell的重複利用機制 可以節省記憶體 將移出畫面的Cell移至即將移入畫面的Cell做使用
    //reuse ID需與init時相同
    if (indexPath.section == 0) {
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
        if (cell == nil) {
            //若沒有可用的Cell 則初始化一個Cell並設定reuse ID
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        NSString *friut = _fruitNameArr[indexPath.row];
        [cell setCellImage:friut title:friut];
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell"];
        NSLog(@"%@",cell);
        if (cell == nil) {
            //若沒有可用的Cell 則初始化一個Cell並設定reuse ID
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseCell"];
        }
        //設定Cell的內容
        cell.textLabel.text = [NSString stringWithFormat:@"第%d個Cell",(int)indexPath.row];
        //輸出設定完成的Cell
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //設定要幾個Section  若不設定則為1
    return 2;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //設定section上方的title
    if (section == 0) {
        return @"客製化Table View Cell";
    }
    return @"系統內建的Table View Cell";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //設定section上方的高度
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //點擊某個Cell執行的動作
    NSLog(@"你點擊了 %d-%d 的Cell",(int)indexPath.section,(int)indexPath.row);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Cell 的高為 %d",(int)cell.bounds.size.height);
    //取消選取的動畫
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
}
@end
