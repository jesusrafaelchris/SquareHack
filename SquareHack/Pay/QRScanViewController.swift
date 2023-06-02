//
//  QRScanViewController.swift
//  SquareHack
//
//  Created by Artemiy Malyshau on 30/05/2023.
//

import AVFoundation
import UIKit

class QRScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var metadataOutput = AVCaptureMetadataOutput()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(handleBackTap), for: .touchUpInside)
        return button
    }()
    
    lazy var titleButton: UIButton = {
        let button = UIButton()
        if let creamColor = UIColor.redColour?.cgColor {
            button.layer.backgroundColor = creamColor
        }
        button.setTitle("Scan the QR Code provided \n by the establishment you're at", for: .normal)
        button.setTitleColor(.creamColour, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 22
        button.isEnabled = false
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let centerFrameView: UIView = {
        let view = UIView()
        if let creamColor = UIColor.creamColour?.cgColor {
            view.layer.borderColor = creamColor
        }
        view.layer.borderWidth = 6
        view.layer.cornerRadius = 26
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        // captureSession.startRunning()
        
        view.addSubview(centerFrameView)
        NSLayoutConstraint.activate([
            centerFrameView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerFrameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerFrameView.heightAnchor.constraint(equalToConstant: 230),
            centerFrameView.widthAnchor.constraint(equalToConstant: 230)
        ])
        
        setUpView()
    }
    
    @objc func handleBackTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let rect = view.bounds
        let centerFrameRect = centerFrameView.frame
        let rectOfInterest = CGRect(x: centerFrameRect.minY / rect.height,
                                    y: centerFrameRect.minX / rect.width,
                                    width: centerFrameRect.height / rect.height,
                                    height: centerFrameRect.width / rect.width)
        metadataOutput.rectOfInterest = rectOfInterest
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !captureSession.isRunning {
            // Run the session in the background to avoid blocking the UI
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.captureSession.startRunning()
            }
        }
        view.bringSubviewToFront(centerFrameView)
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print("metadataOutput called")
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }

            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            print("Found code: \(stringValue)")
            found(code: stringValue)
        }
    }

    func found(code: String) {
        DispatchQueue.main.async { [weak self] in
            print(code)
            let newViewController = OrderDetailsViewController()
            newViewController.scannedCode = code
            self?.navigationController?.pushViewController(newViewController, animated: true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    func setUpView() {
        view.addSubview(backButton)
        view.addSubview(titleButton)
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 24, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 40, height: 40)
        
        titleButton.anchor(top: backButton.bottomAnchor, paddingTop: 38, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 250, height: 90)
        titleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
