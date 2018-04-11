//
//  FlickrPlace.swift
//  iosFlickr
//
//  Created by Vadim on 09.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import Foundation
import CoreLocation

class FlickrPlace {

    let content, timezone, woe_name, woe_id, place_id: String
    let coords: CLLocationCoordinate2D

    init(content: String, timezone: String, woe_name: String, woe_id: String, place_id: String, lat: String, lon: String) {
        self.content = content
        self.timezone = timezone
        self.woe_name = woe_name
        self.woe_id = woe_id
        self.place_id = place_id
        self.coords = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat) ?? 0.0, longitude: CLLocationDegrees(lon) ?? 0.0)
    }
}
