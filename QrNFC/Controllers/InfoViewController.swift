//
//  InfoViewController.swift
//  QrNFC
//

import UIKit

// MARK: - Public types

class InfoViewController: UIViewController {
  // MARK: - Private types

  // MARK: - Outlets

  // MARK: - Properties

  // MARK: - View Controller Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    App.isRunned = true
  }
  
}

// MARK: - Actions

extension InfoViewController {
  
  @IBAction func closeButtonTouch(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

}
