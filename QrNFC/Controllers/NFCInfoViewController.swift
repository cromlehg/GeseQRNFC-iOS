//
//  NFCInfoViewController.swift
//  QrNFC
//

import UIKit

// MARK: - Public types

class NFCInfoViewController: UIViewController {
  // MARK: - Private types

  // MARK: - Outlets

  // MARK: - Properties

  // MARK: - View Controller Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    App.isNFCRunned = true
  }
}

// MARK: - Actions

extension NFCInfoViewController {
  @IBAction func closeButtonTouch(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
