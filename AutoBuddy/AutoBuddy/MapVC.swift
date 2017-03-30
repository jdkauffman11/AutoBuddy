//
//  MapVC.swift
//  AutoBuddy
//
//  Created by Jordan Kauffman on 3/21/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class MapVC: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var navBar: UINavigationBar!
    private let regionRadius: CLLocationDistance = 25000
    @IBOutlet var mapView: MKMapView!
    let loc = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.backgroundColor = UIColor.white
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        navItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))
        
        setupLocation()
        searchMap()
        
    }
    
    func setupLocation()
    {
        let locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let loc = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(loc.coordinate, regionRadius, regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
    }

    
    func searchMap()
    {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Car Dealers"
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {(response, error) in
            
            if error != nil
            {
                print("Error occured in search: \(error!.localizedDescription)")
            }
            else if response!.mapItems.count == 0
            {
                print("No matches found")
            }
            else
            {
                for item in response!.mapItems {
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name!
                    annotation.subtitle = "Phone:\(item.phoneNumber!)"
                    
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
        
    }
    
    
    func backAction()
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
