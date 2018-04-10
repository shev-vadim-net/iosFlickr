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
        static let key = "8bf4da14cce5d547a2943cd28e9a7b9a"
        static let findPlacesURL = "https://api.flickr.com/services/rest/?method=flickr.places.find&api_key=%@&query=%@&format=json&nojsoncallback=1"
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
            guard let json = response.result.value as? JSONResponse else {
                completionHandler([], "Unknown response format")
                return
            }

            guard let status = json[APIGeneralKeys.status] as? String, status != APIGeneralKeys.statusFailed else {
                let code = (json[APIGeneralKeys.code] as? Int) ?? 0
                let message = (json[APIGeneralKeys.message] as? String) ?? "unknown"
                completionHandler([], "Request failed with code '\(code)'. Message: \(message)")
                return
            }

//            print("JSON: \(json)") // serialized json response
            completionHandler(FlickrApiResponseManager.parsePlacesResponseJSON(json), nil)
        }
    }

}
