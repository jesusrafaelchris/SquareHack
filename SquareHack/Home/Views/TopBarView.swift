import UIKit
import Firebase

protocol TopBarViewDelegate: AnyObject {
    func actionHandle(sender: UIAction)
}

class TopBarView: UIView {
    
    weak var delegate: TopBarViewDelegate?
    
    lazy var profileImage: UIButton = {
        let imageView = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "person.fill", withConfiguration: largeConfig)?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        imageView.setImage(largeBoldDoc, for: .normal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let profileAction = UIAction(title: "Profile", image: UIImage(systemName: "person.crop.circle"), identifier: nil) { sender in
            self.actionHandle(sender: sender)
        }
        let subscriptionAction = UIAction(title: "Manage Subscription", image: UIImage(systemName: "pencil"), identifier: nil) { sender in
            self.actionHandle(sender: sender)
        }
        let settingsAction = UIAction(title: "Settings", image: UIImage(systemName: "gearshape"), identifier: nil) { sender in
            self.actionHandle(sender: sender)
        }
        let signOutAction = UIAction(title: "Sign Out", image: UIImage(systemName: "arrowshape.turn.up.backward"), attributes: .destructive) { sender in
            self.actionHandle(sender: sender)
        }
        let submenu = UIMenu(title: "", options: .displayInline, children: [signOutAction])
        let menu = UIMenu(title: "", children: [profileAction, subscriptionAction, settingsAction, submenu])
        imageView.menu = menu
        imageView.showsMenuAsPrimaryAction = true
        return imageView
    }()

    lazy var timeLabel: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 16)
        
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let dateComponents = userCalendar.dateComponents([.hour], from: currentDateTime)
        
        if let hour = dateComponents.hour {
            if hour >= 5 && hour < 12 {
                text.text = "Good Morning"
            } else if hour >= 12 && hour < 17 {
                text.text = "Good Afternoon"
            } else if hour >= 17 && hour < 22 {
                text.text = "Good Evening"
            } else {
                text.text = "Good Night"
            }
        } else {
            text.text = "Hello"
        }
        return text
    }()

    lazy var nameLabel: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 16)
        if let displayName = Auth.auth().currentUser?.displayName {
            let nameComponents = displayName.split(separator: " ")
            if let firstName = nameComponents.first {
                text.text = String(firstName)
            }
        }
        return text
    }()

    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(nameLabel)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImage)
        addSubview(timeLabel)
        addSubview(nameLabel)
        
        profileImage.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: rightAnchor, paddingRight: 8, width: 28, height: 28)
        profileImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        timeLabel.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        nameLabel.anchor(top: timeLabel.bottomAnchor, paddingTop: 1, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func actionHandle(sender: UIAction) {
        delegate?.actionHandle(sender: sender)
    }

}

