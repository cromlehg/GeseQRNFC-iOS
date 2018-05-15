//
//  QRInfoViewController.swift
//  QrNFC
//

import UIKit

// MARK: - Public types

class QRInfoViewController: UIViewController {
  // MARK: - Private types

  // MARK: - Outlets

  // MARK: - Properties

  // MARK: - View Controller Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    App.isQRRunned = true
  }
}

// MARK: - Actions

extension QRInfoViewController {
  @IBAction func closeButtonTouch(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
