//
//  Globals.swift
//  iosFlickr
//
//  Created by Vadim on 10.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import Foundation
import UIKit

// MARK: typealiases

typealias UIAlertActionHandler = (UIAlertAction) -> Void

// MARK: constants

let GMS_API_KEY = "AIzaSyAc0aFmlGv27z2ZrKIEOi6RblTd5NP9-nc"

// MARK: methods

func alert(_ message: String, title: String = "Error", onClose: UIAlertActionHandler? = nil) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: onClose))
    return alert
}
