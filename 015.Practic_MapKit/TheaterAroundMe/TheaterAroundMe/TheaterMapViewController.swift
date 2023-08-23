//
//  ViewController.swift
//  TheaterAroundMe
//
//  Created by Roen White on 2023/08/23.
//

import UIKit
import CoreLocation
import MapKit

class TheaterMapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    let mapView = MKMapView()
    
    lazy var hereButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "location")
        config.buttonSize = .small
        config.baseBackgroundColor = .systemIndigo
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        
        button.configuration = config
        
        return button
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "map")
        config.buttonSize = .small
        config.baseBackgroundColor = .systemOrange
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        
        button.configuration = config
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        locationManager.delegate = self
        mapView.delegate = self
        
        [mapView, filterButton, hereButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setUpConstraints()
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            filterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            filterButton.heightAnchor.constraint(equalTo: hereButton.widthAnchor, multiplier: 1),
            
            hereButton.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 8),
            hereButton.trailingAnchor.constraint(equalTo: filterButton.trailingAnchor),
            hereButton.heightAnchor.constraint(equalTo: hereButton.widthAnchor)
        ])
    }
}

extension TheaterMapViewController: CLLocationManagerDelegate {
    
}

extension TheaterMapViewController: MKMapViewDelegate {
    
}
