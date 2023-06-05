import UIKit

class CardCell: HFCardCollectionViewCell {
    
    
    // logo text - 688 (w) x 88(l)
    // logo image - 1132 (w) × 1056 (h)
    //------------------------
    //- Change the name on card to the users name
    
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    
    var qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "qr")
        return imageView
    }()
    
    var topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    var bottomRightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    var cardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    var simImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var squareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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

        contentView.addSubview(simImageView)
        contentView.addSubview(squareImageView)
        contentView.addSubview(cardLabel)
        contentView.addSubview(topLabel)
        contentView.addSubview(bottomRightLabel)
        contentView.addSubview(qrImageView)

        NSLayoutConstraint.activate([
            
            //membership number
            cardLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            cardLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            //qr code
            qrImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            qrImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            qrImageView.widthAnchor.constraint(equalToConstant: 100),
            qrImageView.heightAnchor.constraint(equalToConstant: 100),
            
            //text logo
            simImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10),
            simImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            simImageView.widthAnchor.constraint(equalToConstant: 120),
            simImageView.heightAnchor.constraint(equalToConstant: 120),
            
            //logo
            squareImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            squareImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            squareImageView.widthAnchor.constraint(equalToConstant: 60),
            squareImageView.heightAnchor.constraint(equalToConstant: 60),

            //name
            topLabel.bottomAnchor.constraint(equalTo: cardLabel.topAnchor, constant: -5),
            topLabel.leftAnchor.constraint(equalTo: cardLabel.leftAnchor),
            
            // points
            bottomRightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            bottomRightLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
        ])
    }
    
    func setImage(name: String) {
        self.simImageView.image = UIImage(named: name)
    }
    
    func setSquareImage(name: String) {
        self.squareImageView.image = UIImage(named: name)
    }
}
