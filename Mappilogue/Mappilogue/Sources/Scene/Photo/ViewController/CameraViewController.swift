//
//  CameraViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/12/05.
//

import UIKit
import AVFoundation
import MappilogueKit

class CameraViewController: CameraNavigationBarViewController {
    let captureSettion = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    let photoOutput = AVCapturePhotoOutput()
    var isBack: Bool = true
    
    let sesstionQueue = DispatchQueue(label: "sesstion Queue")
    let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInTrueDepthCamera, .builtInTrueDepthCamera], mediaType: .video, position: .unspecified)
    
    private let previewView = PreviewView()
    private let captureButton = UIButton()
    private let switchModeButton = UIButton()
    
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
        
        captureButton.setImage(Images.image(named: .buttonCameraCapture), for: .normal)
        captureButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        
        switchModeButton.setImage(Images.image(named: .buttonChangeCameraMode), for: .normal)
        switchModeButton.addTarget(self, action: #selector(switchMode), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(previewView)
        view.addSubview(captureButton)
        view.addSubview(switchModeButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        previewView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(135)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.width * (4 / 3))
        }
        
        captureButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-26)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(64)
        }
        
        switchModeButton.snp.makeConstraints {
            $0.centerY.equalTo(captureButton)
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.height.equalTo(48)
        }
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
    
    private func presentCapturePhotoViewController(_ photo: UIImage) {
        let viewController = CapturePhotoViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func switchMode() {
        guard videoDeviceDiscoverySession.devices.count > 1 else {
            return
        }
        
        sesstionQueue.async {
            let currentVideoDevice = self.videoDeviceInput.device
            let currentPosition = currentVideoDevice.position
            self.isBack = currentPosition == .front
            let preferredPosition: AVCaptureDevice.Position = self.isBack ? .back : .front
            let devices = self.videoDeviceDiscoverySession.devices
            var newVideoDevice: AVCaptureDevice?
            
            newVideoDevice = devices.first(where: { device in
                return preferredPosition == device.position
            })
            
            if let newDevice = newVideoDevice {
                do {
                    let videoDeviceInput = try AVCaptureDeviceInput(device: newDevice)
                    self.captureSettion.beginConfiguration()
                    self.captureSettion.removeInput(self.videoDeviceInput)
                    
                    if self.captureSettion.canAddInput(videoDeviceInput) {
                        self.captureSettion.addInput(videoDeviceInput)
                        self.videoDeviceInput = videoDeviceInput
                    } else {
                        self.captureSettion.addInput(self.videoDeviceInput)
                    }
                    self.captureSettion.commitConfiguration()
                    
                } catch let error {
                    print("error occured while creating device input : \(error.localizedDescription)")
                }
            }
            
        }
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
        guard let photoData = photo.fileDataRepresentation() else { return }
        guard let photo = UIImage(data: photoData) else { return }
        let flippedPhoto = UIImage(cgImage: photo.cgImage!, scale: photo.scale, orientation: .leftMirrored)
        
        DispatchQueue.main.async {
            self.presentCapturePhotoViewController(self.isBack ? photo : flippedPhoto)
        }
    }
}
