//
//  NFCViewController.swift
//  QrNFC
//

import UIKit
import CoreNFC

// MARK: - Public types

class NFCViewController: UIViewController {
  // MARK: - Private types

  // MARK: - Outlets

  // MARK: - Properties
  private var nfcSession: NFCNDEFReaderSession!

  // MARK: - View Controller Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

// MARK: - Actions

extension NFCViewController {
  @IBAction func scanButtonTouched(_ sender: Any) {
    nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
    nfcSession.begin()
  }
  
  @IBAction func backButtonTouched(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}


// MARK: - Actions

extension NFCViewController: NFCNDEFReaderSessionDelegate {
  func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
    showAlert(title: "Ошибка", message: "Не удалось прочитать NFC: \(error.localizedDescription)")
  }
  
  // Called with every successful NFC readout.
  func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
    print("NFC Tag detected:")
    
    for message in messages {
      for record in message.records {
        print("""
          TypeNameFormat - \(record.typeNameFormat)
          Identifier - \(record.identifier)
          Type - \(record.type)
          Payload - \(record.payload)
          """)
      }
    }
  }
}
