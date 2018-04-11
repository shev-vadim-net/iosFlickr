//
//  FlickrPlaceShape.swift
//  iosFlickr
//
//  Created by Vadim on 11.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import Foundation
import CoreLocation

class FlickrPlaceShape {

    var coords: [CLLocationCoordinate2D]

    init(withCoords coords: CLLocationCoordinate2D...) {
        self.coords = coords
    }

    init(withCoords coords: [CLLocationCoordinate2D]) {
        self.coords = coords
    }

    convenience init(fromFlickrString coordsString: String) {
        var coords: [CLLocationCoordinate2D] = []
        for coordsPair in coordsString.components(separatedBy: " ") {
            let coordsPair = coordsPair.components(separatedBy: ",")
            if let latStr = coordsPair.first, let lat = CLLocationDegrees(latStr),
                let lonStr = coordsPair.last, let lon = CLLocationDegrees(lonStr) {
                coords.append(CLLocationCoordinate2D(latitude: lat, longitude: lon))
            }
        }
        self.init(withCoords: coords)
    }
}
