//
//  ScanViewModel.swift
//  SkinPedia
//
//  Created by Rainer Regan on 20/06/23.
//

import Foundation
import Combine

protocol ScanViewModelProtocol : ScanViewModelInput, ScanViewModelOutput {}

class ScanViewModel: ObservableObject, ScanViewModelProtocol {
    // MARK: - Output
    @Published var analyzedProductResult: ProductAnalysisResult = ProductAnalysisResult(resultString: "")
    
    // MARK: - Private
    private func getProductAnalysis() async {
        let productAnalysisResult = await GetProductAnalysisUseCase().call(productAnalysisRequest: ProductAnalysisRequest(ingredients: "water"))
        switch productAnalysisResult {
        case .success(let result):
            await MainActor.run {
                self.analyzedProductResult = result
            }
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    private func onLoad() async {
        await getProductAnalysis()
        print("OKSOKSOS")
    }
}

extension ScanViewModel {
    func didAppear() {
        Task {
            await onLoad()
        }
    }
}
