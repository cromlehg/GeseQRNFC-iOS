//
//  UILabel+Extension.swift
//

import UIKit

extension UILabel {
  func setLineHeight(_ value: CGFloat) {
    let style = NSMutableParagraphStyle()
    style.lineSpacing = value - self.font.pointSize
    style.alignment = self.textAlignment
    style.lineBreakMode = lineBreakMode
    let attr = NSAttributedString(string: self.text ?? "",
                                  attributes: [NSAttributedStringKey.font: self.font,
                                               NSAttributedStringKey.foregroundColor: self.textColor,
                                               NSAttributedStringKey.paragraphStyle: style])
    self.attributedText = attr
  }
}
