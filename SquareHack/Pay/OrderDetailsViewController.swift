import UIKit

class OrderDetailsViewController: UIViewController {
    
    var orderItems = [
        OrderItemModel(amount: "1", itemImage: "https://www.jacobsdouweegbertsprofessional.co.uk/contentassets/41f932f582d646939e331c1921d5e63a/coffee-cup-bean-eyes-diy-395x392.jpg?preset=two-halves-image-mobile-mobile", itemTitle: "Caffe Latte", itemDescription: "Coffee", itemprice: "4.1", availablePoints: 124),
        OrderItemModel(amount: "1", itemImage: "https://static.onecms.io/wp-content/uploads/sites/43/2022/07/05/8350-chantals-new-york-ddmfs-cheesecake-3x4-311.jpg", itemTitle: "Cheesecake", itemDescription: "Dessert", itemprice: "2.4", availablePoints: 62)
    ]
    
    lazy var headerview: OrderDetailHeaderView = {
        let view = OrderDetailHeaderView()
        return view
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
    
    lazy var checkoutImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "Checkout3")
        return imageView
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
        headerview.configure(model: OrderHeaderModel(restaurantName: "Pret A Manger", potentialPoints: 398))
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(headerview)
        view.addSubview(orderCollectionView)
        view.addSubview(checkoutImage)
        
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
        checkoutImage.anchor(top: orderCollectionView.bottomAnchor, paddingTop: 26, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: view.rightAnchor, paddingRight: 16, width: 0, height: 350)
        
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
