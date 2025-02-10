//
//  FakeFlickrService.swift
//  FlickrSearchTests
//
//  Created by Sha'Marcus Walker on 2/10/25.
//

import Foundation
@testable import FlickrSearch

class FakeFlickrService: NetworkServices {
    func fetchApiData<T>(searchTerm: String, modelType: T.Type) async throws -> T where T : Decodable {
        let bundle = Bundle(for: FakeFlickrService.self)
        guard let path = bundle.url(forResource: searchTerm, withExtension: "json") else {
            throw NetworkServiceError.invalidURL
        }
        do {
            let data = try Data(contentsOf: path)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let parsedData = try jsonDecoder.decode(modelType, from: data)
            return parsedData
        } catch {
            throw error
        }
    }
    
    
}
