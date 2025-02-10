//
//  FlickrService.swift
//  FlickrSearch
//
//  Created by Sha'Marcus Walker on 2/10/25.
//

import Foundation

protocol NetworkServices {
    func fetchApiData<T: Decodable>(searchTerm: String, modelType: T.Type) async throws -> T
}

class FlickrService {
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension FlickrService: NetworkServices {
    func fetchApiData<T>(searchTerm: String, modelType: T.Type) async throws -> T where T : Decodable {
        guard let term = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: ApiEndpoints.flickrEndpoint + term) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await urlSession.data(from: url)
        guard let httpResponse = (response as? HTTPURLResponse)else{
            throw NetworkServiceError.noData
        }
        guard (200...299).contains(httpResponse.statusCode) else{
            throw NetworkServiceError.urlSessionFailed
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode(modelType.self, from: data)
        return result
    }
}
