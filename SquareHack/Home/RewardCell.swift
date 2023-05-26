//
//  RewardCell.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 24/05/2023.
//

import UIKit

class RewardCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "github")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16

        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = "Bruh"
        text.font = UIFont.systemFont(ofSize: 14)
        return text
    }()
    
    lazy var typeLabel: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = "Moin"
        text.font = UIFont.boldSystemFont(ofSize: 12)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 2
        setUpView()
    }
    

    func configure(data: Reward) {
        imageView.image = UIImage(named: data.image)
        titleLabel.text = data.title
        typeLabel.text = data.type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(typeLabel)
        
        imageView.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 110, height: 120)
        
        titleLabel.anchor(top: imageView.bottomAnchor, paddingTop: 4, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        typeLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: 2, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
    }
}

struct Reward {
    var image: String
    var title: String
    var type: String
}
