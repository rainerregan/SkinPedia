//
//  OCRViewModel.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 20/06/23.
//

import Foundation
import SwiftUI
import Vision

class OCRViewModel : ObservableObject, OCRViewModelProtocol {
    
    
    @Published var ingredients: String = ""

    func performTextRecog(capturedImage : UIImage) {
        let req = VNRecognizeTextRequest { [self] request, err  in
            guard let detectedResult = request.results as? [VNRecognizedTextObservation] else {
                fatalError("Detection Fail to detect Text")
            }
            self.ingredients = ""
            for result in detectedResult {
                guard let bestCandidate = result.topCandidates(1).first?.string else {
                    print("Error in getting best candidate")
                    return
                }
                DispatchQueue.main.async {
                    print("String : \(bestCandidate)")
                    
                    self.ingredients = "\(self.ingredients)\(bestCandidate)"
                }
            }
        }
        
        guard let inputImage : CGImage =  capturedImage.cgImage else {
            fatalError("Image aren't available")
        }
        
        var imageHandler = VNImageRequestHandler(cgImage: inputImage)
        
        do {
            try imageHandler.perform([req])
        } catch let err {
            fatalError(err.localizedDescription)
        }
    }
}
