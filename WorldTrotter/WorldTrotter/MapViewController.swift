//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by James Dunn on 12/30/20.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let margins = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        let locationButton = UIButton(type: .system)
        locationButton.addTarget(self, action: #selector(getUserLocation(_:)), for: .touchUpInside)
        locationButton.setTitle("BUTTON", for: .normal)
        locationButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        locationButton.layer.cornerRadius = 5
        locationButton.layer.borderWidth = 1
        locationButton.layer.borderColor = CGColor(red: 130, green: 180, blue: 200, alpha: 1)
        locationButton.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        locationButton.setImage(UIImage(named: "location"), for: .normal)
        locationButton.sizeToFit()
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(locationButton)
        
        let buttonTop = locationButton.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10)
        let buttonLeft = locationButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        buttonTop.isActive = true
        buttonLeft.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    @objc func getUserLocation(_ sender: UIButton) {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        guard let userLocation = locationManager.location else { return }
        
        mapView.delegate = self
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(region, animated: true)
        
        let point = MKPointAnnotation()
        point.coordinate = userLocation.coordinate
        point.title = "Your location"
        point.title = "My Location"
        
        mapView.addAnnotation(point)
        
    }
}
