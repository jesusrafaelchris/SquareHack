//
//  PurchaseCell.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 06/06/2023.
//

import UIKit

class PurchaseView: UIView {
    
    var totalCircles: Int = 5
    var filledCircles: Int = 3
    var circleRadius: CGFloat = 8
    var circleColor: UIColor = .darkGray
    var filledCircleColor: UIColor = UIColor.redColour ?? .red
    var lineColor: UIColor = .darkGray

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let circleSpacing = (rect.width - CGFloat(totalCircles) * circleRadius * 2) / CGFloat(totalCircles + 1)
        var circleX = circleRadius

        for i in 0..<totalCircles {
            let circleY = rect.height / 2
            let circleRect = CGRect(x: circleX - circleRadius, y: circleY - circleRadius, width: circleRadius * 2, height: circleRadius * 2)

            let circlePath = UIBezierPath(ovalIn: circleRect)

            if i < filledCircles {
                filledCircleColor.setFill()
                circlePath.fill()
            } else {
                circleColor.setStroke()
                circlePath.stroke()
            }

            circleX += circleRadius * 2 + circleSpacing
        }
    }
}
