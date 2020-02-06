//
//  RoundedLoginBox.swift
//  Weather
//
//  Created by Gabriel Aguido Fraga on 07/10/19.
//  Copyright © 2019 Aguido. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOpacity = 0.5
      layer.shadowOffset = CGSize(width: -1, height: 1)
      layer.shadowRadius = 1

      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

@IBDesignable
class RoundedComponents: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
      didSet {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
      }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
      didSet {
        layer.borderWidth = borderWidth
      }
    }
    
    @IBInspectable var borderColor: UIColor? {
      didSet {
        layer.borderColor = borderColor?.cgColor
      }
    }
    
}
