//
//  SuccessPayViewController.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 26/05/2023.
//

import UIKit

class SuccessPayViewController: UIViewController {
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Success!"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "CardSuccess"))
        imageView.contentMode = .scaleAspectFit
        imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        return imageView
    }()
    
    lazy var pointsLabel: UILabel = {
        let pointsLabel = UILabel()
        pointsLabel.text = "You earned XXX points!"
        pointsLabel.textColor = UIColor.white
        pointsLabel.textAlignment = .center
        pointsLabel.font = UIFont.systemFont(ofSize: 18)
        return pointsLabel
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Thanks, let me grab my stuff!", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        view.backgroundColor = .redColour
    }
    
    func setUpView() {
        view.addSubview(containerView)
        view.addSubview(label)
        containerView.addSubview(imageView)
        view.addSubview(pointsLabel)
        view.addSubview(button)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 100).isActive = true
        
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pointsLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 1).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true

        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
}

