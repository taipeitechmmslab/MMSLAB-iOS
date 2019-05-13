//
//  HomeVC.m
//  Lab12-BookStore
//
//  Created by 張力元 on 2019/4/26.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "HomeVC.h"
#import <Realm.h>
#import <Toast.h>
#import "BookTable.h"

@interface HomeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) RLMResults<BookTable *> *bookTableArr;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //讀取資料庫中的BookTable內所有資料
    _bookTableArr = [BookTable allObjects];
    //使用NSLog打印出資料庫的檔案位置
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //Cell的數量為bookTableArr內的資料數量
    return _bookTableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell"];
    if (cell == nil) {
        //若沒有可用的Cell 則初始化一個Cell並設定reuse ID
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseCell"];
    }
    //設定Cell的textLabel文字顯示為資料表內相對序號的「書名」資料
    cell.textLabel.text = _bookTableArr[indexPath.row].bookName;
    //設定Cell的detailTextLabel文字顯示為資料表內相對序號的「售價」資料
    cell.detailTextLabel.text = [NSString stringWithFormat:@"售價：%d元",_bookTableArr[indexPath.row].price];
    //輸出設定完成的Cell
    return cell;
}

- (IBAction)addNewBook:(id)sender {
    //初始化書籍資料，設定書名與售價
    BookTable *bookData = [BookTable new];
    bookData.bookName = _nameTextField.text;
    bookData.price = [_priceTextField.text intValue];
    //使用默認的realm資料庫
    RLMRealm *realmDB = [RLMRealm defaultRealm];
    //使用原生的「transactionWithBlock:」函式，於函式的Block內使用realm資料庫原生的「addObject:」函式，將新增的資料添加至資料庫中
    [realmDB transactionWithBlock:^{
        [realmDB addObject:bookData];
    }];
    //重新取得BookTable內所有資料
    _bookTableArr = [BookTable allObjects];
    //重新載入Table View
    [_tableView reloadData];
    //使用Taost顯示新增的書名與價格
    [self.view makeToast:[NSString stringWithFormat:@"新增書名：%@ 價格:%d",bookData.bookName,bookData.price]];
}

- (IBAction)editBook:(id)sender {
    RLMResults<BookTable *> *searchData;
    if ([_nameTextField.text isEqualToString:@""]){
        //使用Taost顯示輸入書名提示
        [self.view makeToast:@"請輸入書名"];
        //返回不執行以下程式
        return;
    }
    //設定查詢描述
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"bookName == %@",_nameTextField.text];
    //取得查詢結果
    searchData = [BookTable objectsWithPredicate:pred];
    //讀取資料庫
    RLMRealm *realmDB = [RLMRealm defaultRealm];
    //編輯開始
    [realmDB beginWriteTransaction];
    //將查詢結果內所有資料的價錢參數設定為輸入的價錢
    for (int i=0; i<searchData.count; i++) {
        searchData[i].price = [_priceTextField.text intValue];
    }
    //確認編輯成果
    [realmDB commitWriteTransaction];
    //重新取得BookTable內所有資料
    _bookTableArr = [BookTable allObjects];
    //重新載入Table View
    [_tableView reloadData];
    //使用Taost顯示編輯成果
    [self.view makeToast:[NSString stringWithFormat:@"將 %@ 價格編輯為 %d元",_nameTextField.text,[_priceTextField.text intValue]]];
}

- (IBAction)removeBook:(id)sender {
    RLMResults<BookTable *> *searchData;
    if ([_nameTextField.text isEqualToString:@""]){
        //使用Taost顯示輸入書名提示
        [self.view makeToast:@"請輸入書名"];
        //返回不執行以下程式
        return;
    }
    //設定查詢描述
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"bookName == %@",_nameTextField.text];
    //取得查詢結果
    searchData = [BookTable objectsWithPredicate:pred];
    //讀取資料庫
    RLMRealm *realmDB = [RLMRealm defaultRealm];
    //編輯開始
    [realmDB beginWriteTransaction];
    //將查詢結果從資料庫中移除
    [realmDB deleteObjects:searchData];
    //確認編輯成果
    [realmDB commitWriteTransaction];
    //重新取得BookTable內所有資料
    _bookTableArr = [BookTable allObjects];
    //重新載入Table View
    [_tableView reloadData];
    //使用Taost顯示移除項目
    [self.view makeToast:[NSString stringWithFormat:@"將 %@ 移除",_nameTextField.text]];
}

- (IBAction)searchBook:(id)sender{
    //判斷是否有輸入書名
    if ([_nameTextField.text isEqualToString:@""]){
        //沒輸入書名則顯示全部結果
        _bookTableArr = [BookTable allObjects];
    }
    else{
        //有輸入書名則設定搜尋描述，將資料表內資料書名含有輸入書名字串的結果回傳至bookTableArr中
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"bookName CONTAINS %@",_nameTextField.text];
        _bookTableArr = [BookTable objectsWithPredicate:pred];
    }
    //重新載入Table View
    [_tableView reloadData];
    //使用Toast顯示查詢結果
    [self.view makeToast:[NSString stringWithFormat:@"共有%d筆資料",(int)_bookTableArr.count]];
}


@end
