//
//  ViewController.swift
//  lab10
//
//  Created by 張力元 on 2019/8/20.
//  Copyright © 2019 張力元. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    static var location:CLLocationManager? = nil
    var pointArr = [[25.043775, 121.560642],[25.047945, 121.516941],[25.019982, 121.545314],[25.058198, 121.542477],[25.026799, 121.522885],[25.043775,121.560642]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showMyLocation(_ sender: Any) {
        if (ViewController.location == nil) {
            //在未設定定位權限時，要求使用者提供訂位權限給程式執行
            ViewController.location = CLLocationManager()
            ViewController.location?.requestWhenInUseAuthorization()
            ViewController.location?.startUpdatingLocation()
        }
        //宣告設定的跨度
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        //宣告設定的中心為使用者所在位置
        let center = mapView.userLocation.coordinate
        //使用中心與跨度設置範圍
        let region = MKCoordinateRegion(center: center, span: span)
        //設置地圖顯示的範圍
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func addAnnotation(_ sender: Any) {
        //移除折線
        mapView.removeOverlays(mapView.overlays)
        //初始化標註物件
        let annotation = MKPointAnnotation()
        //設定座標
        let latLng = CLLocationCoordinate2DMake(25.042331, 121.535486);
        annotation.coordinate = latLng
        //設定標題與副標題
        annotation.title = "臺北科技大學"
        annotation.subtitle = "台北市忠孝東路三段1號"
        //加入至地圖上
        mapView.addAnnotation(annotation)
        mapView.setCenter(annotation.coordinate, animated: true)
    }
    
    @IBAction func addPolyline(_ sender: Any) {
        //移除標註
        mapView.removeAnnotations(mapView.annotations)
        var linePoints = [CLLocationCoordinate2D]()
        //使用pointArr內的參數製作折線
        for point in pointArr {
            linePoints.append(CLLocationCoordinate2DMake(point[0], point[1]))
        }
        let line = MKPolyline(coordinates: linePoints, count: pointArr.count)
        mapView.addOverlay(line)
        mapView.setCenter(line.coordinate, animated: true)
    }
}

extension ViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
        if(overlay.isKind(of: MKPolyline.self)){
            let lineView = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            lineView.strokeColor = UIColor.red
            lineView.lineWidth = 10
            return lineView as MKOverlayRenderer
        }
        return MKOverlayRenderer()
    }
}



