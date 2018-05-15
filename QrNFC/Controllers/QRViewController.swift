//
//  ViewController.swift
//  QrNFC
//

import UIKit

class QRViewController: UIViewController {
  // MARK: - Private types
  
  // MARK: - Outlets
  
  // MARK: - Properties
  @IBOutlet weak var cameraView: CameraView!
  
  var isCameraLoaded: Bool = false
  var isScanned: Bool = false
  
  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if !isCameraLoaded {
      cameraView.activate(withDelegate: self)
      isCameraLoaded = true
    }
    
    if !App.isQRRunned {
      present(Storyboards.main.instantiateViewController(QRInfoViewController.self), animated: true, completion: nil)
    }
  }
  
  @IBAction func backButtonTouched(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  func open(url: URL?) {
    if let url = url {
      UIApplication.shared.open(url, options: [:]) { (_) in
        self.navigationController?.popViewController(animated: true)
      }
    }
  }
  
  @IBAction func cameraPermissionButtonPressed(_ sender: Any) {
    UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, completionHandler: nil)
  }
}


// MARK: - CameraViewDelegate

extension QRViewController: CameraViewDelegate {
  func initializationFailed(withError error: CameraViewError) {
    if error == .permissionDenied {
      let alertController = UIAlertController(title: "Error", message: "We need access to the camera to scan QR codes.", preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Go to settings", style: .default, handler: { (_) in
        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, completionHandler: nil)
      }))
      alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertController, animated: true, completion: nil)
    } else {
      showAlert(message: error.userDescription)
    }
    
    return
  }
  
  func detect(string: String?) {
    if !isScanned {
      guard let string = string, string.count > 0 else {
        return
      }
      
      isScanned = true
      
      var str = string.replacingOccurrences(of: "\u{04}", with: "")
      if !str.contains("http://") &&  !str.contains("https://") {
        str = "https://\(str)"
      }
      
      open(url: URL(string: str))
    }
  }
}

