//
//  DiscoverViewController.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 25/05/2023.
//

import UIKit
import MapKit
import CoreLocation

class DiscoverViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    var recommends: [Recommended] = [
        Recommended(image: "github", logo: "mcdonalds", title: "Terry", type: "0.001"),
        Recommended(image: "github", logo: "mcdonalds", title: "Nine", type: "0.002"),
        Recommended(image: "github", logo: "mcdonalds", title: "Rocky", type: "0.0005"),
        Recommended(image: "github", logo: "mcdonalds", title: "KFC", type: "0.002"),
    ]
    
    lazy var searchBar: CustomSearchBar = {
        let searchBar = CustomSearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var miniMapView: MKMapView = {
        let mapView = MKMapView()
        mapView.layer.cornerRadius = 22
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        return mapView
    }()
    
    lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Explore your Area"
        return label
    }()
    
    lazy var recommendedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Recommened for you"
        return label
    }()
    
    lazy var recommendedCollectionView: UICollectionView = {
        let flowlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionview.register(RecommendedCell.self, forCellWithReuseIdentifier: "recommendedCell")
        collectionview.backgroundColor = .clear
        collectionview.isUserInteractionEnabled = true
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()
    
    lazy var newLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "New in your Area"
        return label
    }()
    
    lazy var newCollectionView: UICollectionView = {
        let flowlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionview.register(RecommendedCell.self, forCellWithReuseIdentifier: "recommendedCell")
        collectionview.backgroundColor = .clear
        collectionview.isUserInteractionEnabled = true
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()

    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        setUpView()
        view.backgroundColor = .white

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
        }
        else {
            // Handle other cases as per your app's requirements
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.userLocation = location
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            miniMapView.setRegion(region, animated: true)
        }
    }
    
    func setUpView() {
        view.addSubview(searchBar)
        view.addSubview(areaLabel)
        view.addSubview(miniMapView)
        view.addSubview(recommendedLabel)
        view.addSubview(recommendedCollectionView)
        view.addSubview(newLabel)
        view.addSubview(newCollectionView)
        
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 50)
        
        areaLabel.anchor(top: searchBar.bottomAnchor, paddingTop: 32, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        miniMapView.anchor(top: areaLabel.bottomAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 165)
        
        recommendedLabel.anchor(top: miniMapView.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        recommendedCollectionView.anchor(top: recommendedLabel.bottomAnchor, paddingTop: -2, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 10, width: 0, height: 180)
        
        newLabel.anchor(top: recommendedCollectionView.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        newCollectionView.anchor(top: newLabel.bottomAnchor, paddingTop: -2, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 10, width: 0, height: 180)
        
    }
}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "recommendedCell",
            for: indexPath) as? RecommendedCell else { return UICollectionViewCell() }
        let data = recommends[indexPath.item]
        cell.backgroundColor = .clear
        cell.configure(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = CGSize(width: 245, height: 160)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
