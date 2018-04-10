//
//  ViewController.swift
//  iosFlickr
//
//  Created by Vadim on 09.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import UIKit

let FlickrPlaceCellReuseIdentifier = "FlickrPlaceCell"
let FlickrPlaceTableViewCellNibName = "FlickrPlaceTableViewCell"

class ViewController: UIViewController, UITableViewDelegate, FlickrPlacesDelegate {

    var dataSource: FlickrPlacesDataSource!

    @IBOutlet weak var flickrPlaceSearchField: UISearchBar!
    @IBOutlet weak var flickrPlacesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupSearchBar()
    }

    // MARK: FlickrPlacesDelegate methods

    func flickrPlacesDidLoad(_ dataSource: FlickrPlacesDataSource) {
        self.flickrPlacesTableView.reloadData()
        if self.isViewLoaded {
            self.view.endEditing(true)
        }
    }

    func flickrPlacesDidFail(_ dataSource: FlickrPlacesDataSource, errorMessage: String) {
        self.present(alert(errorMessage), animated: true)
    }

    // MARK: views setup

    private func setupTableView() {
        self.dataSource = FlickrPlacesDataSource()
        self.dataSource.delegate = self
        self.flickrPlacesTableView.dataSource = self.dataSource

        let flickrPlaceCellNib = UINib(nibName: FlickrPlaceTableViewCellNibName, bundle: nil)
        self.flickrPlacesTableView.register(flickrPlaceCellNib, forCellReuseIdentifier: FlickrPlaceCellReuseIdentifier)
    }

    private func setupSearchBar() {
        self.flickrPlaceSearchField.delegate = self
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchBar.text = ""
            self.dataSource.fetchData(searchQuery: text)
        }
    }
}
