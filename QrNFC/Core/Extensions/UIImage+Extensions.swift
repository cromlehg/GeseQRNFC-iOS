//
//  UIImage+Color.swift
//

import Foundation
import UIKit
import CoreImage

public extension UIImage {
  public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1), scale: CGFloat = 0.0) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    guard let cgImage = image!.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }
  
  public convenience init?(string: String, size: CGSize = CGSize(width: 150, height: 150)) {
    let stringData = string.data(using: String.Encoding.utf8)
    
    let filter = CIFilter(name: "CIQRCodeGenerator")
    filter?.setValue(stringData, forKey: "inputMessage")
    filter?.setValue("H", forKey: "inputCorrectionLevel")
    
    guard let outputImage = filter?.outputImage else { return nil }
  
    let imageSize = outputImage.extent.size
    let widthRatio = size.width / imageSize.width
    let heightRatio = size.height / imageSize.height
    
    let transformImage = outputImage.transformed(by: CGAffineTransform(scaleX: widthRatio, y: heightRatio))
  
    self.init(ciImage: transformImage, scale: UIScreen.main.scale, orientation: .down)
  }
  
  func resize(to size: CGSize, keepSize: Bool = false) -> UIImage? {
    let widthRatio  = size.width  / self.size.width
    let heightRatio = size.height / self.size.height
    
    var newSize: CGSize
    let ratio = min(widthRatio, heightRatio)
    
    newSize = CGSize(width: self.size.width * ratio, height: self.size.height * ratio)

    let origin = keepSize ? CGPoint(x: (size.width - newSize.width)/2, y: (size.height - newSize.height)/2) : .zero
    
    UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
    draw(in: CGRect(origin: origin, size: newSize))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    guard let image = newImage else {
      return nil
    }
    
    return image
  }
}
