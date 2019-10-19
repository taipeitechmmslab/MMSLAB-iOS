//
//  ViewController.swift
//  lab10-1-2
//
//  Created by taizhou on 2019/7/30.
//  Copyright © 2019 taizhou. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    var annotationArr = [MKPointAnnotation]()
    var addAnnotationCount = 0
    var showIndex = 0
    static var location:CLLocationManager? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func addAnnotation(_ sender: Any) {
        addAnnotationCount+=1
        let annotation = MKPointAnnotation()
        let latLng = mapView.region.center
        annotation.coordinate = latLng
        annotation.title = String(format:"第%d個點",addAnnotationCount)
        showIndex = annotationArr.count
        mapView.addAnnotation(annotation)
        annotationArr.append(annotation)
        reflashMapView()
    }
    
    func reflashMapView(){
        mapView.removeOverlays(mapView.overlays)
        if(annotationArr.count>1){
            addPolyLine()
        }
        mapView.reloadInputViews()
    }
    
    func addPolyLine(){
        var linePoints = [CLLocationCoordinate2D]()
        for annotation in annotationArr {
            linePoints.append(annotation.coordinate)
        }
        print(linePoints.count)
        print(annotationArr.count)
        let line = MKPolyline(coordinates: linePoints, count: annotationArr.count)
        mapView.addOverlay(line)
    }
    
    @IBAction func removeAnnotation(_ sender: Any) {
        mapView.removeAnnotation(annotationArr[showIndex])
        annotationArr.remove(at: showIndex)
        if(showIndex>0){
            showIndex-=1
        }
        reflashMapView()
    }
    
    @IBAction func changeAnnotation(_ sender: UIButton) {
        if(annotationArr.count == 0){
            showMsg(msg: "請先新增標註")
        }
        else if(showIndex < annotationArr.count-1 && sender.tag == 1){
            showIndex+=1
            showAnnotation(annotation: annotationArr[showIndex])
        }
        else if(showIndex > 0 && sender.tag == 0){
            showIndex-=1
            showAnnotation(annotation: annotationArr[showIndex])
        }
        else{
            let str = String(format: "已經是%@個了",(sender.tag == 0) ? "第一個" : "最後一個")
            showMsg(msg: str)
        }
    }
    
    func showMsg(msg:String){
        let msgView = UIAlertController(title: msg, message: "", preferredStyle: .alert)
        let determineAction = UIAlertAction(title: "確定", style: .default, handler: nil)
        msgView.addAction(determineAction)
        present(msgView, animated: true, completion: nil)
    }
    
    func showAnnotation(annotation:MKPointAnnotation){
        //設定中心點為輸入的annotation座標
        let center = annotation.coordinate
        //設定經度與緯度的跨度
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        //將座標與跨度結合成一個region參數
        let region = MKCoordinateRegion(center: center, span: span)
        //設置region
        mapView.setRegion(region, animated: true)
    }
    
    
    @IBAction func showMyLocation(_ sender: Any) {
        print(mapView.showsUserLocation)
        if (ViewController.location == nil) {
            //在未設定定位權限時，要求使用者提供訂位權限給程式執行
            ViewController.location = CLLocationManager()
            ViewController.location?.requestWhenInUseAuthorization()
            ViewController.location?.startUpdatingLocation()
        }
        //設置地圖中心的座標為使用者的位置
        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
    }
    
    
    @IBAction func showAllAnnotation(_ sender: Any) {
        //讀取地圖上所有的標註
        let allAnnotations = mapView.annotations
        //顯示所有的標註
        mapView.showAnnotations(allAnnotations, animated: true)
    }
    
    
    @IBAction func deleteAllAnnotation(_ sender: Any) {
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
        annotationArr.removeAll()
    }
    
}

extension ViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool){
        print("地圖完成改變顯示範圍")
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
        if(overlay.isKind(of: MKPolyline.self)){
            let lineView = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            lineView.strokeColor = UIColor.red
            lineView.lineWidth = 10
            return lineView as MKOverlayRenderer
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        print(view.annotation?.title as Any)
        for annotation in annotationArr {
            if(annotation.isEqual(view.annotation) ){
                showAnnotation(annotation: annotation)
                break
            }
        }
    }
}
