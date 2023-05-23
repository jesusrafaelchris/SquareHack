//
//  CountView.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 23/05/2023.
//
import UIKit

class CountView: UIView {
    
    lazy var rewardLabel: UILabel = {
        let text = UILabel()
        text.textColor = .redColour
        text.font = UIFont.boldSystemFont(ofSize: 8)
        text.text = "REWARD POINTS"
        return text
    }()
    
    lazy var rewardPoints: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 40)
        return text
    }()
    
    lazy var availablePoints: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 21, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "diamond.fill", withConfiguration: largeConfig)?.withTintColor(UIColor.redColour ?? .red).withRenderingMode(.alwaysOriginal)
        button.setImage(largeBoldDoc, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var tierLabel: UILabel = {
        let text = UILabel()
        text.textColor = .gray
        text.font = UIFont.boldSystemFont(ofSize: 16)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(rewardLabel)
        addSubview(rewardPoints)
        addSubview(availablePoints)
        addSubview(tierLabel)
        
        rewardLabel.anchor(top: topAnchor, paddingTop: 32, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 24, right: nil, paddingRight: 0, width: 0, height: 0)
            
        rewardPoints.anchor(top: rewardLabel.bottomAnchor, paddingTop: 1, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 24, right: nil, paddingRight: 0, width: 0, height: 0)
        
        availablePoints.anchor(top: rewardLabel.bottomAnchor, paddingTop: 1, bottom: nil, paddingBottom: 0, left: rewardPoints.rightAnchor, paddingLeft: 8, right: nil, paddingRight: 0, width: 0, height: 0)
        availablePoints.centerYAnchor.constraint(equalTo: rewardPoints.centerYAnchor).isActive = true
        
        tierLabel.anchor(top: rewardPoints.bottomAnchor, paddingTop: 1, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 24, right: nil, paddingRight: 0, width: 0, height: 0)

    }
    
    func updatePointsAndTier(points: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let pointsAsString = numberFormatter.string(from: NSNumber(value: points)) ?? "0"
        
        self.rewardPoints.text = "\(pointsAsString)"
        if points < 1000 {
            self.tierLabel.text = "Bronze Tier"
        } else if points < 5000 {
            self.tierLabel.text = "Silver Tier"
        } else {
            self.tierLabel.text = "Gold Tier"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
