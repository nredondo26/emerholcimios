//
//  mapa.swift
//  emerholcim
//
//  Created by nerb2019 on 6/15/19.
//

import UIKit
import MapKit

class mapa: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapa: MKMapView!
    var latitudrecibido:String?
    var longitudrecibido:String?
    
    var uno: Double?
    var dos: Double?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uno = (latitudrecibido! as NSString).doubleValue
        dos = (longitudrecibido! as NSString).doubleValue
        
   //     print("\(uno!) y \(dos!)")
        
        mapa.delegate = self
        mapa.showsScale = true
        mapa.showsPointsOfInterest = true
        mapa.showsUserLocation = true
    
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        let sorceCoordinates = locationManager.location?.coordinate
        //let sorceCoordinates  = CLLocationCoordinate2DMake(4.7361074, -74.0934025)
        let destCoordinates = CLLocationCoordinate2DMake(uno!, dos!)
        
        let sorcePlacemark = MKPlacemark(coordinate: sorceCoordinates!)
        let destPlacemark = MKPlacemark(coordinate: destCoordinates)
        
        let sorceItem = MKMapItem(placemark: sorcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sorceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: { response , error in
            
            guard let response = response else {
                if error != nil {
                    print("\(String(describing: error))")
                }
                return
            }
            
            let route = response.routes [0]
            self.mapa.addOverlay(route.polyline, level: .aboveRoads )
            
            let rekt = route.polyline.boundingMapRect
            self.mapa.setRegion(MKCoordinateRegion(rekt), animated: true)
            
        })
    
    }
   
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    
    
}
