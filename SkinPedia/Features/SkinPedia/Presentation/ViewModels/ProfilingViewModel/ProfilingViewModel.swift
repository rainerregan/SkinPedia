//
//  ProfilingViewModel.swift
//  SkinPedia
//
//  Created by Rainer Regan on 28/06/23.
//

import Foundation

class ProfilingViewModel : ObservableObject {
    @Published var textFieldString: String = ""
    @Published var productDetailsResult: ProductDetailResult = []
    @Published var searchQuerryIsShown : Bool = false
    
    // MARK: - Private
    private func getProductDetails() async {
        let productDetailsResult = await GetProductDetailUseCase().call(query: ProductDetailRequest(query: textFieldString))
        
        switch productDetailsResult {
        case .success(let result):
            await MainActor.run {
                self.productDetailsResult = result
            }
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    private func request() async {
        await getProductDetails()
    }
}

extension ProfilingViewModel {
    func getProductDetails() {
        Task {
            await request()
        }
    }
}
