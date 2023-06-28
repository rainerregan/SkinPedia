//
//  APICosmilyDataSourceProtocol.swift
//  SkinPedia
//
//  Created by Elvin Sestomi on 19/06/23.
//

import Foundation

enum RainersAPIError : Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

protocol RainersAPIDataSourceProtocol {
    func getQuerryData(querryRequest : RainerApiRequest) async -> Result<RainersAPIResult, RainersAPIError>
}
