import UIKit

class OrderDetailsViewController: UIViewController {
    
    var scannedCode: String?
    
    var orderItems = [
        OrderItemModel(amount: "1", itemImage: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Hamburger_%28black_bg%29.jpg/1200px-Hamburger_%28black_bg%29.jpg", itemTitle: "Double Cheeseburger", itemDescription: "Cheese, Tomato, Lettuce", itemprice: "32.16", availablePoints: 1429),
        OrderItemModel(amount: "4", itemImage: "https://www.recipetineats.com/wp-content/uploads/2022/09/Fries-with-rosemary-salt_1.jpg", itemTitle: "Fries", itemDescription: "Peri Salt, Mayonaise", itemprice: "4.30", availablePoints: 62)
    ]
    
    lazy var headerview: OrderDetailHeaderView = {
        let view = OrderDetailHeaderView()
        return view
    }()
    
    lazy var qrCodeString: UILabel = {
        let label = UILabel()
        label.text = scannedCode
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var orderCollectionView: UICollectionView = {
        let flowlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowlayout)
        collectionView.register(OrderItemCell.self, forCellWithReuseIdentifier: "orderItemCell")
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
//    lazy var mainStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        stackView.alignment = .leading
//        stackView.spacing = 4
//        stackView.addArrangedSubview(headerview)
//        stackView.addArrangedSubview(orderCollectionView)
//        return stackView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        populateUI()
        self.navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.async {
            self.orderCollectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomBorder()
    }
    
    func populateUI() {
        headerview.configure(model: OrderHeaderModel(restaurantName: "Eat Tokyo Burgers", potentialPoints: 398))
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(headerview)
        view.addSubview(orderCollectionView)
        view.addSubview(qrCodeString)
        
        headerview.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12,
                             bottom: nil, paddingBottom: 0,
                             left: view.leftAnchor, paddingLeft: 20,
                             right: view.rightAnchor, paddingRight: 20,
                             width: 0, height: 0)
        headerview.potentialEarnPoints.widthAnchor.constraint(equalTo: headerview.widthAnchor).isActive = true
        
        
        orderCollectionView.anchor(top: headerview.bottomAnchor, paddingTop: 20,
                                   bottom: nil, paddingBottom: 0,
                                   left: view.leftAnchor, paddingLeft: 20,
                                   right: view.rightAnchor, paddingRight: 20,
                                   width: 0, height: 200)
        
        qrCodeString.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        qrCodeString.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        qrCodeString.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    func addBottomBorder() {
        let thickness: CGFloat = 1
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: self.orderCollectionView.frame.size.height - thickness, width: self.orderCollectionView.frame.size.width, height:thickness)
        bottomBorder.backgroundColor = UIColor.lightGray.cgColor
        orderCollectionView.layer.addSublayer(bottomBorder)
    }
}

extension OrderDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orderItemCell", for: indexPath) as! OrderItemCell
        let item = orderItems[indexPath.item]
        cell.configure(model: item)
        //cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = CGFloat(90)
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}
