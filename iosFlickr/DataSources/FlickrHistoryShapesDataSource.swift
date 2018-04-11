//
//  FlickrHistoryShapesDataSource.swift
//  iosFlickr
//
//  Created by Vadim on 11.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import Foundation

class FlickrHistoryShapeDataSource: FLickrDataSource {

    func fetchData(woe_id: String) {
        FlickrAPIManager.getShapeHistory(woe_id: woe_id, completionHandler: { [weak self] (shape, error) in
            if let strongSelf = self {
                if let error = error {
                    strongSelf.delegate?.flickrDataLoadDidFail(strongSelf, errorMessage: error)
                } else {
                    strongSelf.shape = shape
                    strongSelf.delegate?.flickrDataDidLoad(strongSelf)
                }
            }

        })
    }
}
