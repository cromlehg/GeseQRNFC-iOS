//
//  ModeSelectorViewController.swift
//  QrNFC
//

import UIKit
import CoreNFC

// MARK: - Public types

class ModeSelectorViewController: UIViewController {
  // MARK: - Private types

  // MARK: - Outlets
  @IBOutlet weak var qrButton: UIButton!
  @IBOutlet weak var nfcButton: UIButton!
  
  // MARK: - Properties
  private var nfcSession: NFCNDEFReaderSession!

  // MARK: - View Controller Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    qrButton.configure(background: UIColor(hexString: "e6e6e6"), borderColor: UIColor(hexString: "c0c0c0"), borderWidth: 1.5, cornerRadius: 50.0)
    nfcButton.configure(background: UIColor(hexString: "e6e6e6"), borderColor: UIColor(hexString: "c0c0c0"), borderWidth: 1.5, cornerRadius: 50.0)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if !App.isRunned {
      present(Storyboards.main.instantiateViewController(InfoViewController.self), animated: true, completion: nil)
    }
  }
  
  func open(url: URL?) {
    if let url = url {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
  
  @IBAction func infoButtonTouched(_ sender: Any) {
    present(Storyboards.main.instantiateViewController(InfoViewController.self), animated: true, completion: nil)
  }
}

// MARK: - Actions

extension ModeSelectorViewController {
  
  @IBAction func qrButtonTouched(_ sender: Any) {
    navigationController?.pushViewController(Storyboards.main.instantiateViewController(QRViewController.self), animated: true)
  }
  
  @IBAction func nfcButtonTouched(_ sender: Any) {
    if nfcSession != nil && nfcSession.isReady {
      nfcSession.invalidate()
    }
    nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
    nfcSession.alertMessage = "Держите телефон рядом с меткой"
    nfcSession.begin()
  }

}

// MARK: - Actions

extension ModeSelectorViewController: NFCNDEFReaderSessionDelegate {
  func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
    print("Error: \(error.localizedDescription)")
//    showAlert(title: "Ошибка", message: "Не удалось прочитать NFC: \(error.localizedDescription)")
  }
  
  // Called with every successful NFC readout.
  func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
    print("NFC Tag detected:")
    
    guard let record = messages.first?.records.first else {
      return
    }
    
    if let stringURL = String(data: record.payload, encoding: .utf8) {
      var str = stringURL.replacingOccurrences(of: "\u{04}", with: "")
      if !str.contains("http://") &&  !str.contains("https://") {
        str = "https://\(str)"
      }
      let url = URL(string: str)
      open(url: url)
    }
  }
}
