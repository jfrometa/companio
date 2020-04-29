//
//  CameraViewController.swift
//  DotVet
//
//  Created by Jose Frometa on 4/27/20.
//  Copyright © 2020 Upgrade. All rights reserved.
//

import AVFoundation
import MaterialComponents
import UIKit

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
  var captureSession: AVCaptureSession!
  var stillImageOutput: AVCapturePhotoOutput!
  var videoPreviewLayer: AVCaptureVideoPreviewLayer!

  var previewView = UIView()
  var captureImageView = UIImageView()
  private var started = 0
  private var frontPhoto: Data?

  //private var isReadable = PublishSubject<Bool>()

  private var btnClose: UIButton = {
    let img = UIImage(named: "icn_close")?
      .withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    let _btnClose = UIButton(type: .system)
    _btnClose.tintColor = .white
    _btnClose.setImage(img, for: .normal)
    _btnClose.imageView?.tintColor = .white
    _btnClose.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
   // _btnClose.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)

    return _btnClose
  }()

  private var titleLbl: UILabel = {
    let lbl = UILabel()

    var att = NSMutableAttributedString(
      string: "document",
      attributes: [NSAttributedString.Key.font:
        UIFont.systemFont(ofSize: 20),
                   NSAttributedString.Key.foregroundColor: UIColor.white]
    )

    lbl.attributedText = att
    lbl.textAlignment = .center
    return lbl
  }()

  private lazy var lblSubTitle: UILabel = {
    let text = UILabel()

    text.backgroundColor = .clear
    text.textAlignment = .center

    return text
  }()

  private lazy var lblMessage: UILabel = {
    let text = UILabel()
    text.attributedText = "take_photo.helper_message".formatTextWithFont()

    text.backgroundColor = .clear
    text.textAlignment = .center
    text.numberOfLines = 4
    return text
  }()

  let cameraBtn: UIView = {
    let innerCircle = UIView()
    innerCircle.layer.borderColor = UIColor.gray.cgColor
    innerCircle.layer.borderWidth = 3
    innerCircle.layer.cornerRadius = 30 // half the width/height
    innerCircle.backgroundColor = .white

    let circle = UIView()
    circle.layer.borderColor = UIColor.white.cgColor
    circle.layer.borderWidth = 3
    circle.layer.cornerRadius = 33 // half the width/height
    circle.backgroundColor = .clear

    circle.addSubview(innerCircle)

//    constrain(innerCircle, circle) {
//      ic, c in
//
//      ic.height == 60
//      ic.width == 60
//
//      c.height == 66
//      c.width == 66
//
//      ic.centerX == c.centerX
//      ic.centerY == c.centerY
//    }
    return circle
  }()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    askPermission()
    // setupLivePreview()
    startCamera()
  }

  init() {
    super.init(nibName: nil, bundle: nil)
    reloadAccordingToSide()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  private func reloadAccordingToSide() {
    setupView()
  }

  private func setupView() {
    lblSubTitle.attributedText = "side".formatTextWithFont(color: .white)
  }

  private func capturePhotoAgain() {
  }

  func setupLivePreview() {
    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)

    videoPreviewLayer.videoGravity = .resizeAspectFill
    videoPreviewLayer.connection?.videoOrientation = .portrait
    videoPreviewLayer.cornerRadius = 8
    previewView.layer.addSublayer(videoPreviewLayer)
    previewView.layer.cornerRadius = 8

    view.addSubview(titleLbl)
    view.addSubview(previewView)
    view.addSubview(lblSubTitle)
    view.addSubview(lblMessage)
    view.addSubview(cameraBtn)

    cameraBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTakePhoto)))

//    constrain(titleLbl, previewView, cameraBtn, lblSubTitle, lblMessage, view) {
//      title, preview, button, sub, message, v in
//
//      title.top == v.safeAreaLayoutGuide.topMargin
//      title.leading == v.leading + 37
//      title.trailing == v.trailing - 37
//      title.height == 40
//
//      preview.top <= title.bottom + 25
//      preview.leading == v.leading + 9
//      preview.trailing == v.trailing - 9
//      preview.height == 240
//
//      sub.top == preview.bottom + 15
//      sub.leading == v.leading + 30
//      sub.trailing == v.trailing - 30
//
//      message.top == sub.bottom + 10
//      message.leading == v.leading + 30
//      message.trailing == v.trailing - 30
//
//      button.top >= sub.bottom + 150
//      button.leading <= preview.leading + 145
//      button.trailing >= preview.trailing - 145
//      button.bottom <= v.safeAreaLayoutGuide.bottom - 40
//    }

    DispatchQueue.global(qos: .userInitiated).async {
      self.captureSession.startRunning()
      DispatchQueue.main.async {
        self.videoPreviewLayer.frame = self.previewView.bounds
      }
    }
  }

  func startCamera() {
    captureSession = AVCaptureSession()
    captureSession.sessionPreset = .medium

    guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
    else {
      print("Unable to access back camera!")
      return
    }
    do {
      let input = try AVCaptureDeviceInput(device: backCamera)
      stillImageOutput = AVCapturePhotoOutput()
      stillImageOutput.isHighResolutionCaptureEnabled = true

      if captureSession.canAddInput(input), captureSession.canAddOutput(stillImageOutput) {
        captureSession.addInput(input)
        captureSession.addOutput(stillImageOutput)
        setupLivePreview()
      }
    } catch {
      print("Error Unable to initialize back camera:  \(error.localizedDescription)")
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    parent?.navigationController?.setNavigationBarHidden(true, animated: false)
    view.backgroundColor = .darkGray

              self.setupView()
   
        self.capturePhotoAgain()
      
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    captureSession.stopRunning()
  }

  func photoOutput(_: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error _: Error?) {
    guard let imageData = photo.fileDataRepresentation()
    else { return }

    if let rawImg = UIImage(data: imageData) {
//      if let image = rawImg.jpeg(.medium) {
//
//      }
    }
  }

  @objc func didTakePhoto(_: Any) {
    let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
    settings.isAutoStillImageStabilizationEnabled = true

    settings.isHighResolutionPhotoEnabled = true
    stillImageOutput.capturePhoto(with: settings, delegate: self)
  }

  func askPermission() {
    let cameraPermissionStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

    switch cameraPermissionStatus {
    case .authorized:
      break
    case .denied:
      let alert = UIAlertController(title: "Sorry :(", message: "But  could you please grant permission for camera within device settings", preferredStyle: .alert)

      let action = UIAlertAction(title: "Ok",
                                 style: .cancel,
                                 handler: { _ in

                                   UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
      })

      alert.addAction(action)
      present(alert, animated: true, completion: nil)

    case .restricted:
      break
    default:
      AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {
        [weak self]
        (granted: Bool) -> Void in

        if granted == true {
          // User granted
          DispatchQueue.main.async {
            // Do smth that you need in main thread
          }
        } else {
          // User Rejected
          DispatchQueue.main.async {
            let alert = UIAlertController(title: "WHY?", message: "Camera it is the main feature of our application", preferredStyle: .alert)

            let action = UIAlertAction(title: "Ok",
                                       style: .cancel,
                                       handler: { _ in

                                         UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                                                   options: [:], completionHandler: nil)
            })

            alert.addAction(action)
            self?.present(alert, animated: true, completion: nil)
          }
        }
      })
    }
  }

  @objc private func dismissModal() {
    dismiss(animated: true, completion: nil)
  }
}
