//
//  CameraViewModel.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 20/06/23.
//

import AVFoundation
import SwiftUI

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate, CameraViewProtocol {
    let session = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    @Published var capturedImage : UIImage?
    
    override init() {
        super.init()
        setupCamera()
    }

    func checkCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                // Start the camera session
                self.session.startRunning()
            }
        }
    }

    func setupCamera() {
        session.beginConfiguration()

        guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return }

        if session.canAddInput(videoInput) {
            session.addInput(videoInput)
        }

        if session.canAddOutput(photoOutput) {
            session.sessionPreset = .photo
            session.addOutput(photoOutput)
        }

        session.commitConfiguration()
    }

    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(),
           let capturedImage = UIImage(data: imageData) {
            print("masuk")
            self.capturedImage = capturedImage;
        }
    }
}
