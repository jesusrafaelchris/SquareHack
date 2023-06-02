import UIKit

class ProgressView: UIView {
    
    func setRewardPoints(_ points: Int) {
        let modPoints = points % 500
        self.currentPoints = CGFloat(modPoints)
        print(currentPoints)
        setNeedsDisplay()
    }
    
    private var totalPoints: CGFloat = 630
    private var currentPoints: CGFloat = 0
    private var checkPointStart: CGFloat = 0
    private var checkPointEnd: CGFloat = 500
    private var checkPointOne: CGFloat = 310
    private var checkPointTwo: CGFloat = 410
    
    var progressBarWidth: CGFloat = 0
    private var progressBarHeight: CGFloat = 4
    private var progressBarYPosition: CGFloat = 46
    private var checkPointHeight: CGFloat = 9

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        progressBarWidth = rect.width
        updateButtonAnchors()
        
        let totalProgressPath = UIBezierPath(roundedRect: CGRect(x: 7.5, y: progressBarYPosition, width: rect.width, height: progressBarHeight), cornerRadius: 0)
        UIColor.gray.setFill()
        totalProgressPath.fill()
        
        let currentProgressWidth = (currentPoints / totalPoints) * rect.width
        let currentProgressPath = UIBezierPath(roundedRect: CGRect(x: 5, y: progressBarYPosition, width: currentProgressWidth, height: progressBarHeight), cornerRadius: 1)
        UIColor.black.setFill()
        currentProgressPath.fill()
        
        let checkpointStart = (checkPointStart / totalPoints) * rect.width
        let checkpointStartPath = UIBezierPath(roundedRect: CGRect(x: checkpointStart + 4, y: progressBarYPosition - checkPointHeight/4, width: checkPointHeight, height: checkPointHeight), cornerRadius: 1)
        UIColor.black.setFill()
        checkpointStartPath.fill()
        
        let checkpointEnd = (checkPointEnd / totalPoints) * rect.width
        let checkPointEndPath = UIBezierPath(roundedRect: CGRect(x: checkpointEnd - checkPointHeight/4, y: progressBarYPosition - checkPointHeight/4, width: checkPointHeight, height: checkPointHeight), cornerRadius: 1)
        UIColor.black.setFill()
        checkPointEndPath.fill()
        
        let checkpointOne = (checkPointOne / totalPoints) * rect.width
        let checkpointOnePath = UIBezierPath(roundedRect: CGRect(x: checkpointOne - progressBarHeight/4, y: progressBarYPosition, width: progressBarHeight, height: progressBarHeight), cornerRadius: 1)
        UIColor.black.setFill()
        checkpointOnePath.fill()
        
        let checkpointOneCirc = (checkPointOne / totalPoints) * rect.width
        let checkpointOneCircPath = UIBezierPath(roundedRect: CGRect(x: checkpointOneCirc - progressBarHeight/4, y: progressBarYPosition - 11, width: progressBarHeight, height: progressBarHeight), cornerRadius: progressBarHeight/2)
        UIColor.gray.setFill()
        checkpointOneCircPath.fill()
        
        let checkpointTwo = (checkPointTwo / totalPoints) * rect.width
        let checkpointTwoPath = UIBezierPath(roundedRect: CGRect(x: checkpointTwo - progressBarHeight/4, y: progressBarYPosition, width: progressBarHeight, height: progressBarHeight), cornerRadius: 1)
        UIColor.black.setFill()
        checkpointTwoPath.fill()
        
        let checkpointTwoCirc = (checkPointTwo / totalPoints) * rect.width
        let checkpointTwoCircPath = UIBezierPath(roundedRect: CGRect(x: checkpointTwoCirc - progressBarHeight/4, y: progressBarYPosition - 11, width: progressBarHeight, height: progressBarHeight), cornerRadius: progressBarHeight/2)
        UIColor.gray.setFill()
        checkpointTwoCircPath.fill()
        
        let currentProgressCirc = (currentPoints / totalPoints) * rect.width * 0.99 + 7.5
        let currentProgressCircPath = UIBezierPath(roundedRect: CGRect(x: currentProgressCirc - progressBarHeight/2 , y: progressBarYPosition - progressBarHeight/2, width: progressBarHeight * 2, height: progressBarHeight * 2), cornerRadius: progressBarHeight)
        UIColor.black.setFill()
        currentProgressCircPath.fill()
    }
    
    lazy var pointButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 10, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "diamond.fill", withConfiguration: largeConfig)?.withTintColor(UIColor.redColour ?? .red).withRenderingMode(.alwaysOriginal)
        button.setImage(largeBoldDoc, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var giftButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "gift.fill", withConfiguration: largeConfig)?.withTintColor(UIColor.redColour ?? .red).withRenderingMode(.alwaysOriginal)
        button.setImage(largeBoldDoc, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var checkButtonOne: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 10, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "diamond.circle", withConfiguration: largeConfig)?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        button.setImage(largeBoldDoc, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var checkButtonTwo: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 10, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "diamond.circle", withConfiguration: largeConfig)?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        button.setImage(largeBoldDoc, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 367, height: 60)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(pointButton)
        addSubview(giftButton)
        addSubview(checkButtonOne)
        addSubview(checkButtonTwo)
        
        pointButton.anchor(top: topAnchor, paddingTop: 15, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        giftButton.anchor(top: topAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 277.5, right: nil, paddingRight: 0, width: 0, height: 0)
    }
    
    func updateButtonAnchors() {
        let paddingLeftForCheckButton1 = (checkPointOne / totalPoints) * progressBarWidth
        let paddingLeftForCheckButton2 = (checkPointTwo / totalPoints) * progressBarWidth

        checkButtonOne.anchor(top: topAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: paddingLeftForCheckButton1 - 6.5, right: nil, paddingRight: 0, width: 0, height: 0)

        checkButtonTwo.anchor(top: topAnchor, paddingTop: 8, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: paddingLeftForCheckButton2 - 6.5, right: nil, paddingRight: 0, width: 0, height: 0)
    }
}
