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
//    let roi = CGRect(x: 0.1, y: 0.1, width: 0.5, height: 0.5)
    
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
                    let finalBestCandidate = bestCandidate.processEachSkincareIngredient()
                    print("String : \(finalBestCandidate)")
                    
                    self.ingredients = "\(self.ingredients) \(finalBestCandidate.removeSpecialCharacters())"
                }
            }
        }
        
        guard let inputImage : CGImage =  capturedImage.cgImage else {
            fatalError("Image aren't available")
        }
        
        var imageHandler = VNImageRequestHandler(cgImage: inputImage)
//        req.regionOfInterest = roi;
//        
        do {
            try imageHandler.perform([req])
        } catch let err {
            fatalError(err.localizedDescription)
        }
    }
}
