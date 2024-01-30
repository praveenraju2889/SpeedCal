//
//  ViewController.swift
//  SpeedCal
//
//  Created by Praveen Raju on 29/01/24.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController ,CLLocationManagerDelegate,MKMapViewDelegate{

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var topSpeedLabel: UILabel!
        
    var topSpeed: CLLocationSpeed = 0.0
        var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        mapView.showsUserLocation = true
        mapView.delegate = self;
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }

        
            let speedInMetersPerSecond = location.speed
            let speedInKilometersPerHour = speedInMetersPerSecond * 3.6

            let formattedSpeed = String(format: "%.2f", speedInKilometersPerHour)
            //speedLabel.text = "\(formattedSpeed) km/h"
        
        
        let speedAnnotation = SpeedAnnotation(coordinate: location.coordinate, title: "Current Speed", subtitle: formattedSpeed, speed: speedInMetersPerSecond)

           mapView.addAnnotation(speedAnnotation)
        // Update top speed if the current speed is higher
                if speedInMetersPerSecond > topSpeed {
                    topSpeed = speedInMetersPerSecond
                    let formattedTopSpeed = String(format: "%.2f", topSpeed * 3.6)
                    topSpeedLabel.text = "\(formattedTopSpeed) km/h"
                }
        
        
                
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                mapView.setRegion(region, animated: true)
        
        
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error: \(error.localizedDescription)")
        }
    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? SpeedAnnotation else { return nil }

        let identifier = "SpeedAnnotationView"
        var annotationView: SpeedAnnotationView!

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? SpeedAnnotationView {
            // Reuse existing view
            dequeuedView.annotation = annotation
            annotationView = dequeuedView
        } else {
            // Create a new view if no reusable view is available
            annotationView = SpeedAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }

        // Update the speed label on the annotation view
        let speedInKilometersPerHour = annotation.speed * 3.6
        let formattedSpeed = String(format: "%.2f km/h", speedInKilometersPerHour)
        annotationView.speedLabel.text = formattedSpeed

        // Print statements for debugging
        print("Speed label text set to:: \(String(describing: annotationView.speedLabel.text))")

        return annotationView
    }




}

