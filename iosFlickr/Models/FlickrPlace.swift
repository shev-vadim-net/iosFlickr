//
//  FlickrPlace.swift
//  iosFlickr
//
//  Created by Vadim on 09.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import Foundation

class FlickrPlace {

    let content, timezone, woe_name, woe_id, place_id: String

    init(content: String, timezone: String, woe_name: String, woe_id: String, place_id: String) {
        self.content = content
        self.timezone = timezone
        self.woe_name = woe_name
        self.woe_id = woe_id
        self.place_id = place_id
    }
}
