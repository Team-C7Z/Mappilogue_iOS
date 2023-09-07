//
//  CameraViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/09.
//

import UIKit
import AVFoundation

class CameraViewController: BaseViewController {
    let captureSettion = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    let photoOutput = AVCapturePhotoOutput()
    
    let sesstionQueue = DispatchQueue(label: "sesstion Queue")
    let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInTrueDepthCamera, .builtInTrueDepthCamera], mediaType: .video, position: .unspecified)
    
    private let previewView = PreviewView()
    private let captureButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewView.session = captureSettion
        sesstionQueue.async {
            self.setupSession()
            self.startSession()
        }
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndItems(imageName: "common_dismiss", action: #selector(dismissCameraViewController), isLeft: true)
        
        captureButton.layer.cornerRadius = 30
        captureButton.backgroundColor = .color2EBD3D
        captureButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(previewView)
        view.addSubview(captureButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        previewView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(captureButton.snp.top).offset(-18)
        }
        
        captureButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.height.equalTo(60)
        }
    }
    
    @objc func dismissCameraViewController() {
        dismiss(animated: true)
    }
    
    @objc func capturePhoto() {
        let videoPreviewLayerOrientaion = self.previewView.videoPreviewLayer.connection?.videoOrientation
        sesstionQueue.async {
            let connection = self.photoOutput.connection(with: .video)
            connection?.videoOrientation = videoPreviewLayerOrientaion!
            let setting = AVCapturePhotoSettings()
            self.photoOutput.capturePhoto(with: setting, delegate: self)
        }
    }
    
    private func presentCaptureImageViewController(_ image: UIImage) {
        let captureImageViewController = CaptureImageViewController()
        captureImageViewController.configure(image)
        navigationController?.pushViewController(captureImageViewController, animated: false)
    }
}

extension CameraViewController {
    func setupSession() {
        captureSettion.sessionPreset = .photo
        captureSettion.beginConfiguration()
    
        guard let camera = videoDeviceDiscoverySession.devices.first else {
            captureSettion.commitConfiguration()
            return
        }
        do {
            let videoDeviceInput = try AVCaptureDeviceInput(device: camera)
            
            if captureSettion.canAddInput(videoDeviceInput) {
                captureSettion.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
            } else {
                captureSettion.commitConfiguration()
                return
            }
        } catch _ {
            captureSettion.commitConfiguration()
            return
        }
        
        photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        if captureSettion.canAddOutput(photoOutput) {
            captureSettion.addOutput(photoOutput)
        } else {
            captureSettion.commitConfiguration()
            return
        }
        captureSettion.commitConfiguration()
    }
    
    func startSession() {
        sesstionQueue.async {
            if !self.captureSettion.isRunning {
                self.captureSettion.startRunning()
            }
        }
    }
    
    func stopSession() {
        sesstionQueue.async {
            if self.captureSettion.isRunning {
                self.captureSettion.stopRunning()
            }
        }
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else { return }
        guard let imageData = photo.fileDataRepresentation() else { return }
        guard let image = UIImage(data: imageData) else { return }
        DispatchQueue.main.async {
            self.presentCaptureImageViewController(image)
        }
    }
}
