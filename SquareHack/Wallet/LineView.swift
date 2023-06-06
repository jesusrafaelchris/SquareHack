//
//  LineView.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 06/06/2023.
//

import UIKit

class LineView: UIView {
    override func draw(_ rect: CGRect) {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: rect.width * 0.2, y: rect.height / 2))
        linePath.addLine(to: CGPoint(x: rect.width * 0.85, y: rect.height / 2))
        linePath.lineWidth = 1
        UIColor.white.setStroke()
        linePath.stroke()
    }
}
