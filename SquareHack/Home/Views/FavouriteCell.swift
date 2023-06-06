import UIKit

class FavouriteCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
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
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy var hasOfferButton: UIButton = {
        let button = UIButton()
        if let creamColor = UIColor.redColour?.cgColor {
            button.layer.backgroundColor = creamColor
        }
        button.setTitle("Offer", for: .normal)
        button.setTitleColor(.creamColour, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 10.5
        button.isEnabled = false
        button.isHidden = true
        return button
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(data: Favourite) {
        imageView.image = UIImage(named: data.image)
        logoImageView.image = UIImage(named: data.logo)
        titleLabel.text = data.title
        typeLabel.text = data.type
        hasOfferButton.isHidden = !data.hasOffer
    }
    
    private func setUpView() {
        addSubview(imageView)
        imageView.addSubview(darkOverlay)
        addSubview(whiteBoxView)
        whiteBoxView.addSubview(typeLabel)
        imageView.addSubview(titleLabel)
        imageView.addSubview(logoImageView)
        imageView.addSubview(hasOfferButton)

            
        whiteBoxView.translatesAutoresizingMaskIntoConstraints = false
        whiteBoxView.anchor(top: imageView.bottomAnchor, paddingTop: -0.4*150, bottom: imageView.bottomAnchor, paddingBottom: 0, left: imageView.leftAnchor, paddingLeft: 0, right: imageView.rightAnchor, paddingRight: 0, width: 0, height: 0)
        
        imageView.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 240, height: 150)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.anchor(top: imageView.topAnchor, paddingTop: 25, bottom: nil, paddingBottom: 0, left: imageView.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 50, height: 50)
        
        titleLabel.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: logoImageView.rightAnchor, paddingLeft: 8, right: imageView.rightAnchor, paddingRight: 36, width: 0, height: 0)
        titleLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor).isActive = true
        
        hasOfferButton.anchor(top: imageView.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: imageView.rightAnchor, paddingRight: 10, width: 50, height: 21)
        
        typeLabel.anchor(top: imageView.bottomAnchor, paddingTop: -54, bottom: nil, paddingBottom: 0, left: imageView.leftAnchor, paddingLeft: 16, right: imageView.rightAnchor, paddingRight: 24, width: 0, height: 0)
    }
}
struct Favourite {
    var image: String
    var logo: String
    var title: String
    var type: String
    let latitude: Double
    let longitude: Double
    let hasOffer: Bool
}
