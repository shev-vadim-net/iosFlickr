//
//  MapViewController.swift
//  iosFlickr
//
//  Created by Vadim on 10.04.18.
//  Copyright © 2018 home. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    var selectedPlace: FlickrPlace?
    var dataSource: FlickrHistoryShapeDataSource!
    var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupDataSource()
        self.setupMap()
    }

    func drawPolyline(mapView: GMSMapView, coords: [CLLocationCoordinate2D]) {
        if coords.count == 0 {
            self.present(alert("No shape provided from Flickr service", title: "Warning"), animated: true)
            return
        }
        let path = GMSMutablePath()
        coords.forEach { (coord) in path.add(coord) }
        let polyline = GMSPolyline(path: path)
        polyline.map = mapView
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.mapView = nil
        self.view = nil
        self.dataSource = nil
    }

    // MARK: views setup

    private func setupMap() {
        let camera = GMSCameraPosition.camera(withTarget: self.selectedPlace!.coords, zoom: 11.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView.isMyLocationEnabled = true
        self.view = mapView
    }

    private func setupDataSource() {
        self.dataSource = FlickrHistoryShapeDataSource()
        self.dataSource.delegate = self
        if let selectedPlace = self.selectedPlace {
            self.dataSource.fetchData(woe_id: selectedPlace.woe_id)
        }
    }
}

extension MapViewController: FLickrDataSourceDelegate {
    func flickrDataDidLoad(_ dataSource: FLickrDataSource) {
        if self.isViewLoaded {
            if let shape = dataSource.shape {
                self.drawPolyline(mapView: self.mapView, coords: shape.coords)
            }
        }
    }

    func flickrDataLoadDidFail(_ dataSource: FLickrDataSource, errorMessage: String) {
        self.present(alert(errorMessage), animated: true)
    }
}
