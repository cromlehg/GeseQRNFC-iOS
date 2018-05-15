//
//  UIStoryboard+Extensions.swift
//

import Foundation
import UIKit

extension UIStoryboard {
  
  // Use this method to instantiate ViewController from StoryBoard
  // without using string literals in identifier
  // Note: Your custom ViewContoller class's name is used as an identifier.
  
  public func instantiateViewController<T: UIViewController>(_ : T.Type) -> T {
    return self.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
  }
  
}
