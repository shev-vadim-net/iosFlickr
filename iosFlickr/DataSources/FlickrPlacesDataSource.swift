//
//  FlickrPlacesDataSource.swift
//  iosFlickr
//
//  Created by Vadim on 09.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import Foundation
import UIKit

class FlickrPlacesDataSource: FLickrDataSource, UITableViewDataSource {

    var places: [FlickrPlace] = []

    func fetchData(searchQuery: String) {
        self.delegate?.flickrDataWillLoad(self)
        FlickrAPIManager.findPlaces(searchQuery: searchQuery, completionHandler: { [weak self] (places, error) in
            if let strongSelf = self {
                if let error = error {
                    strongSelf.delegate?.flickrDataLoadDidFail(strongSelf, errorMessage: error)
                } else {
                    strongSelf.places = places
                    strongSelf.delegate?.flickrDataDidLoad(strongSelf)
                }
            }
        })
    }

    func itemAtIndexPath(_ indexPath: IndexPath) -> FlickrPlace? {
        guard indexPath.row < self.places.count else {
            return nil
        }
        return self.places[indexPath.row]
    }

    // MARK: UITableViewDataSource methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlickrPlaceCellReuseIdentifier, for: indexPath) as! FlickrPlaceTableViewCell
        cell.flickrPlace = self.places[indexPath.row]
        return cell
    }

}
