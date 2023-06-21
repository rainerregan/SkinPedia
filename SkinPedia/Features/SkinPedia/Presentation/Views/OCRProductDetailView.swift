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
                .navigationBarItems(trailing :
                    Button {
                        isShowCameraView = true
                    } label: {
                        Text("Retake")
                    }
            )
//                .sheet(isPresented: $sheetIsPresented) {
//                    VStack{
//
//                    }
//                    .presentationDetents([.height(100), .large])
//            }
            
        }
    }
}

struct OCRProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OCRProductDetailView()
    }
}
