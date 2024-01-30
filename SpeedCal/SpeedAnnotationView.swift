//
//  SpeedAnnotationView.swift
//  SpeedCal
//
//  Created by Praveen Raju on 29/01/24.
//

import Foundation
import MapKit

class SpeedAnnotationView: MKMarkerAnnotationView {

    var speedLabel: UILabel!

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        // Customize the appearance of the annotation view
        self.canShowCallout = false
        self.calloutOffset = CGPoint(x: 5, y: 5)

        // Create a label to display the speed
                setupSpeedLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func setupSpeedLabel() {
            speedLabel = UILabel()
            speedLabel.font = UIFont.boldSystemFont(ofSize: 12)  // Adjust the font size as needed
            speedLabel.textColor = UIColor.blue
            speedLabel.backgroundColor = UIColor.secondarySystemBackground
            speedLabel.numberOfLines = 0
            addSubview(speedLabel)  // Add the label as a subview
        }
    
    override func prepareForDisplay() {
           super.prepareForDisplay()

           // Position the speed label below the pin
           speedLabel.frame = CGRect(x: -15, y: 25, width: 60, height: 50)
           speedLabel.textAlignment = .center
        
       }
}

