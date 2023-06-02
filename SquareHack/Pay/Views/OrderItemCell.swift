import UIKit
import SDWebImage

class OrderItemCell: UICollectionViewCell {
    
    lazy var itemAmount: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 16)
        return text
    }()
    
    lazy var itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var itemLabel: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 18)
        return text
    }()
    
    lazy var itemDescription: UILabel = {
        let text = UILabel()
        text.textColor = .secondaryLabel
        text.font = UIFont.systemFont(ofSize: 12)
        return text
    }()
    
    lazy var availablePoints: UIButton = {
        let configuration = titleImageConfigure(title: "", image: "diamond.fill")
        let button = UIButton(configuration: configuration)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 8)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var featuredStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 2
        stackView.addArrangedSubview(itemLabel)
        stackView.addArrangedSubview(itemDescription)
        return stackView
    }()
    
    lazy var itemPrice: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 14)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: OrderItemModel) {
        itemAmount.text = "\(model.amount) x"
        itemImage.sd_setImage(with: URL(string: model.itemImage), placeholderImage: UIImage(systemName: "questionmark.app"))
        itemLabel.text = model.itemTitle
        itemDescription.text = model.itemDescription
        availablePoints.setTitle("\(model.availablePoints)", for: .normal)
        itemPrice.text = "£\(model.itemprice)"
    }
    
    func setupView() {
        addSubview(itemAmount)
        addSubview(itemImage)
        addSubview(featuredStackView)
        addSubview(availablePoints)
        addSubview(itemPrice)

        itemAmount.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        itemAmount.centerYAnchor.constraint(equalTo: itemImage.centerYAnchor).isActive = true

        itemImage.anchor(top: topAnchor, paddingTop: 8, bottom: nil, paddingBottom: 8, left: itemAmount.rightAnchor, paddingLeft: 8, right: nil, paddingRight: 0, width: 45, height: 45)
        
        featuredStackView.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: itemImage.rightAnchor, paddingLeft: 12, right: itemPrice.leftAnchor, paddingRight: 8, width: 0, height: 0)
        featuredStackView.centerYAnchor.constraint(equalTo: itemImage.centerYAnchor).isActive = true
        
        availablePoints.anchor(top: featuredStackView.bottomAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, left: itemImage.rightAnchor, paddingLeft: 12, right: nil, paddingRight: 0, width: 0, height: 0)
        
        itemPrice.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 0, height: 0)
        itemPrice.centerYAnchor.constraint(equalTo: itemLabel.centerYAnchor).isActive = true
    }
    
    
    private func titleImageConfigure(title: String, image: String) -> UIButton.Configuration {
        var container = AttributeContainer()
        container.foregroundColor = .white
        var configuration = UIButton.Configuration.plain()
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
          var outgoing = incoming
          outgoing.font = UIFont.boldSystemFont(ofSize: 12)
          return outgoing
         }
        configuration.attributedTitle = AttributedString(title, attributes: container)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold, scale: .small)
        let largeBoldDoc = UIImage(systemName: image, withConfiguration: largeConfig)?.withTintColor(.redColour ?? .black).withRenderingMode(.alwaysOriginal)
        configuration.image = largeBoldDoc
        configuration.buttonSize = .mini
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 4
        return configuration
    }
}
