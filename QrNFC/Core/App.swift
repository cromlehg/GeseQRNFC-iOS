//
//  App.swift
//  QrNFC

import Foundation

class App {
  static var isRunned: Bool {
    get { return UserDefaults.standard.bool(forKey: "IS_FIRST_RUN") }
    set { UserDefaults.standard.set(newValue, forKey: "IS_FIRST_RUN"); UserDefaults.standard.synchronize() }
  }
  
  static var isQRRunned: Bool {
    get { return UserDefaults.standard.bool(forKey: "IS_FIRST_QR") }
    set { UserDefaults.standard.set(newValue, forKey: "IS_FIRST_QR"); UserDefaults.standard.synchronize() }
  }
  
  static var isNFCRunned: Bool {
    get { return UserDefaults.standard.bool(forKey: "IS_FIRST_NFC") }
    set { UserDefaults.standard.set(newValue, forKey: "IS_FIRST_NFC"); UserDefaults.standard.synchronize() }
  }
}
