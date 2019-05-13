//
//  ViewController.m
//  Lab13-API
//
//  Created by 張力元 on 2019/4/29.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "ViewController.h"
#import "Data.h"
#import <YYModel.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self toJson];
    [self toObject];
}

- (void)toJson{
    //Step1:建立一個物件，並放入資料至物件中
    Data *data = [Data new];
    data.myNumber = 123;
    data.myString = @"abc";
    //Step2:使用「yy_modelToJSONObject」函式將物件轉為Json的字串
    NSString *json = [data yy_modelToJSONString];
    
    NSLog(@"%@",json);
}

- (void)toObject{
    //Step1:準備一個JSON字串
    NSString *json = @"{\"myString\":\"abc\",\"myNumber\":123}";
    //Step2：使用「yy_modelWithJSON:」函式將輸入的json字串以Data物件的格式做轉換並輸出物件
    Data *data = [Data yy_modelWithJSON:json];
}

- (void)httpGetSimple{
    //建立一個Request並設定其URL
    NSString *urlString = @"https://jsonplaceholder.typicode.com/comments?postId=1";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //將此Request的傳遞方式設定為Post
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
            NSString *str = [[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"%@",str);
        }
    }];
    //啟動此task執行Http連線
    [task resume];
}

- (void)httpPostSimple:(NSString *)json{
    //建立一個Request並設定其URL
    NSString *urlString = @"https://gurujsonrpc.appspot.com/guru";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //將此Request的傳遞方式設定為Post
    [request setHTTPMethod:@"POST"];
    //設定使用Json格式的字串設定Body的資料
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = bodyData;
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
            NSString *str = [[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"%@",str);
        }
    }];
    //啟動此task執行Http連線
    [task resume];
}


@end
