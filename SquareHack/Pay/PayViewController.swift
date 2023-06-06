//
//  PayViewController.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 29/05/2023.
//

import UIKit

class PayViewController: UIViewController {
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "You can only use this feature when at a supported restaurant or cafe. Scan the QR Code at your table or the one provided by the establishment, and we'll handle the rest for you. \n \nIf we can find an oustanding payment, you'll be able to pay for your order using any payment method you wish - all within one App."
        label.numberOfLines = 0
        return label
    }()
    
    lazy var scannerButton: UIButton = {
        let button = UIButton()
        if let creamColor = UIColor.redColour?.cgColor {
            button.layer.backgroundColor = creamColor
        }
        button.setTitle("Scan To Pay", for: .normal)
        button.setTitleColor(.creamColour, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 27
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var donationView = DonationView()
    
    @objc func buttonTapped() {
        let scannerVC = QRScanViewController()
        navigationController?.pushViewController(scannerVC, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        view.backgroundColor = .white
        
    }
    
    func setUpView() {
        self.title = "Pay"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(donationView)
        view.addSubview(descriptionLabel)
        view.addSubview(scannerButton)
        
        donationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        donationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        scannerButton.anchor(top: donationView.bottomAnchor, paddingTop: 48, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 140, height: 54)
        scannerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        descriptionLabel.anchor(top: scannerButton.bottomAnchor, paddingTop: 42, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        


    }
}
