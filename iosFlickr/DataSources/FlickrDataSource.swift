//
//  FlickrDataSource.swift
//  iosFlickr
//
//  Created by Vadim on 11.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import Foundation

protocol FLickrDataSourceDelegate {
    func flickrDataWillLoad(_ dataSource: FLickrDataSource)
    func flickrDataDidLoad(_ dataSource: FLickrDataSource)
    func flickrDataLoadDidFail(_ dataSource: FLickrDataSource, errorMessage: String)
}

extension FLickrDataSourceDelegate {
    // This way protocol method becomes "optional"
    func flickrDataWillLoad(_ dataSource: FLickrDataSource) {}
}

class FLickrDataSource: NSObject {

    var delegate: FLickrDataSourceDelegate?
    var shape: FlickrPlaceShape?

}
