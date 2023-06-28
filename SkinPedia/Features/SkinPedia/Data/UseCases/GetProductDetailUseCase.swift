//
//  GetProductDetailUseCase.swift
//  SkinPedia
//
//  Created by Rainer Regan on 28/06/23.
//

import Foundation

struct GetProductDetailUseCase {
    let skinpediaRepository = SkinPediaRepository()
    
    func call(query : ProductDetailRequest) async -> Result<ProductDetailResult, ProductDetailAPIError> {
        return await skinpediaRepository.getProductDetail(query: query)
    }
}


