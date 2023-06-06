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
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.text = "0 Points"
        return text
    }()
    
    lazy var triangleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.right.fill")?.withTintColor(.white).withRenderingMode(.alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var lineView: LineView = {
        let view = LineView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var subLabel: UILabel = {
        let text = UILabel()
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.text = "You're not subscribed to\nPret A Manger"
        text.numberOfLines = 2
        text.textAlignment = .center
        return text
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
        addSubview(lineView)
        addSubview(subLabel)
        
        buttonStackView.anchor(top: topAnchor, paddingTop: 44,
                               bottom: nil, paddingBottom: 0,
                               left: nil, paddingLeft: 0,
                               right: nil, paddingRight: 0,
                               width: 0, height: 0)
        buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        
        iconImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        triangleImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        triangleImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: -5).isActive = true
        
        triangleImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        triangleImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        lineView.anchor(top: topAnchor, paddingTop: 0,
                        bottom: bottomAnchor, paddingBottom: 0,
                        left: leftAnchor, paddingLeft: frame.width * 0.2,
                        right: rightAnchor, paddingRight: frame.width * 0.15,
                        width: 0, height: 0)
        
        subLabel.anchor(top: buttonStackView.bottomAnchor, paddingTop: 38, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        subLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

    }
}
