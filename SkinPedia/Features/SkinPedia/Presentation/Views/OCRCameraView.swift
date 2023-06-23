//
//  OCRCameraView.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 20/06/23.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject private var cameraViewModel = CameraViewModel()
    @StateObject var ocrViewModel = OCRViewModel();
    @State var showDetailOCR : Bool = false;
    
    @StateObject var analysisResultViewModel = AnalysisResultViewModel()
    
    var body: some View {
        VStack {
            // Camera preview
            CameraPreviewView(session: cameraViewModel.session, roi: ocrViewModel.roi, capturedDevice: cameraViewModel.capturedDevice!)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .ignoresSafeArea()
            // Capture button
            Button(action: {
                cameraViewModel.capturePhoto()
//                    print(cameraViewModel.capturedImage == nil)
                
            }, label: {
                Image(systemName: "camera")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .clipShape(Circle())
            })
            .padding()
            
            NavigationLink("", destination: OCRProductDetailView()
                .environmentObject(cameraViewModel)
                .environmentObject(analysisResultViewModel)
                .navigationBarHidden(true), isActive: $showDetailOCR)
        }
        .onAppear {
            cameraViewModel.checkCameraPermission()
            cameraViewModel.setROI(roi: ocrViewModel.roi)
        }
        // Debugging the camera capture
        .onChange(of: cameraViewModel.capturedImage){
            newImage in
            showDetailOCR = true;
            ocrViewModel.performTextRecog(capturedImage: cameraViewModel.capturedImage!)
            
        }.onChange(of: ocrViewModel.ingredients) {
            newIngred in
            let processedIngredients = newIngred.processSkincareIngredients()
            print("Ingredients : \(processedIngredients)")
            analysisResultViewModel.toBeAnalyzedRequest = ProductAnalysisRequest(ingredients: processedIngredients)
        }
    }
}

struct CameraPreviewView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    let session: AVCaptureSession
    let roi : CGRect
    let capturedDevice : AVCaptureDevice
    
    
    func makeUIView(context: Context) -> UIView {
        let cameraView = UIView(frame: .zero)
                
        // Create AVCaptureVideoPreviewLayer
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        
        
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePinchGesture(_:)))
        cameraView.addGestureRecognizer(pinchGesture)
        
//        // Create the annotation view
//        let annotationView = UIView(frame: roi)
//        annotationView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Customize the annotation appearance as needed
        
        DispatchQueue.main.async {
//            updateAnnotationViewFrame(cameraView: cameraView, annotationView: annotationView)
            previewLayer.frame = cameraView.bounds
        }
        
        cameraView.layer.addSublayer(previewLayer)
//        cameraView.addSubview(annotationView)
        
        return cameraView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
            guard let previewLayer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer else {
                return
            }
            
            previewLayer.frame = uiView.bounds
//            updateAnnotationViewFrame(cameraView: uiView, annotationView: annotationView)
        }
        
    func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
    
//    // masih butuh perbaiki roinya tidak sama gede dan penempatannya tidak jelas.
//    private func updateAnnotationViewFrame(cameraView: UIView, annotationView: UIView) {
//        let previewLayerSize = cameraView.bounds.size
//        let roiSize = roi.size
//
//        let widthRatio = previewLayerSize.width / roiSize.width
//        let heightRatio = previewLayerSize.height / roiSize.height
//        let scale = min(widthRatio, heightRatio)
//
//        let scaledWidth = roiSize.width * scale
//        let scaledHeight = roiSize.height * scale
//        let x = (previewLayerSize.width - scaledWidth) / 2
//        let y = (previewLayerSize.height - scaledHeight) / 2
//
//        annotationView.frame = CGRect(x: x, y: y, width: scaledWidth, height: scaledHeight)
//    }
    
    class Coordinator : NSObject {
        var parent : CameraPreviewView
        
        init(_ parent : CameraPreviewView) {
            self.parent = parent
        }
        
        @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
            let captureDevice = parent.capturedDevice
            
            if gesture.state == .changed {
                let maxZoomFactor = captureDevice.activeFormat.videoMaxZoomFactor
                let pinchVelocityDividerFactor: CGFloat = 10.0
                
                // Calculate the desired zoom factor based on the gesture's scale
                var zoomFactor = captureDevice.videoZoomFactor + atan2(gesture.velocity, pinchVelocityDividerFactor)
                
                // Clamp the zoom factor to the valid range
                zoomFactor = max(1.0, min(zoomFactor, maxZoomFactor))
                
                do {
                    try captureDevice.lockForConfiguration()
                    
                    // Set the zoom factor on the capture device
                    captureDevice.videoZoomFactor = zoomFactor
                    
                    captureDevice.unlockForConfiguration()
                } catch {
                    print("Error adjusting zoom factor: \(error.localizedDescription)")
                }
            }
        }
    }
        
}



