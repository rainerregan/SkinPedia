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
                CameraPreviewView(session: cameraViewModel.session)
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

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        DispatchQueue.main.async {
            previewLayer.frame = view.bounds
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let previewLayer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer else {
            return
        }
        previewLayer.frame = uiView.bounds
    }
}



