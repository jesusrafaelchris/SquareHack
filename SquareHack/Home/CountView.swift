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
        text.font = UIFont.boldSystemFont(ofSize: 38)
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
        text.font = UIFont.boldSystemFont(ofSize: 16)
        return text
    }()
    
    lazy var progressView: ProgressView = {
        let progressView = ProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.backgroundColor = .clear
        return progressView
    }()
    
    lazy var rewardPointsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rewardPoints, availablePoints])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    lazy var countStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rewardLabel, rewardPointsStackView, tierLabel, progressView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 1
        return stackView
    }()
   
    override init(frame: CGRect) {
         super.init(frame: frame)

         addSubview(countStackView)
         countStackView.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
    }
    
   func updatePointsAndTier(points: Int) {
       let numberFormatter = NumberFormatter()
       numberFormatter.numberStyle = .decimal
       let pointsAsString = numberFormatter.string(from: NSNumber(value: points)) ?? "0"
      
       progressView.setRewardPoints(points)
       
       self.rewardPoints.text = "\(pointsAsString)"
       if points < 500 {
           self.tierLabel.text = "Bronze Tier"
          self.tierLabel.textColor = UIColor(red: 140/255, green: 90/255, blue: 40/255, alpha: 1.0)
       } else if points < 1000 {
           self.tierLabel.text = "Silver Tier"
           self.tierLabel.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
      } else if points < 1500 {
           self.tierLabel.text = "Gold Tier"
           self.tierLabel.textColor = UIColor(red: 204/255, green: 180/255, blue: 0/255, alpha: 1.0)
       } else {
           self.tierLabel.text = "Platinum Tier"
           self.tierLabel.textColor = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1.0)
       }
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
