//
//  FlickrPlaceTableViewCell.swift
//  iosFlickr
//
//  Created by Vadim on 10.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import UIKit

class FlickrPlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var woeName: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var timezone: UILabel!

    var flickrPlace: FlickrPlace? {
        didSet {
            self.woeName.text = self.flickrPlace?.woe_name
            self.timezone.text = self.flickrPlace?.timezone
            self.content.text = self.flickrPlace?.content
        }
    }

}
