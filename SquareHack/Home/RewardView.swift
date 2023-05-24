//
//  RewardView.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 24/05/2023.
//

import UIKit

class RewardView: UIView {
    
    var rewards: [Reward] = [
        Reward(image: "github", title: "Terry", type: "0.001 Ξ"),
        Reward(image: "github", title: "Nine", type: "0.002 Ξ"),
        Reward(image: "github", title: "Rocky", type: "0.0005 Ξ"),
        Reward(image: "github", title: "KFC", type: "0.002 Ξ"),
    ]
    
    lazy var rewardLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "My Rewards"
        return label
    }()
    
    lazy var rewardCollectionView: UICollectionView = {
        let flowlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionview.register(RewardCell.self, forCellWithReuseIdentifier: "rewardCell")
        collectionview.backgroundColor = .clear
        collectionview.isUserInteractionEnabled = true
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(rewardLabel)
        addSubview(rewardCollectionView)
        
        rewardLabel.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        rewardCollectionView.anchor(top: rewardLabel.bottomAnchor, paddingTop: 8, bottom: bottomAnchor, paddingBottom: 10, left: leftAnchor, paddingLeft: 10, right: rightAnchor, paddingRight: 10, width: 0, height: 300)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(rewardCollectionView.frame)
    }
}

extension RewardView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items: \(rewards.count)")
        return rewards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Creating cell for item at \(indexPath)")
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "rewardCell",
            for: indexPath) as? RewardCell else { return UICollectionViewCell() }
        let data = rewards[indexPath.item]
        cell.backgroundColor = .clear
        cell.configure(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width / 2) - 5
        let itemHeight = CGFloat(235)//view.bounds.height / 15
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
