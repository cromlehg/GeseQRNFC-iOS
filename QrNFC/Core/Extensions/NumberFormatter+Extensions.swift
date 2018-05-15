//
//  NumberFormatter+Extensions.swift
//

import Foundation

extension NumberFormatter {
  static var priceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 0
    formatter.groupingSize = 3
    formatter.locale = Locale(identifier: Locale.current.identifier)
    
    return formatter
  }()
  
  static var groupFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSize = 3
    formatter.groupingSeparator = " "
    
    return formatter
  }()
}
