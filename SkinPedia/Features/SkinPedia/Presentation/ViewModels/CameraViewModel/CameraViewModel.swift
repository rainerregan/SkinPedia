//
//  CameraViewModel.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 20/06/23.
//

import AVFoundation
import SwiftUI

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate, CameraViewProtocol {
    
    
    let camWidth : CGFloat = 300.0
    let camHeight : CGFloat = 400.0
    let session = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    @Published var capturedImage : UIImage?
    var capturedDevice : AVCaptureDevice? = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    var roi : CGRect?
    
    
    override init() {
        super.init()
        setupCamera()
    }
    
    func saveToCoreData(name : String) async {
        await saveToCoreDataUseCase().skinPediaRepository.saveToCoreData(name: name);
    }
    
    func setROI(roi : CGRect) {
        self.roi = roi
    }

    func checkCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {å
                // Start the camera session
                self.session.startRunning()
            
            }
        }
    }
    
    

    func setupCamera() {
        
        session.beginConfiguration()

        guard let videoCaptureDevice = self.capturedDevice else { return }
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

//extension CameraViewModel {
//    func scaleImageToSize(image: UIImage, newSize: CGSize) {
//        print("Masuk ke scaling")
//        let imageSize = image.size
//
//        let cropOrigin = CGPoint(x: (imageSize.width - newSize.width) / 2,
//                                     y: (imageSize.height - newSize.height) / 2)
//
//            // Create the crop rectangle
//        let cropRect = CGRect(origin: cropOrigin, size: newSize)
//
//        if let cgImage = image.cgImage?.cropping(to: cropRect) {
//                return UIImage(cgImage: cgImage)
//            }
////        let renderer = UIGraphicsImageRenderer(size: newSize)
////        let scaledImage = renderer.image { context in
////            image.draw(in: CGRect(origin: .zero, size: newSize))
////        }
//
//        self.scaledImage = scaledImage
//    }
//}
