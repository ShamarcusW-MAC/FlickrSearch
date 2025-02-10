//
//  FlickrViewModel.swift
//  FlickrSearch
//
//  Created by Sha'Marcus Walker on 2/10/25.
//

import Foundation
import Combine

enum FlickrState {
    case idle
    case loading
    case success
    case error
}
class FlickrViewModel: ObservableObject {
    @Published var images: [FlickrImage] = []
    @Published var isLoading: Bool = false
    @Published var flickrState: FlickrState = .idle
    @Published var error:NetworkServiceError?
    
    let service: NetworkServices
    let searchTextPublisher = PassthroughSubject<String, Never>()
    private var anyCancellable: AnyCancellable?
    
    init(service: NetworkServices) {
        self.service = service
        bindingSearch()
    }
    
    func bindingSearch() {
        anyCancellable = searchTextPublisher
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { value in
                Task{ [weak self] in
                    await  self?.searchImages(for: value)
                }
            }
    }
    
    @MainActor
    func searchImages(for searchTerm: String) async {
        guard !searchTerm.isEmpty else {
            images = []
            error = .invalidURL
            return
        }
        
        self.isLoading = true
        self.flickrState = .loading
        
        do {
            let fetchedImages = try await service.fetchApiData(searchTerm: searchTerm, modelType: FlickrResponse.self)
            
            self.images = fetchedImages.items
            print("Images: \(fetchedImages.items)")
            self.isLoading = false
            self.flickrState = .success
            
        } catch {
            switch error{
            case is URLError:
                self.error = NetworkServiceError.invalidURL
            case is DecodingError:
                self.error = NetworkServiceError.decodingFailed
            case NetworkServiceError.decodingFailed:
                self.error = NetworkServiceError.decodingFailed
            case NetworkServiceError.invalidURL:
                self.error = NetworkServiceError.invalidURL
            case NetworkServiceError.urlSessionFailed:
                self.error = NetworkServiceError.urlSessionFailed
            default:
                self.error = NetworkServiceError.noData
            }
            print("Error fetching images: \(error.localizedDescription)")
            self.images = []
            self.isLoading = false
            self.flickrState = .error
            
        }
    }
}
