//
//  LocationAnnotation.swift
//  CoreLocationTest
//
//  Created by Umut Sever on 27.04.2021.
//

import Foundation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
    
}
