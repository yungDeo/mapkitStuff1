//
//  ViewController.swift
//  mapkitStuff
//
//  Created by MCS Devices on 1/3/18.
//  Copyright © 2018 MCS Devices. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    var locationManager: CLLocationManager!
    var userLocation: CLLocation?
    var userLocationPin: MKUserLocation?
    var Places: place?
    var NetworkManager:networkManager?
    var pointAnnnotation = [MKPointAnnotation?]()
    var deetail: Details?
    @IBOutlet weak var mapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager = networkManager()
        NetworkManager?.delegate = self as? NetworkManagerDelegate
        view.backgroundColor = .gray
        mapview.delegate = self as? MKMapViewDelegate
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    override func viewWillAppear(_ animated: Bool) {
        
        locationManager = CLLocationManager()
        enableLocationServices()
    }
    func enableLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        userLocationPin = MKUserLocation()
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedAlways, .authorizedWhenInUse :
            doLocationStuff()
            break
        case .restricted, .denied :
            
            break
        }
    }
    func doLocationStuff() {
        locationManager.startUpdatingLocation()
        mapview.showsUserLocation = true
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last! as CLLocation
        manager.stopUpdatingLocation()
        let latitude:String = "\(userLocation?.coordinate.latitude ?? 0)"
        let longitude:String = "\(userLocation?.coordinate.longitude ?? 0)"
        print("user latitude = \(latitude)")
        print("user longitude = \(longitude)")
        let viewRegion = MKCoordinateRegionMakeWithDistance((userLocation?.coordinate)!, 3500, 3500)
        NetworkManager?.downloadNearbyPlacesApi(latitude: latitude , longitude: longitude)
        mapview.setRegion(viewRegion, animated: true)
        
        
    }
    
}
extension ViewController: NetworkManagerDelegate {
    func didDownloadplaces(places: place){
        Places = places
       
        let q = Places?.results.count ?? 0
    
        for n in (0 ..< q) {
            let tmp = MKPointAnnotation()
            tmp.coordinate.latitude = (Places?.results[n].geometry.location.lat)!
            tmp.coordinate.longitude = (Places?.results[n].geometry.location.lng)!
            tmp.title = Places?.results[n].name
            pointAnnnotation.append( tmp)
            mapview.addAnnotation(tmp)
        }
        print(q)
        
    }
    
    
}
extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        deetail = Details()
        print( view.annotation?.title as Any)
        let q = Places?.results.count ?? 0
        for n in (0 ..< q) {
            if Places?.results[n].name == (view.annotation?.title)! {
                deetail?.name = Places?.results[n].name
                deetail?.opennow = Places?.results[n].opening_hours?.open_now
                deetail?.vincinity = Places?.results[n].vincinity
                 performSegue(withIdentifier: "detail", sender: self)
                
            }
        }
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dc = segue.destination as? DetailController  {
            dc.detail = deetail
        }
    }
}
