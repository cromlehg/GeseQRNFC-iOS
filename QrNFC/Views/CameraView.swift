//
//  CameraView.swift
//
//  Created by Yakubov on 23.10.17.
//

import UIKit
import AVFoundation

/**
 Enumeration for camera view errors
 */
enum CameraViewError: Error {
  case wrongDevice
  case wrongOutput
  case wrongPreviewLayer
  case unknown
  case permissionDenied
  
  var localizedDescription: String {
    switch self {
    case .wrongDevice:
      return "Не удалось активировать камеру"
    case .wrongOutput:
      return "Не удалось активировать камеру"
    case .wrongPreviewLayer:
      return "Не удалось получить изображение с камеры"
    case .permissionDenied:
       return "Нет доступа к камере"
    case .unknown:
      return "Неизвестная ошибка"
    }
  }
  
  var userDescription: String {
    return self.localizedDescription
  }
}

/**
 Protocal for CameraView delegate
 */
protocol CameraViewDelegate: class {
  /**
   Called when camera initialization produce error
   - parameter error: CameraViewError
   */
  func initializationFailed(withError error: CameraViewError)
  
  /**
   Called when camera detect barcode
  - parameter barcode: detected barcode as String
   */
  func detect(string: String?)
}

/**
 View for show camera and detect barcodes
 
  - important:
 When the dimensions are set, you must call the method activate(withDelegate delegate: CameraViewDelegate? = nil) to initialize camera

 */
class CameraView: UIView {
  
  // MARK: - Private Properties
  private var session: AVCaptureSession?
  private var device: AVCaptureDevice?
  private var input: AVCaptureDeviceInput?
  private var output: AVCaptureMetadataOutput?
  private var previewLayer: AVCaptureVideoPreviewLayer?
  
  // MARK: - Properties

  weak var delegate: CameraViewDelegate?
  
  var barcodeTypes = [AVMetadataObject.ObjectType.upce, AVMetadataObject.ObjectType.code39, AVMetadataObject.ObjectType.code39Mod43,
                      AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.code128,
                      AVMetadataObject.ObjectType.pdf417, AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.aztec]
  

  deinit {
    session?.stopRunning()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit() {
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
    addGestureRecognizer(recognizer)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    previewLayer?.frame = bounds
  }
  
  
  func activate(withDelegate delegate: CameraViewDelegate? = nil) {
    self.delegate = delegate

    AVCaptureDevice.requestAccess(for: AVMediaType.video) { [unowned self] (result) in
      DispatchQueue.main.async {
        if result {
          self.activateSession()
        } else {
          self.delegate?.initializationFailed(withError: .permissionDenied)
        }
      }
    }
  }
  
  private func activateSession() {
    do {
      session = AVCaptureSession()
      
      guard let camera = AVCaptureDevice.default(for: AVMediaType.video),
            let session = session else {
        throw CameraViewError.wrongDevice
      }
      
      device = camera

      input = try AVCaptureDeviceInput(device: device!)
      
      session.addInput(input!)
      
      output = AVCaptureMetadataOutput()
      guard let output = output else {
        throw CameraViewError.wrongDevice
      }
      
      output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      session.addOutput(output)
      output.metadataObjectTypes = output.availableMetadataObjectTypes
      
      previewLayer = AVCaptureVideoPreviewLayer(session: session)
      
      guard let previewLayer = previewLayer else {
        throw CameraViewError.wrongPreviewLayer
      }
      previewLayer.frame = bounds
      previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
      layer.addSublayer(previewLayer)
      
      output.metadataObjectTypes = barcodeTypes
      DispatchQueue.global(qos: .userInitiated).async {
        session.startRunning()
      }
    } catch let error as CameraViewError {
      delegate?.initializationFailed(withError: error)
      return
    } catch {
      if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .denied {
        delegate?.initializationFailed(withError: .permissionDenied)
      } else {
        delegate?.initializationFailed(withError: .unknown)
      }
      return
    }
  }
  
  @objc private func didTap(_ recognizer: UITapGestureRecognizer) {
    if let device = device {
      let location = recognizer.location(in: self)
      let focusPoint = CGPoint(x: location.y / self.frame.size.height, y: location.x / self.frame.size.width)
      
      do {
        try device.lockForConfiguration()
        
        if device.isFocusPointOfInterestSupported {
          device.focusPointOfInterest = focusPoint
          device.focusMode = .autoFocus
        }

//        if device.isExposurePointOfInterestSupported {
//          device.exposurePointOfInterest = focusPoint
//          device.exposureMode = .autoExpose
//        }
        
        device.unlockForConfiguration()
      } catch {
        
      }
    }
  }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension CameraView: AVCaptureMetadataOutputObjectsDelegate {
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    var detectionString: String?
    for metadata in metadataObjects {
      for type in barcodeTypes {
        if let metadata = metadata as? AVMetadataMachineReadableCodeObject, metadata.type == type {
          detectionString = metadata.stringValue!
          break
        }
      }
    }
    
    delegate?.detect(string: detectionString)
  }
}

