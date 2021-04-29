//
//  ViewController.swift
//  CoreLocationTest
//
//  Created by Umut Sever on 27.04.2021.
//

import UIKit
import CoreLocation
import MapKit


class CoreLocationController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest 
        locationManager.distanceFilter = 0.0
        
        
        
        //Permission Request
        
        locationManager.requestWhenInUseAuthorization()
        
        
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        
        
        mapView.delegate = self
        
        
        
        
        
        //Mapkit
        let appleStoreAnnotation = LocationAnnotation(title: "Apple Square", coordinate: CLLocationCoordinate2D(latitude: 37.7861369, longitude: -122.4089195))
        
        let blueCoffer = LocationAnnotation(title: "Blue Coffee Square", coordinate: CLLocationCoordinate2D(latitude: 37.7763291, longitude: -122.4254317))
        
        
        mapView.addAnnotations([appleStoreAnnotation, blueCoffer])
        
        displayRoute(sourceCoordinate: appleStoreAnnotation.coordinate, destinationCoordinate: blueCoffer.coordinate)
        
        
        //mapView.addAnnotation(appleStoreAnnotation)
        //mapView.setCenter(appleStoreAnnotation.coordinate, animated: true)
        
        
        
    } //VC Ends Here
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
    
    //Display route
    func displayRoute(sourceCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        //Placemarks
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        //Directions
        let directionRequest = MKDirections.Request()
        
        directionRequest.source = MKMapItem(placemark: sourcePlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            if let error = error {
                print("\(error), kaynaklı bir hata oluştur")
                return
            }
            
            if let response = response {
                let route = response.routes.first!
                //Drawing the rouse on the map
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                //Zoom in and center the map's visinle region on the rouse
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 80.0, left: 80.0, bottom: 80.0, right: 80.0), animated: false)
                
                
            }
            
        }
        
        
    }
    
    
    
    
    //First time permission requested
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        
        print("locationn update \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }


}

