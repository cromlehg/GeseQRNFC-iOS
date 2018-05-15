//
//  UITextField+Extensions.swift
//

import UIKit

extension UITextField {
  var isEmpty: Bool {
    return text?.isEmpty ?? true
  }
  
  public func setLeftPadding(_ padding: CGFloat = 10) {
    leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
    leftViewMode = .always
  }

  public func setRightPadding(_ padding: CGFloat = 10) {
    rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
    rightViewMode = .always
  }
  
  public func setPlaceholderColor(_ color: UIColor = UIColor.gray) {
    attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                               attributes: [NSAttributedStringKey.foregroundColor: color,
                                                            NSAttributedStringKey.font: font ?? UIFont.systemFont(ofSize: 16)])
  }
}
