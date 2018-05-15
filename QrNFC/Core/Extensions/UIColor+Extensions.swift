//
//  UIColor+Helper.swift
//

import Foundation
import UIKit

public extension UIColor {

  public convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")

    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }

  public convenience init(netHex: Int) {
    self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
  }

  public convenience init(hexString: String) {
    var red   = CGFloat(0)
    var green = CGFloat(0)
    var blue  = CGFloat(0)
    var alpha = CGFloat(1)
    
    var hex = hexString
    
    if hexString.lowercased() == "silver" {
      hex = "C0C0C0"
    }
    
    hex = hex.replacingOccurrences(of: "#", with: "")
    hex = hex.replacingOccurrences(of: "0x", with: "")
    
    let scanner  = Scanner(string: hex)
    var hexValue = CUnsignedLongLong(0)
    
    if scanner.scanHexInt64(&hexValue) {
      switch hex.count {
      case 3:
        red   = CGFloat((hexValue & 0xF00) >> 8) / 15.0
        green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
        blue  = CGFloat(hexValue  & 0x00F)       / 15.0
      case 4:
        red   = CGFloat((hexValue & 0xF000) >> 12) / 15.0
        green = CGFloat((hexValue & 0x0F00) >> 8)  / 15.0
        blue  = CGFloat((hexValue & 0x00F0) >> 4)  / 15.0
        alpha = CGFloat(hexValue  & 0x000F)        / 15.0
      case 6:
        red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
        blue  = CGFloat(hexValue  & 0x0000FF)        / 255.0
      case 8:
        red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
        green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
        blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
        alpha = CGFloat(hexValue  & 0x000000FF)        / 255.0
      default:
        // Лучше вываливать эксепшн, но пока будет черный цвет
        break
      }
    }
    
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  public class func colorFromRGBValue(_ rgbValue: UInt) -> UIColor {
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }

  public class func colorFromARGBValue(_ argbValue: Int32) -> UIColor {
    return UIColor(
      red: CGFloat((argbValue >> 16) & 0xFF) / 255.0,
      green: CGFloat((argbValue >> 8) & 0xFF) / 255.0,
      blue: CGFloat(argbValue & 0xFF) / 255.0,
      alpha: CGFloat((argbValue >> 24) & 0xFF) / 255.0
    )
  }
}

extension UIColor {

  public var cRed: CGFloat {
    if let components = self.cgColor.components, components.count > 0 {
      return self.cgColor.components![0]
    } else {
      return 0
    }
  }

  public var cGreen: CGFloat {
    if let components = self.cgColor.components, components.count > 1 {
      return self.cgColor.components![1]
    } else {
      return 0
    }
  }

  public var cBlue: CGFloat {
    if let components = self.cgColor.components, components.count > 2 {
      return self.cgColor.components![2]
    } else {
      return 0
    }
  }

  public var cAlpha: CGFloat {
    if let components = self.cgColor.components, components.count > 3 {
      return self.cgColor.components![3]
    } else {
      return 1
    }
  }
}

extension UIColor {

  public func rgbCode() -> Int {
    var fRed: CGFloat = 0
    var fGreen: CGFloat = 0
    var fBlue: CGFloat = 0
    var fAlpha: CGFloat = 0
    if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
      let iRed = Int(fRed * 255.0)
      let iGreen = Int(fGreen * 255.0)
      let iBlue = Int(fBlue * 255.0)
      let iAlpha = Int(fAlpha * 255.0)

      //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
      let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
      return rgb
    } else {
      // Could not extract RGBA components:
      return 0
    }
  }
}
