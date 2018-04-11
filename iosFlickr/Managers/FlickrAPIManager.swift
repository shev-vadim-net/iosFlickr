//
//  FlickrAPIManager.swift
//  iosFlickr
//
//  Created by Vadim on 09.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONResponse = [String:AnyObject]

class FlickrAPIManager {

    struct APIConfig {
        static let key = "5c13c64075f89a68cebb8609bd8852a1"
        static let findPlacesURL = "https://api.flickr.com/services/rest/?method=flickr.places.find&api_key=%@&query=%@&format=json&nojsoncallback=1"
        static let getShapeHistoryURL = "https://api.flickr.com/services/rest/?method=flickr.places.getShapeHistory&api_key=%@&woe_id=%@&format=json&nojsoncallback=1"
    }

    struct APIGeneralKeys {
        static let status = "stat"
        static let code = "code"
        static let message = "message"
        static let statusFailed = "fail"
    }

    static func findPlaces(searchQuery: String, completionHandler: @escaping ([FlickrPlace], String?) -> Void) {
        let url = String(format: APIConfig.findPlacesURL, APIConfig.key, searchQuery)
        Alamofire.request(url).responseJSON { response in
            let (json, error) = self.getJSONContent(fromResponse: response)
//            print("JSON: \(json)") // serialized json response
            completionHandler(FlickrApiResponseManager.parsePlacesResponseJSON(json), error)
        }
    }

    static func getShapeHistory(woe_id: String, completionHandler: @escaping (FlickrPlaceShape?, String?) -> Void) {
        let url = String(format: APIConfig.getShapeHistoryURL, APIConfig.key, woe_id)
        Alamofire.request(url).responseJSON { response in
            let (json, error) = self.getJSONContent(fromResponse: response)
//            print("JSON: \(json)") // serialized json response
            completionHandler(FlickrApiResponseManager.parseShapeHistoryResponseJSON(json), error)
        }
    }

    private static func getJSONContent(fromResponse response: DataResponse<Any>) -> (JSONResponse?, String?) {
        guard let json = response.result.value as? JSONResponse else {
            return (nil, "Unknown response format")
        }

        guard let status = json[APIGeneralKeys.status] as? String, status != APIGeneralKeys.statusFailed else {
            let code = (json[APIGeneralKeys.code] as? Int) ?? 0
            let message = (json[APIGeneralKeys.message] as? String) ?? "unknown"
            return (nil, "Request failed with code '\(code)'. Message: \(message)")
        }

        return (json, nil)
    }
}
