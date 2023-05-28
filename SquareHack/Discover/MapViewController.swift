//
//  MapViewController.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 27/05/2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    var initialRegion: MKCoordinateRegion?
    var bottomViewHeightConstraint: NSLayoutConstraint?
    var bottomViewBottomConstraint: NSLayoutConstraint?
    var selectedFilters: [String: Bool] = ["Restaurants": false, "Cafes": false, "Home": false, "Small Businesses": false]

    
    var shops: [Recommended] = []
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(handleBackTap), for: .touchUpInside)
        return button
    }()
    
    lazy var searchBar: CustomSearchBar = {
        let searchBar = CustomSearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.layer.cornerRadius = 20
        searchBar.layer.backgroundColor = UIColor.white.cgColor
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        searchBar.layer.shadowRadius = 2
        searchBar.layer.shadowOpacity = 0.3
        return searchBar
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.3
        button.menu = createFilterMenu()
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    func createFilterMenu() -> UIMenu {
        let restaurantCommand = UICommand(title: "Restaurants", image: UIImage(systemName: "fork.knife"), action: #selector(filterSelected(_:)), propertyList: "Restaurants", state: selectedFilters["Restaurants"] ?? false ? .on : .off)
        let cafesCommand = UICommand(title: "Cafes", image: UIImage(systemName: "cup.and.saucer"), action: #selector(filterSelected(_:)), propertyList: "Cafes", state: selectedFilters["Cafes"] ?? false ? .on : .off)
        let homeCommand = UICommand(title: "Home", image: UIImage(systemName: "house"), action: #selector(filterSelected(_:)), propertyList: "Home", state: selectedFilters["Home"] ?? false ? .on : .off)
        let businessesCommand = UICommand(title: "Small Businesses", image: UIImage(systemName: "bag"), action: #selector(filterSelected(_:)), propertyList: "Small Businesses", state: selectedFilters["Small Businesses"] ?? false ? .on : .off)

        let filterMenu = UIMenu(title: "", options: .displayInline, children: [restaurantCommand, cafesCommand, homeCommand, businessesCommand])
        let mainMenu = UIMenu(title: "", children: [filterMenu])
        return mainMenu
    }
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.3
        return view
    }()
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Center map on selected annotation
        if let coordinate = view.annotation?.coordinate {
            mapView.setCenter(coordinate, animated: true)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }

        bottomView.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            self.bottomViewHeightConstraint?.isActive = false
            self.bottomViewHeightConstraint = self.bottomView.heightAnchor.constraint(equalToConstant: 130)
            self.bottomViewHeightConstraint?.isActive = true
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.bottomViewBottomConstraint?.constant = -50
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func filterSelected(_ command: UICommand) {
        guard let propertyList = command.propertyList as? String else {
            return
        }

        selectedFilters[propertyList] = !(selectedFilters[propertyList] ?? false)
        filterButton.menu = createFilterMenu()
    }
    
    @objc func handleBackTap() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        mapView = MKMapView(frame: self.view.frame)
        mapView.delegate = self
        mapView.showsUserLocation = true

        if let initialRegion = initialRegion {
            mapView.setRegion(initialRegion, animated: false)
        }

        self.view.addSubview(mapView)
        addPinsForShops(shops: shops)
            
        setUpView()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupSearchBar() {
        let searchBar = CustomSearchBar()
        searchBar.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Shop"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.markerTintColor = UIColor.red
            annotationView?.glyphImage = UIImage(systemName: "fork.knife")
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    func addPinsForShops(shops: [Recommended]) {
        for shop in shops {
            let annotation = MKPointAnnotation()
            annotation.title = shop.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: shop.latitude, longitude: shop.longitude)
        
            mapView.addAnnotation(annotation)
        }
    }
    
    func setUpView() {
        view.addSubview(backButton)
        view.addSubview(searchBar)
        view.addSubview(filterButton)
        view.addSubview(bottomView)

        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 12, right: nil, paddingRight: 0, width: 40, height: 40)
        
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 64, right: view.rightAnchor, paddingRight: 64, width: 0, height: 40)
        
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 12, width: 40, height: 40)

        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomViewBottomConstraint = bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 500)
        bottomViewBottomConstraint?.isActive = true
        bottomViewHeightConstraint = bottomView.heightAnchor.constraint(equalToConstant: 0)
        bottomViewHeightConstraint?.isActive = true
        bottomView.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 350)
    }
}

extension MapViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let searchBar = textField as? CustomSearchBar {
            searchBar.iconImageView.isHidden = true
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let searchBar = textField as? CustomSearchBar {
            searchBar.iconImageView.isHidden = false
        }
    }
}
