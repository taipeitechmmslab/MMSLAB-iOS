//
//  HomeVC.m
//  Lab13-API
//
//  Created by 張力元 on 2019/4/29.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "HomeVC.h"
#import "MRTModel.h"
#import <YYModel.h>

@interface HomeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MRTModel *data;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)getDataFromAPI:(id)sender {
    //建立一個Request並設定其URL
    NSString *urlString = @"https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=55ec6d6e-dc5c-4268-a725-d04cc262172b";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //將此Request的傳遞方式設定為Get
    [request setHTTPMethod:@"Get"];
    //建立一個NSURLSession物件
    NSURLSession *sess = [NSURLSession sharedSession];
    //使用request與Block初始化task，並設定Block內的程式
    NSURLSessionDataTask *task = [sess dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            //發送失敗執行
            NSLog(@"發送失敗");
        }
        else{
            //發送成功執行
            NSLog(@"發送成功");
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //將收到的資料寫入至data參數中，並於主執行緒上更新Table View的畫面
            dispatch_async(dispatch_get_main_queue(), ^{
                self->_data = [MRTModel yy_modelWithDictionary:jsonDic];
                [self->_tableView reloadData];
            });
        }
    }];
    //啟動此task執行Http連線
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.result.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell"];
    if (cell == nil) {
        //若沒有可用的Cell 則初始化一個Cell並設定reuse ID
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseCell"];
    }
    results *data = _data.result.results[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",data.Station];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",data.Destination];
    return cell;
}

@end
