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
        NavigationView{
            VStack {
                // Camera preview
                CameraPreviewView(session: cameraViewModel.session, roi: ocrViewModel.roi)
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .ignoresSafeArea()
                // Capture button
                Button(action: {
                    cameraViewModel.capturePhoto()
                    
                    
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
}

struct CameraPreviewView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    let session: AVCaptureSession
    let roi : CGRect
    
    func makeUIView(context: Context) -> UIView {

        
        let cameraView = UIView(frame: CGRect(origin: .zero, size: UIScreen.main.bounds.size))
                
        // Create AVCaptureVideoPreviewLayer
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        
        

        var roiRect : CGRect = CGRect(x: roi.origin.y * cameraView.bounds.width,
                                      y: roi.origin.x * cameraView.bounds.height,
                                      width: roi.size.width * cameraView.bounds.width,
                                      height: roi.size.height * cameraView.bounds.height)
        
        
        let annotationView = UIView(frame: roiRect)
            annotationView.backgroundColor = .clear
//            annotationView.layer.borderColor = UIColor.black.cgColor
//            annotationView.layer.borderWidth = 2.0
//            annotationView.layer.cornerRadius = 5.0
            
            let dashPattern: [NSNumber] = [4, 4]
            let borderLayer = CAShapeLayer()
            borderLayer.strokeColor = UIColor.black.cgColor
            borderLayer.lineDashPattern = dashPattern
            borderLayer.fillColor = nil
            borderLayer.path = UIBezierPath(rect: annotationView.bounds).cgPath
        
//        let annotationView = UIView(frame: cameraViewRoi)
//        annotationView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Customize the annotation appearance as needed
        
        annotationView.layer.addSublayer(borderLayer)
        
        DispatchQueue.main.async {
            
            previewLayer.frame = cameraView.bounds
            annotationView.frame = roiRect
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
        annotationView.frame = CGRect(x: roi.origin.y * uiView.bounds.width,
                                         y: roi.origin.x * uiView.bounds.height,
                                         width: roi.size.width * uiView.bounds.width,
                                         height: roi.size.height * uiView.bounds.height)
    }
        
    
    // masih butuh perbaiki roinya tidak sama gede dan penempatannya tidak jelas.
//    private func updateAnnotationViewFrame(cameraView: UIView, annotationView: UIView) {
//        let previewLayerSize = cameraView.bounds
//
////
////        var rectOrigin = CGPoint(x: (previewLayerSize.width - roi.width) / 2 ,
////                                 y: (previewLayerSize.height - roi.height) / 2)
////
////        var roiRect : CGRect = CGRect(origin: rectOrigin, size: roi)
//
//
//        annotationView.frame = roi
////        annotationView.frame = roiRect
//    }
}



