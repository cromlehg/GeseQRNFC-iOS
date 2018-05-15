//
//  UITextView+Extensions.swift
//

import UIKit

extension UITextView {
  func setLineHeight(_ value: CGFloat) {
    guard let font = self.font, let textColor = self.textColor else { return }
    
    let style = NSMutableParagraphStyle()
    style.lineSpacing = value - font.pointSize
    style.alignment = textAlignment
    let attr = NSAttributedString(string: self.text ?? "",
                                  attributes: [NSAttributedStringKey.font: font,
                                               NSAttributedStringKey.foregroundColor: textColor,
                                               NSAttributedStringKey.paragraphStyle: style])
    self.attributedText = attr
  }
}
