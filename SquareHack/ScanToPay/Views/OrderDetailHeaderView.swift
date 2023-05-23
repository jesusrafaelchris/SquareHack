import UIKit

class OrderDetailHeaderView: UIView {
    
    lazy var orderDetailsLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Order Details"
        return label
    }()

    lazy var restaurantName: UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    lazy var potentialEarnPoints: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = .redColour
        label.layer.cornerRadius = 5
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.addArrangedSubview(orderDetailsLabel)
        stackView.setCustomSpacing(2, after: orderDetailsLabel)
        stackView.addArrangedSubview(restaurantName)
        stackView.setCustomSpacing(16, after: restaurantName)
        stackView.addArrangedSubview(potentialEarnPoints)
        return stackView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: OrderHeaderModel) {
        self.restaurantName.text = model.restaurantName
        self.potentialEarnPoints.text = "EARN \(model.potentialPoints) POINTS!"
    }
    
    func setupView() {
        addSubview(stackView)
        stackView.anchor(top: topAnchor, paddingTop: 0,
                         bottom: bottomAnchor, paddingBottom: 0,
                         left: leftAnchor, paddingLeft: 0,
                         right: rightAnchor, paddingRight: 0,
                         width: 0, height: 0)
        
        potentialEarnPoints.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        potentialEarnPoints.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

}
