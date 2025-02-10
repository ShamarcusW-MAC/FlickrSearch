//
//  NetworkServiceError.swift
//  FlickrSearch
//
//  Created by Sha'Marcus Walker on 2/10/25.
//

import Foundation
enum NetworkServiceError: Error {
    case invalidURL
    case decodingFailed
    case noData
    case urlSessionFailed
}
