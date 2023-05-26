//
//  RecommendedCell.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 26/05/2023.
//

import UIKit
import QuartzCore

class RecommendedCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    lazy var logoBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 0
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.58, 0.6]
        return gradientLayer
    }()
    
    lazy var darkOverlay: UIView = {
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlay.layer.cornerRadius = 16
        overlay.layer.masksToBounds = true
        return overlay
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 2
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = imageView.bounds
        darkOverlay.frame = imageView.bounds
    }
    
    func configure(data: Recommended) {
        imageView.image = UIImage(named: data.image)
        logoImageView.image = UIImage(named: data.logo)
        titleLabel.text = data.title
        typeLabel.text = data.type
    }
    
    private func setUpView() {
        addSubview(imageView)
        imageView.addSubview(darkOverlay)
        imageView.layer.addSublayer(gradientLayer)
        imageView.addSubview(typeLabel)
        imageView.addSubview(titleLabel)
        imageView.addSubview(logoBackgroundView)
        logoBackgroundView.addSubview(logoImageView)
        
        imageView.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 240, height: 150)
        
        logoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        logoBackgroundView.anchor(top: imageView.bottomAnchor, paddingTop: -110, bottom: nil, paddingBottom: 0, left: imageView.leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 40, height: 40)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 25, height: 25)
        logoImageView.centerYAnchor.constraint(equalTo: logoBackgroundView.centerYAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: logoBackgroundView.centerXAnchor).isActive = true
        
        titleLabel.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: logoBackgroundView.rightAnchor, paddingLeft: 8, right: nil, paddingRight: 0, width: 0, height: 0)
        titleLabel.centerYAnchor.constraint(equalTo: logoBackgroundView.centerYAnchor).isActive = true
        
        typeLabel.anchor(top: imageView.bottomAnchor, paddingTop: -54, bottom: nil, paddingBottom: 0, left: imageView.leftAnchor, paddingLeft: 10, right: imageView.rightAnchor, paddingRight: 8, width: 0, height: 0)
    }
}

struct Recommended {
    var image: String
    var logo: String
    var title: String
    var type: String
}

