//
//  ShapeView.swift
//  MotionCube
//
//  Created by Vladyslav FIL on 10/3/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import UIKit

class ShapeView: UIView {
    let size: CGFloat = 100
    var isCycle: Int = .random(in: 0...2)
    
    init(point: CGPoint) {
        super.init(frame: CGRect(x: point.x, y: point.y, width: size, height: size))
        self.setProperties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setProperties()
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return (self.isCycle == 1) ? .ellipse : .rectangle
    }
}


extension ShapeView {
    func setProperties() {
        self.backgroundColor = .random()
        self.layer.cornerRadius = (self.isCycle == 1) ? 50.0 : 1.0;
    }
}


extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
