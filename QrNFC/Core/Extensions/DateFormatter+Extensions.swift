//
//  DateFormatter+Extensions.swift
//  CoreExtensions

import Foundation

public extension DateFormatter {
  convenience init(format: String) {
    self.init()
    self.dateFormat = format
  }
}
