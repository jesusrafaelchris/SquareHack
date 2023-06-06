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
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.borderWidth = 2
        if let creamColor = UIColor.creamColour?.cgColor {
            imageView.layer.borderColor = creamColor
        }
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.text = "Bruh"
        text.font = UIFont.boldSystemFont(ofSize: 16)
        return text
    }()
    
    lazy var purchaseView: PurchaseView = {
        let view = PurchaseView()
        view.backgroundColor = .clear
        view.backgroundColor = .white
        view.totalCircles = 5
        view.filledCircles = 3
        view.frame = CGRect(x: 50, y: 50, width: 300, height: 50)
        return view
    }()
    
    let whiteBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    lazy var darkOverlay: UIView = {
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        overlay.layer.cornerRadius = 16
        overlay.layer.masksToBounds = true
        return overlay
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        darkOverlay.frame = imageView.bounds
    }
    
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
        logoImageView.image = UIImage(named: data.logo)
        titleLabel.text = data.title
        purchaseView.totalCircles = 5
        purchaseView.filledCircles = data.purchasesToGo
        purchaseView.setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(imageView)
        imageView.addSubview(darkOverlay)
        addSubview(whiteBoxView)
        whiteBoxView.addSubview(titleLabel)
        whiteBoxView.addSubview(logoImageView)
        whiteBoxView.addSubview(purchaseView)

        
        whiteBoxView.translatesAutoresizingMaskIntoConstraints = false
        whiteBoxView.anchor(top: imageView.bottomAnchor, paddingTop: -0.7*145, bottom: imageView.bottomAnchor, paddingBottom: 0, left: imageView.leftAnchor, paddingLeft: 0, right: imageView.rightAnchor, paddingRight: 0, width: 0, height: 0)
        
        imageView.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 130, height: 145)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.anchor(top: imageView.topAnchor, paddingTop: 0.3*145-25, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 50, height: 50)
        logoImageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        
        titleLabel.anchor(top: logoImageView.bottomAnchor, paddingTop: 4, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        
        purchaseView.anchor(top: titleLabel.bottomAnchor, paddingTop: 4, bottom: nil, paddingBottom: 0, left: imageView.leftAnchor, paddingLeft: 16, right: imageView.rightAnchor, paddingRight: 8, width: 0, height: 40)
        
    }
}

struct Reward {
    var image: String
    var logo: String
    var title: String
    var purchasesToGo: Int
}
