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
    
    private let locationManager = CLLocationManager()
    private var authorizationStatus: CLAuthorizationStatus {
        locationManager.authorizationStatus
    }
    private let mapView = MKMapView()
    
    private lazy var hereButton: UIButton = {
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
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "map")
        config.buttonSize = .small
        config.baseBackgroundColor = .systemOrange
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        
        button.configuration = config
        button.addTarget(self, action: #selector(showActionButtonForFilterTheater), for: .touchUpInside)
        
        return button
    }()
    private lazy var warningStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    private lazy var warningButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.title = "위치서비스가 꺼져 있음"
        config.image = UIImage(systemName: "chevron.right")
        config.imagePlacement = .trailing
        config.imagePadding = 4
        config.buttonSize = .mini
        button.configuration = config
        
        button.addTarget(self, action: #selector(showAuthorizationSettingsAlert), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        locationManager.delegate = self
        
        [mapView, warningStackView, filterButton, hereButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setUpConstraints()
        
        let allAnotations = convertCoordinateToAnnotation(for: TheaterStore.theaterList)
        addAnnotionToMapView(list: allAnotations)
        
        requestCurrentAuthorizationStatusOfLocation()
    }
    
    @objc private func showActionButtonForFilterTheater() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for type in TheaterFilter.allCases {
            let action = UIAlertAction(title: type.actionTitle, style: .default) { _ in
                let theaterList = self.filterTheater(for: type.filterType)
                let annotations = self.convertCoordinateToAnnotation(for: theaterList)
                self.addAnnotionToMapView(list: annotations)
            }
            
            alert.addAction(action)
        }
        
        present(alert, animated: true)
    }
    
    private func filterTheater(for company: TheaterStore.Company? = nil) -> [TheaterStore.Theater] {
        switch company {
        case .none: return TheaterStore.theaterList
        case .lotte: return TheaterStore.theaterList.filter { $0.company == .lotte }
        case .megabox: return TheaterStore.theaterList.filter { $0.company == .megabox }
        case .cgv: return TheaterStore.theaterList.filter { $0.company == .cgv }
        }
    }
    
    private func convertCoordinateToAnnotation(for theaterList: [TheaterStore.Theater]) -> [MKPointAnnotation] {
        var locations = [MKPointAnnotation]()
        
        theaterList.forEach {
            let theaterCoordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
            let annotation = MKPointAnnotation()
            annotation.title = $0.name
            annotation.coordinate = theaterCoordinate
            
            locations.append(annotation)
        }
        
        return locations
    }
    
    private func addAnnotionToMapView(list: [MKPointAnnotation]) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(list)
    }
    
    @objc private func showAuthorizationSettingsCompactAlert() {
        let alert = UIAlertController(title: "앱에서 사용자의 위치 정보를 확인하도록 허용하려면 위치 서비스를 켜십시오.", message: nil, preferredStyle: .alert)
        
        let moveToSettings = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            guard let settings = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            UIApplication.shared.open(settings)
        }
        
        let notUseLocationService = UIAlertAction(title: "위치 사용 안함", style: .default)
        
        alert.addAction(moveToSettings)
        alert.addAction(notUseLocationService)
        
        present(alert, animated: true)
    }
    
    @objc private func showAuthorizationSettingsAlert() {
        let alert = UIAlertController(title: "이 앱은 위치 서비스가 켜져 있을 때 최적으로 동작합니다.", message: "이 앱에서 위치 서비스를 켜면 주변 영화관 정보를 가져올 수 있습니다.", preferredStyle: .alert)
        
        let moveToSettings = UIAlertAction(title: "설정에서 켜기", style: .default) { _ in
            guard let settings = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            UIApplication.shared.open(settings)
        }
        
        let stayLocationServiceOffStatus = UIAlertAction(title: "위치 서비스 끔 상태 유지", style: .default)
        
        alert.addAction(moveToSettings)
        alert.addAction(stayLocationServiceOffStatus)
        
        present(alert, animated: true)
    }
    
    @objc private func fetchingCurrentLocation() {
        locationManager.startUpdatingLocation()
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            warningStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            warningStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            warningStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
            
        warningStackView.addArrangedSubview(warningButton)
        
        NSLayoutConstraint.activate([
            warningButton.topAnchor.constraint(equalTo: warningStackView.topAnchor),
            warningButton.centerXAnchor.constraint(equalTo: warningStackView.centerXAnchor),
            
            filterButton.topAnchor.constraint(equalTo: warningButton.bottomAnchor, constant: 16),
            filterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            filterButton.heightAnchor.constraint(equalTo: hereButton.widthAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            hereButton.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 8),
            hereButton.trailingAnchor.constraint(equalTo: filterButton.trailingAnchor),
            hereButton.heightAnchor.constraint(equalTo: hereButton.widthAnchor)
        ])
    }
}

extension TheaterMapViewController: CLLocationManagerDelegate {
    private func requestCurrentAuthorizationStatusOfLocation() {
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else {
                self.warningButton.isHidden = false
                self.warningButton.isHighlighted = true
                return
            }
            
            let authorizaion: CLAuthorizationStatus
            
            if #available(iOS 14.0, *) {
                authorizaion = self.locationManager.authorizationStatus
            } else {
                authorizaion = CLLocationManager.authorizationStatus()
            }
            
            DispatchQueue.main.async {
                self.handleAuthorizationStatusOfLocation(status: authorizaion)
            }
        }
    }
    
    private func handleAuthorizationStatusOfLocation(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            requestAuthorizationToUser()
        case .restricted:
            requestAuthorizationToUser()
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            self.hereButton.addTarget(self, action: #selector(fetchingCurrentLocation), for: .touchUpInside)
        case .denied:
            self.warningButton.isHidden = false
            self.hereButton.addTarget(self, action: #selector(showAuthorizationSettingsCompactAlert), for: .touchUpInside)
        @unknown default:
            break
        }
        
        locationManager.startUpdatingLocation()
    }
    
    private func requestAuthorizationToUser() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestCurrentAuthorizationStatusOfLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinate = locations.last?.coordinate ?? CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
            
        presentCurrentLocationOnMap(for: coordinate)
        locationManager.stopUpdatingLocation()
    }
}

extension TheaterMapViewController: MKMapViewDelegate {
    func presentCurrentLocationOnMap(for coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
    }
}

fileprivate enum TheaterFilter: CaseIterable {
    case all
    case lotte
    case megabox
    case cgv
    
    var actionTitle: String {
        switch self {
        case .all: return "전체보기"
        case .lotte: return "롯데시네마"
        case .megabox: return "메가박스"
        case .cgv: return "CGV"
        }
    }
    
    var filterType: TheaterStore.Company? {
        switch self {
        case .all: return nil
        case .lotte: return .lotte
        case .megabox: return .megabox
        case .cgv: return .cgv
        }
    }
}
