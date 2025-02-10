//
//  FlickrSearchView.swift
//  FlickrSearch
//
//  Created by Sha'Marcus Walker on 2/10/25.
//

import SwiftUI

struct FlickrSearchView: View {
    
    @State private var searchText: String = ""
    @StateObject private var viewModel = FlickrViewModel(service: FlickrService())
    
    var body: some View {
        NavigationStack {
            VStack{
                GeometryReader { flickrGeometry in
                    VStack {
                        SearchBar(text: $searchText, viewModel: viewModel) { newValue in
                            viewModel.searchTextPublisher.send(newValue)
                        }
                        
                        switch viewModel.flickrState {
                            
                        case .idle:
                            EmptyView()
                        case .loading:
                            ProgressView()
                                .frame(width: flickrGeometry.size.width, height: flickrGeometry.size.height)
                                .accessibilityLabel("Loading View")

                        case .success:
                            VStack {
                                
                                if !searchText.isEmpty {
                                    Text(Constants.selectImage)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .accessibilityLabel(Constants.selectImage)
                                }
                                
                                ScrollView {
                                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                                        ForEach(viewModel.images) { image in
                                            NavigationLink(destination: FlickrImageDetailView(flickrImage: image)) {
                                                AsyncImage(url: image.thumbnailURL) { image in
                                                    image.resizable().scaledToFill()
                                                    
                                                } placeholder: {
                                                    Color.gray
                                                }
                                                .frame(width: 150, height: 150)
                                                .clipped()
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        case .error:
                            VStack {
                                Text(Constants.errorMessage)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .font(.system(size: 28))
                                    .accessibilityLabel(Constants.errorMessage)
                                
                                Text(viewModel.error?.localizedDescription ?? "")
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .font(.system(size: 28))
                                    .accessibilityLabel(viewModel.error?.localizedDescription ?? "")

                            }
                            .frame(width: flickrGeometry.size.width, height: flickrGeometry.size.height)
                        }
                    }
                }
            }
            .navigationTitle(Constants.AppTitle)
        }
    }
}

struct FlickrSearchView_Previews: PreviewProvider {
    static var previews: some View {
        FlickrSearchView()
    }
}
