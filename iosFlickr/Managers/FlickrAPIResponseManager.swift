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
        case woe_id = "woeid"
        case timezone, woe_name, place_id, latitude, longitude
    }

    enum FlickrShapeHistoryAPIResponse: String {
        case rootKey = "shapes"
        case objectKey = "shape"
        case polylinesKey = "polylines"
        case polylineObjectKey = "polyline"
        case content = "_content"
    }

    static func parsePlacesResponseJSON(_ json: JSONResponse?) -> [FlickrPlace] {
        if let json = json, let placesObject = json[FlickrPlacesAPIResponse.rootKey.rawValue] as? JSONResponse,
            let placesArray = placesObject[FlickrPlacesAPIResponse.objectKey.rawValue] as? [JSONResponse] {

            return placesArray.map { (place) in
                let content = place[FlickrPlacesAPIResponse.content.rawValue] as? String ?? ""
                let timezone = place[FlickrPlacesAPIResponse.timezone.rawValue] as? String ?? ""
                let woe_name = place[FlickrPlacesAPIResponse.woe_name.rawValue] as? String ?? ""
                let woe_id = place[FlickrPlacesAPIResponse.woe_id.rawValue] as? String ?? ""
                let place_id = place[FlickrPlacesAPIResponse.place_id.rawValue] as? String ?? ""
                let latitude = place[FlickrPlacesAPIResponse.latitude.rawValue] as? String ?? ""
                let longitude = place[FlickrPlacesAPIResponse.longitude.rawValue] as? String ?? ""
                return FlickrPlace(content: content, timezone: timezone, woe_name: woe_name, woe_id: woe_id, place_id: place_id, lat: latitude, lon: longitude)
            }
        }
        return []
    }

    static func parseShapeHistoryResponseJSON(_ json: JSONResponse?) -> FlickrPlaceShape {
        if let json = json, let shapesObject = json[FlickrShapeHistoryAPIResponse.rootKey.rawValue] as? JSONResponse,
            let shapeObject = (shapesObject[FlickrShapeHistoryAPIResponse.objectKey.rawValue] as? [JSONResponse])?.last,
            let polylinesObject = shapeObject[FlickrShapeHistoryAPIResponse.polylinesKey.rawValue] as? JSONResponse,
            let polylineObject = (polylinesObject[FlickrShapeHistoryAPIResponse.polylineObjectKey.rawValue] as? [JSONResponse])?.last,
            let content = polylineObject[FlickrShapeHistoryAPIResponse.content.rawValue] as? String {
            return FlickrPlaceShape(fromFlickrString: content)
        }
        return FlickrPlaceShape(withCoords: [])
    }
}
