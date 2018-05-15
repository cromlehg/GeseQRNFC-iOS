//
//  UIScrollView+Extensions.swift
//

import UIKit

public extension UIScrollView {
 public func offsetWithinBounds(for offset: CGPoint) -> CGPoint {
    let maxOffset = CGPoint(x: max(0, contentSize.width - frame.size.width + contentInset.right), y: max(0, contentSize.height - frame.size.height + contentInset.bottom))
    var finalOffset = offset
    
    if !(0...maxOffset.x ~= offset.x) {
      finalOffset.x = offset.x > maxOffset.x ? maxOffset.x : 0
    }
    
    if !(0...maxOffset.y ~= offset.y) {
      finalOffset.y = offset.y > maxOffset.y ? maxOffset.y : 0
    }
    
    return finalOffset
  }
}
