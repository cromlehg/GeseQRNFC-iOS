//
//  UIView+Extensions.swift
//

import UIKit

public extension UIView {
  func configure(background: UIColor = .clear, borderColor: UIColor = .clear, borderWidth: CGFloat = 0.0, cornerRadius: CGFloat = 0.0) {
    self.layer.cornerRadius = cornerRadius
    self.layer.borderWidth = borderWidth
    self.layer.masksToBounds = cornerRadius > 0
    self.layer.borderColor = borderColor.cgColor
    self.backgroundColor = background
  }
  
  func round(with radius: CGFloat = 18) {
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = radius > 0
  }
  
  func addGradient(fromColor color1: UIColor, toColor color2: UIColor, isVertical: Bool = true ) {
    //Remove previos gradient
    removeGradients()
    
    let gradient: CAGradientLayer = CAGradientLayer()
    
    gradient.colors = [color1.cgColor, color2.cgColor]
    gradient.locations = [0.0, 1.0]
    if isVertical {
      gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
      gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
    } else {
      gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
      gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    }
    gradient.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
    
    layer.insertSublayer(gradient, at: 0)
  }
  
  func removeGradients() {
    layer.sublayers?.filter({ $0.isKind(of: CAGradientLayer.self) }).forEach({ $0.removeFromSuperlayer() })
  }
  
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true, bounds: CGRect? = nil) {
    self.layer.masksToBounds = false
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOpacity = opacity
    self.layer.shadowOffset = offSet
    self.layer.shadowRadius = radius
    
    self.layer.shadowPath = UIBezierPath(rect: bounds ?? self.bounds).cgPath
    self.layer.shouldRasterize = true
    self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
  
  func pinSubview(_ view: UIView, inset: UIEdgeInsets = .zero) {
    view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(view)
    
    NSLayoutConstraint.activate([
      view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset.left),
      trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset.right),
      view.topAnchor.constraint(equalTo: topAnchor, constant: inset.top),
      bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom)
    ])
  }  
}
