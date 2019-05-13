//
//  ViewController.m
//  Lab10-MKMap
//
//  Created by 張力元 on 2019/3/23.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapview;
@property (strong, nonatomic) NSMutableArray<MKPointAnnotation *> *annotationArr;
@property (assign, nonatomic) int addAnnotationCount;
@property (assign, nonatomic) int showIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _showIndex = 0;
    _addAnnotationCount = 0;
    _annotationArr = [NSMutableArray<MKPointAnnotation *> new];
}

- (IBAction)addAnnotation:(id)sender {
    _addAnnotationCount++;
    //初始化編標註物件
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    //設定座標為地圖中心
    CLLocationCoordinate2D latLng = _mapview.region.center;
    [annotation setCoordinate:latLng];
    //設定標題
    annotation.title = [NSString stringWithFormat:@"第%d點",_addAnnotationCount];
    _showIndex = (int)_annotationArr.count;
    //加入至地圖上
    [_mapview addAnnotation:annotation];
    [_annotationArr addObject:annotation];
    [self reflashMapView];
}

- (void)reflashMapView{
    //移除所有的折線
    [_mapview removeOverlays:_mapview.overlays];
    if (_annotationArr.count>1)
        [self addPolyLine];
    //刷新地圖
    [_mapview reloadInputViews];
}

- (void)addPolyLine{
    //依照annotationArr內的標註數量加入折線
    CLLocationCoordinate2D linePoint[_annotationArr.count];
    for (int i=0; i<_annotationArr.count; i++)
        linePoint[i] = _annotationArr[i].coordinate;
    MKPolyline *line = [MKPolyline polylineWithCoordinates:linePoint count:_annotationArr.count];
    [_mapview addOverlay:line];
}

- (IBAction)removeAnnotation:(id)sender {
    //移除單個編標註
    [_mapview removeAnnotation:_annotationArr[_showIndex]];
    //從陣列中移除所選的標註
    [_annotationArr removeObjectAtIndex:_showIndex];
    if (_showIndex>0)
        _showIndex--;
    //刷新地圖
    [self reflashMapView];
}

- (IBAction)changeAnnotation:(UIButton *)btn{
    if (_annotationArr.count == 0)
        [self showMsg:@"請先新增標註"];
    else if (_showIndex<_annotationArr.count-1 && btn.tag == 1){
        //下一個標註
        _showIndex++;
        //顯示指定的標註
        [self showAnnotation:_annotationArr[_showIndex]];
    }
    else if (_showIndex>0 && btn.tag == 0){
        //上一個標註
        _showIndex--;
        //顯示指定的標註
        [self showAnnotation:_annotationArr[_showIndex]];
    }
    else{
        NSString *msg = [NSString stringWithFormat:@"已經是%@了",(btn.tag == 0)?@"第一個":@"最後一個"];
        [self showMsg:msg];
    }
}

//用於在地圖上顯示指定的標註
- (void)showAnnotation:(MKPointAnnotation *)annotation{
    CLLocationCoordinate2D center = annotation.coordinate;
    //Span內含有：緯度誇度、經度誇度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    //region內含有：坐標(coordinate)、比例尺(Span)
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    //設定region
    [_mapview setRegion:region animated:true];
}

//使用Alert顯示輸入的提示文字
- (void)showMsg:(NSString *)msg{
    UIAlertController *msgView = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",msg] message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [msgView addAction:determineAction];
    [self presentViewController:msgView animated:true completion:nil];
}

- (IBAction)showMyLocation:(id)sender {
    NSLog(@"%d",_mapview.showsUserLocation);
    static CLLocationManager *locationManager;
    if (!locationManager){
        //在未設定定位權限時，要求使用者提供訂位權限給程式執行
        locationManager = [CLLocationManager new];
        [locationManager requestWhenInUseAuthorization];
        [locationManager startUpdatingLocation];
    }
    [_mapview setCenterCoordinate:_mapview.userLocation.location.coordinate animated:true];
}

- (IBAction)showAllAnnotation:(id)sender {
    //讀取地圖上所有的標註
    NSMutableArray *allAnnotation =(NSMutableArray *) _mapview.annotations;
    //顯示所有的標註
    [_mapview showAnnotations:allAnnotation animated:true];
}

- (IBAction)deleteAllAnnotation:(id)sender {
    _addAnnotationCount = 0;
    //讀取地圖上所有的標註
    NSMutableArray *allAnnotation =(NSMutableArray *) _mapview.annotations;
    //移除多個的標註
    [_mapview removeAnnotations:allAnnotation];
    [_annotationArr removeAllObjects];
    [self reflashMapView];
}



#pragma map view delegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *lineView = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
        //設定折線的顏色與寬度
        lineView.strokeColor = [UIColor redColor];
        lineView.lineWidth=10;
        return lineView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    //點擊標註
    NSLog(@"%@",view.annotation.title);
    //設定顯示標註為目前選擇的標註
    for (int i=0; i<_annotationArr.count; i++) {
        if ([view.annotation isEqual:_annotationArr[i]]) {
            _showIndex = i;
            [self showAnnotation:_annotationArr[i]];
            break;
        }
    }
}

@end
