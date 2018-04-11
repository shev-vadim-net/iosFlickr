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
let MapViewControllerIdentifier = "MapViewController"

class ViewController: UIViewController {

    var dataSource: FlickrPlacesDataSource!

    @IBOutlet weak var flickrPlaceSearchField: UISearchBar!
    @IBOutlet weak var flickrPlacesTableView: UITableView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupSearchBar()
    }

    // MARK: views setup

    private func setupTableView() {
        self.dataSource = FlickrPlacesDataSource()
        self.dataSource.delegate = self
        self.flickrPlacesTableView.dataSource = self.dataSource
        self.flickrPlacesTableView.delegate = self

        let flickrPlaceCellNib = UINib(nibName: FlickrPlaceTableViewCellNibName, bundle: nil)
        self.flickrPlacesTableView.register(flickrPlaceCellNib, forCellReuseIdentifier: FlickrPlaceCellReuseIdentifier)
    }

    private func setupSearchBar() {
        self.flickrPlaceSearchField.delegate = self
        self.flickrPlaceSearchField.placeholder = "Search for places"
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let mapViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MapViewControllerIdentifier) as! MapViewController
        mapViewController.selectedPlace = self.dataSource.itemAtIndexPath(indexPath)
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
}

extension ViewController: FLickrDataSourceDelegate {
    func flickrDataWillLoad(_ dataSource: FLickrDataSource) {
        self.activityIndicator.startAnimating()
    }

    func flickrDataDidLoad(_ dataSource: FLickrDataSource) {
        self.flickrPlacesTableView.reloadData()
        if self.isViewLoaded {
            self.activityIndicator.stopAnimating()
            self.view.endEditing(true)
            self.coverView.isHidden = true
        }
    }

    func flickrDataLoadDidFail(_ dataSource: FLickrDataSource, errorMessage: String) {
        self.activityIndicator.stopAnimating()
        self.present(alert(errorMessage), animated: true)
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
