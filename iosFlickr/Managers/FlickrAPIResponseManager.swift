//
//  FlickrAPIResponseManager.swift
//  iosFlickr
//
//  Created by Vadim on 10.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import Foundation

class FlickrApiResponseManager {

    enum FlickrPlacesAPIResponse: String {
        case rootKey = "places"
        case objectKey = "place"
        case content = "_content"
        case timezone, woe_name, woe_id, place_id
    }

    static func parsePlacesResponseJSON(_ json: JSONResponse) -> [FlickrPlace] {
        if let placesObject = json[FlickrPlacesAPIResponse.rootKey.rawValue] as? JSONResponse,
            let placesArray = placesObject[FlickrPlacesAPIResponse.objectKey.rawValue] as? [JSONResponse] {

            return placesArray.map { (place) in
                let content = place[FlickrPlacesAPIResponse.content.rawValue] as? String ?? ""
                let timezone = place[FlickrPlacesAPIResponse.timezone.rawValue] as? String ?? ""
                let woe_name = place[FlickrPlacesAPIResponse.woe_name.rawValue] as? String ?? ""
                let woe_id = place[FlickrPlacesAPIResponse.woe_id.rawValue] as? String ?? ""
                let place_id = place[FlickrPlacesAPIResponse.place_id.rawValue] as? String ?? ""
                return FlickrPlace(content: content, timezone: timezone, woe_name: woe_name, woe_id: woe_id, place_id: place_id)
            }
        }
        return []
    }
}
