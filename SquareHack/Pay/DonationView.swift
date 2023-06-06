//
//  DonationView.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 06/06/2023.
//

import UIKit

class DonationView: UIView {
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "Donation")
        imageView.cornerRadius = 20
        return imageView
    }()
    
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "minipic")
        imageView.cornerRadius = 20
        return imageView
    }()
    
    lazy var supportLabel: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 24)
        text.text = "Support a \nlocal charity"
        text.numberOfLines = 2
        text.textAlignment = .left
        return text
    }()
    
    lazy var scannerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Donate", for: .normal)
        button.setTitleColor(.redColour, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 17.5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(backgroundImage)
        addSubview(logoImage)
        addSubview(supportLabel)
        addSubview(scannerButton)
        
        backgroundImage.anchor(top: topAnchor, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 0, height: 200)
        
        logoImage.anchor(top: backgroundImage.topAnchor, paddingTop: 16, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 40, height: 40)
        
        supportLabel.anchor(top: logoImage.bottomAnchor, paddingTop: 12, bottom: nil, paddingBottom: 0, left: backgroundImage.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        scannerButton.anchor(top: nil, paddingTop: 0, bottom: backgroundImage.bottomAnchor, paddingBottom: 16, left: nil, paddingLeft: 0, right: backgroundImage.rightAnchor, paddingRight: 16, width: 90, height: 35)
    }
    
}
