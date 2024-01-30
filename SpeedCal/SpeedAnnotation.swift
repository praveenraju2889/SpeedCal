//
//  SpeedAnnotation.swift
//  SpeedCal
//
//  Created by Praveen Raju on 29/01/24.
//

import Foundation
import MapKit

class SpeedAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var speed: CLLocationSpeed

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, speed: CLLocationSpeed) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.speed = speed
    }
}
