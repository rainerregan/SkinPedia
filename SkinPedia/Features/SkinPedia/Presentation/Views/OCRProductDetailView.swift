//
//  OCRProductDetailView.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 21/06/23.
//

import SwiftUI

struct OCRProductDetailView: View {
    
    @State var isShowCameraView = false
    @EnvironmentObject var cameraViewModel : CameraViewModel
    @StateObject var ocrViewModel : OCRViewModel = OCRViewModel();
    @State var sheetIsPresented = true;
    
    @EnvironmentObject var analysisResultViewModel : AnalysisResultViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: cameraViewModel.capturedImage!)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: UIScreen.main.bounds.width, maxWidth: .infinity, minHeight : .zero, maxHeight :700)
                Spacer()
                
                VStack{
                    Button{
                        ocrViewModel.performTextRecog(capturedImage: cameraViewModel.capturedImage!)
                    } label : {
                        Text("Run OCR diagnose")
                    }
                }
                
                
                NavigationLink("", destination: CameraView().navigationBarHidden(true), isActive: $isShowCameraView)
            }
            .onAppear{
                
                var img = cameraViewModel.capturedImage!
                
                var cgPoint = CGPoint(
                    x: (img.size.width - cameraViewModel.roi.width) / 2,
                    y: (img.size.height - cameraViewModel.roi.height) / 2)
                
                var cgRect = CGRect(origin: cgPoint, size: img.size)
                
                
                
                cameraViewModel.capturedImage = cameraViewModel.cropImage(image: img, cropRect: cgRect)
            }
            .navigationBarItems(leading :
                Button {
                    isShowCameraView = true
                } label: {
                    Text("Retake")
                }
            ).navigationBarItems(trailing:
                NavigationLink(destination: AnalysisResultView(analysisResultViewModel: analysisResultViewModel)){
                    Text("See Result")
                }
            )
//            .sheet(isPresented: $sheetIsPresented) {
//                VStack{
//                    Text("Testing 123")
//                }.background(.white)
//            }.presentationDetents([.fraction(0.45)])
        }
    }
}

struct OCRProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OCRProductDetailView()
    }
}
