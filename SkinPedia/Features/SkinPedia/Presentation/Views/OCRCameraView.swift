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
    var body: some View {
        NavigationView{
            VStack {
                // Camera preview
                CameraPreviewView(session: cameraViewModel.session, roi: ocrViewModel.roi)
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
                
            }.onChange(of: ocrViewModel.ingredients) {
                newIngred in
                print("Ingredients : \(newIngred)")
            }
            
            
        }
    }
}

struct CameraPreviewView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    let session: AVCaptureSession
    let roi : CGRect
    
    func makeUIView(context: Context) -> UIView {
//        let view = UIView(frame: .zero)
//        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
//
//        previewLayer.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(previewLayer)
//
//        DispatchQueue.main.async {
//            previewLayer.frame = view.bounds
//        }
//        return view
        
        let cameraView = UIView(frame: .zero)
                
        // Create AVCaptureVideoPreviewLayer
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        
        
        // Create the annotation view
        let annotationView = UIView(frame: roi)
        annotationView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Customize the annotation appearance as needed
        
        DispatchQueue.main.async {
            updateAnnotationViewFrame(cameraView: cameraView, annotationView: annotationView)
            previewLayer.frame = cameraView.bounds
        }
        
        cameraView.layer.addSublayer(previewLayer)
        cameraView.addSubview(annotationView)
        
        return cameraView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
            guard let previewLayer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer,
                  let annotationView = uiView.subviews.first else {
                return
            }
            
            previewLayer.frame = uiView.bounds
            updateAnnotationViewFrame(cameraView: uiView, annotationView: annotationView)
        }
        
    
    // masih butuh perbaiki roinya tidak sama gede dan penempatannya tidak jelas.
    private func updateAnnotationViewFrame(cameraView: UIView, annotationView: UIView) {
        let previewLayerSize = cameraView.bounds.size
        let roiSize = roi.size
        
        let widthRatio = previewLayerSize.width / roiSize.width
        let heightRatio = previewLayerSize.height / roiSize.height
        let scale = min(widthRatio, heightRatio)
        
        let scaledWidth = roiSize.width * scale
        let scaledHeight = roiSize.height * scale
        let x = (previewLayerSize.width - scaledWidth) / 2
        let y = (previewLayerSize.height - scaledHeight) / 2
        
        annotationView.frame = CGRect(x: x, y: y, width: scaledWidth, height: scaledHeight)
    }
}



