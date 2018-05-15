//
//  UIViewController+Alerts.swift
//

import UIKit

extension UIViewController {
  public func showAlert(title: String = "", message: String = "", buttonTitle: String = "OK", handler: ((UIAlertAction) -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: handler))
    present(alertController, animated: true, completion: nil)
  }
  
  public func showYesNoAlert(title: String = "",
                             message: String = "",
                             yesTitle: String = "Да",
                             noTitle: String = "Нет",
                             yesHandler: ((UIAlertAction) -> Void)? = nil,
                             noHandler: ((UIAlertAction) -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: yesTitle, style: .default, handler: yesHandler))
    alertController.addAction(UIAlertAction(title: noTitle, style: .cancel, handler: noHandler))
    present(alertController, animated: true, completion: nil)
  }
}
