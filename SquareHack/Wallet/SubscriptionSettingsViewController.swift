//
//  SubscriptionSettingsViewController.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 06/06/2023.
//

import UIKit

class SubscriptionSettingsViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Subscribe to Pret A Manger"
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "By subscribing you agree to be registered as a Square customer, your User ID will be shared between Redeem and Square and your data is stared safely. The subscription as of now is free of charge."
        label.numberOfLines = 0
        return label
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.57, green: 0.00, blue: 0.15, alpha: 1.00)
        button.setTitle("Confirm Subscription", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(confirmSubscription), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 1
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(handleBackTap), for: .touchUpInside)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        setUpView()
        view.backgroundColor = .white
    }
    
    @objc func handleBackTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmSubscription() {
        // Create the image view
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(imageView)
        
        // Animate the image view sliding up
        UIView.animate(withDuration: 1.0, animations: {
            imageView.frame = self.view.frame
        }) { (finished) in
            // After the animation is complete, wait for 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                // Then animate the image view sliding down and remove it from the view
                UIView.animate(withDuration: 0.5, animations: {
                    imageView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
                }) { (finished) in
                    imageView.removeFromSuperview()
                    
                    // Dismiss the view controller
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func setUpView(){
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(descriptionLabel)
        view.addSubview(confirmButton)
        
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 40, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: 32, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        
        confirmButton.anchor(top: descriptionLabel.bottomAnchor, paddingTop: 68, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 200, height: 40)
        confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: view.rightAnchor, paddingRight: 16, width: 40, height: 40)
    }
    
}
