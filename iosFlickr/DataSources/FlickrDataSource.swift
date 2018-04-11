//
//  FlickrDataSource.swift
//  iosFlickr
//
//  Created by Vadim on 11.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import Foundation

protocol FLickrDataSourceDelegate {
    func flickrDataDidLoad(_ dataSource: FLickrDataSource)
    func flickrDataLoadDidFail(_ dataSource: FLickrDataSource, errorMessage: String)
}

class FLickrDataSource: NSObject {

    var delegate: FLickrDataSourceDelegate?
    var shape: FlickrPlaceShape?

}
