//
//  UINavigationBar+Shadow.swift
//

import UIKit

extension UINavigationBar {
  func addShadow(withSize size: CGSize = CGSize(width: 0, height: 2.0), andColor color: UIColor = UIColor.lightGray, andOpacity opacity: Float = 0.25, andRadius radius: CGFloat = 2) {
    setBackgroundImage(UIImage(color: .white), for: .default)
    shadowImage = UIImage()
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = size
    layer.shadowRadius = radius
  }
}
