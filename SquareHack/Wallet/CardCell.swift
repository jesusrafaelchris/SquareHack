import UIKit

class CardCell: HFCardCollectionViewCell {
    
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    
    var cardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    var blackBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    var simImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sim")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var squareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "square")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        layer.cornerRadius = 16
        layer.masksToBounds = true

        // Add the black bar, label, and image views to the cell's contentView
        contentView.addSubview(blackBar)
        contentView.addSubview(simImageView)
        contentView.addSubview(squareImageView)
        contentView.addSubview(cardLabel) // Add cardLabel after blackBar

        NSLayoutConstraint.activate([
            blackBar.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            blackBar.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            blackBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            blackBar.heightAnchor.constraint(equalToConstant: 60),
            
            cardLabel.bottomAnchor.constraint(equalTo: blackBar.bottomAnchor, constant: -10), // Anchor to the bottom of the blackBar
            cardLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            simImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            simImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            simImageView.widthAnchor.constraint(equalToConstant: 60), // Adjusted size
            simImageView.heightAnchor.constraint(equalToConstant: 60), // Adjusted size
            
            squareImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            squareImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            squareImageView.widthAnchor.constraint(equalToConstant: 60), // Adjusted size
            squareImageView.heightAnchor.constraint(equalToConstant: 60), // Adjusted size
        ])
    }
}
