import UIKit
import MapKit
import CoreLocation

class DiscoverViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    var recommends: [Recommended] = []
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap))
        mapView.addGestureRecognizer(tapGesture)

        return mapView
    }()
    
    func transitionToFullMap() {
        let mapViewController = MapViewController()

        mapViewController.shops = viewModel?.recommends ?? []
        mapViewController.initialRegion = miniMapView.region  // Pass the current region

        let navigationController = UINavigationController(rootViewController: mapViewController)

        UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.miniMapView.frame = self.view.bounds
        }) { _ in
            self.present(navigationController, animated: true)
        }
    }
    
    lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Explore your Area"
        return label
    }()
    
    lazy var mapMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See map", for: .normal)
        button.setTitleColor(.redColour, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    lazy var recommendedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Recommened for you"
        return label
    }()
    
    lazy var recommendedMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.redColour, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
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
    
    lazy var newMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.redColour, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
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
    
    @objc func handleMapTap() {
        transitionToFullMap()
    }
    
    func fetchAndDisplayShops() {
        viewModel?.fetchRecommends { [weak self] error in
            guard let self = self else { return }

            if let error = error {
                // Handle the error...
                print("Error fetching shops: \(error)")
                return
            }

            DispatchQueue.main.async {
                self.addAnnotationsToMap()
            }
        }
    }
        
    func addAnnotationsToMap() {
        guard let viewModel = viewModel else { return }
        for shop in viewModel.recommends {
            let coordinate = CLLocationCoordinate2D(latitude: shop.latitude, longitude: shop.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = shop.title
            miniMapView.addAnnotation(annotation)
        }
    }
    
    var viewModel: DiscoverViewModelProtocol?
        
    init(viewModel: DiscoverViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        
        recommendedCollectionView.delegate = self
        recommendedCollectionView.dataSource = self
        
        newCollectionView.delegate = self
        newCollectionView.dataSource = self
                
        viewModel?.fetchRecommends { [weak self] error in
            if let error = error {
                print("Failed to fetch favourites: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self?.recommendedCollectionView.reloadData()
                    self?.newCollectionView.reloadData()
                }
            }
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupSearchBar() {
        let searchBar = CustomSearchBar()
        searchBar.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            let alert = UIAlertController(title: "Location Access Disabled",
                                          message: "In order to use this app, please open Settings and enable location services.",
                                          preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Go to Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                }
            }
            alert.addAction(settingsAction)
            present(alert, animated: true, completion: nil)

        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            
        @unknown default:
            print("Unknown case in locationManagerDidChangeAuthorization")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.userLocation = location
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 350, longitudinalMeters: 350)
            miniMapView.setRegion(region, animated: true)
        }
    }
    
    func setUpView() {
        view.addSubview(searchBar)
        view.addSubview(areaLabel)
        view.addSubview(mapMoreButton)
        view.addSubview(miniMapView)
        view.addSubview(recommendedLabel)
        view.addSubview(recommendedMoreButton)
        view.addSubview(recommendedCollectionView)
        view.addSubview(newLabel)
        view.addSubview(newMoreButton)
        view.addSubview(newCollectionView)
        
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 50)
        
        areaLabel.anchor(top: searchBar.bottomAnchor, paddingTop: 32, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        mapMoreButton.anchor(top: searchBar.bottomAnchor, paddingTop: 28, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        
        miniMapView.anchor(top: areaLabel.bottomAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 165)
        
        recommendedLabel.anchor(top: miniMapView.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        recommendedMoreButton.anchor(top: miniMapView.bottomAnchor, paddingTop: 16, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        
        recommendedCollectionView.anchor(top: recommendedLabel.bottomAnchor, paddingTop: -2, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 10, width: 0, height: 180)
        
        newLabel.anchor(top: recommendedCollectionView.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        newMoreButton.anchor(top: recommendedCollectionView.bottomAnchor, paddingTop: -4, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        
        newCollectionView.anchor(top: newLabel.bottomAnchor, paddingTop: -2, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 10, width: 0, height: 180)
        
    }
}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.recommends.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "recommendedCell",
            for: indexPath) as? RecommendedCell else { return UICollectionViewCell() }
        if let recommends = viewModel?.recommends[indexPath.row] {
            cell.titleLabel.text = recommends.title
            cell.typeLabel.text = recommends.type
            cell.configure(data: recommends)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = CGSize(width: 240, height: 160)
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

extension ViewController: UITextFieldDelegate {
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
