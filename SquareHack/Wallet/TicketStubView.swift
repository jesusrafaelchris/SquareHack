import UIKit

class TicketStubView: UIView {
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")?.withTintColor(.white).withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    
    lazy var pointsLabel: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 16)
        text.text = "452 Points"
        return text
    }()
    
    lazy var triangleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.right.fill")?.withTintColor(.white).withRenderingMode(.alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(pointsLabel)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = UIColor(red: 0.57, green: 0.00, blue: 0.15, alpha: 1.00)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        
        addSubview(buttonStackView)
        addSubview(triangleImageView)
        
        buttonStackView.anchor(top: topAnchor, paddingTop: 12,
                               bottom: nil, paddingBottom: 0,
                               left: leftAnchor, paddingLeft: 8,
                               right: rightAnchor, paddingRight: 8,
                               width: 0, height: 0)
        
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        triangleImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        triangleImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: -5).isActive = true
        
        triangleImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        triangleImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
