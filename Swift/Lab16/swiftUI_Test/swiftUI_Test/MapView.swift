//
//  MapView.swift
//  swiftUI_Test
//
//  Created by 張力元 on 2019/10/14.
//  Copyright © 2019 張力元. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var location = CLLocationCoordinate2D(
    latitude: 25.042360, longitude: 121.535497)
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        view.setRegion(region, animated: true)
        
        let annotation = MyAnnotation(coordinate: location)
        view.addAnnotation(annotation)
    }
}

final class MyAnnotation: NSObject, MKAnnotation {
    var id: String = ""
    var title: String? = nil
    var coordinate: CLLocationCoordinate2D
    init(_ id:String="",_ title:String?=nil,coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.coordinate = coordinate
    }
}

struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


