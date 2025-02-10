//
//  FlickrImageDetailView.swift
//  FlickrSearch
//
//  Created by Sha'Marcus Walker on 2/10/25.
//

import SwiftUI

struct FlickrImageDetailView: View {
    let flickrImage: FlickrImage
    
    var body: some View {
        
        GeometryReader { detailGeometry in
            ScrollView {
                VStack(alignment: .leading) {
                    
                    AsyncImage(url: flickrImage.thumbnailURL) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .accessibilityLabel("Image of \(flickrImage.title)")
                    } placeholder: {
                        ProgressView()
                    }
                    
                    ShareLink(item: flickrImage.thumbnailURL!) {
                        Label("Share Image", systemImage: "square.and.arrow.up")
                            .accessibilityLabel("Share Image Link")
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    HStack {
                        Text(Constants.titleHeader)
                            .multilineTextAlignment(.center)
                            .font(.headline)
                            .padding(.vertical, 4)
                            .accessibilityLabel("\(Constants.titleHeader) header")
                        
                        Text(flickrImage.title)
                            .multilineTextAlignment(.center)
                            .font(.body)
                            .padding(.vertical, 4)
                            .accessibilityLabel(flickrImage.title)
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    HStack {
                        Text(Constants.descriptionHeader)
                            .multilineTextAlignment(.center)
                            .font(.headline)
                            .padding(.vertical, 4)
                            .accessibilityLabel("\(Constants.descriptionHeader) header")
                        
                        Text(flickrImage.description)
                            .multilineTextAlignment(.center)
                            .font(.body)
                            .padding(.vertical, 4)

                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    HStack {
                        
                        Text(Constants.authorHeader)
                            .multilineTextAlignment(.center)
                            .font(.headline)
                            .padding(.vertical, 4)
                            .accessibilityLabel("\(Constants.authorHeader) header")
                        
                        Text(flickrImage.author)
                            .multilineTextAlignment(.center)
                            .font(.body)
                            .padding(.vertical, 4)
                            .accessibilityLabel(flickrImage.author)
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                                        
                    if let publishedDate = Conversions.formattedDate(from: flickrImage.published) {
                        Text("Published on \(publishedDate)")
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 4)
                            .accessibilityLabel("Published on \(publishedDate)")

                        
                        Divider()
                    }
                }
                .padding()
            }
            .navigationTitle(Constants.detailViewTitle)
        }
    }
}



struct FlickrImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FlickrImageDetailView(flickrImage: FlickrImage(title: "Title", media: FlickrImage.Media(m: "https://www.google.com/imgres?q=dog%20picture&imgurl=https%3A%2F%2Fhips.hearstapps.com%2Fhmg-prod%2Fimages%2Fdog-puppy-on-garden-royalty-free-image-1586966191.jpg%3Fcrop%3D0.752xw%3A1.00xh%3B0.175xw%2C0%26resize%3D1200%3A*&imgrefurl=https%3A%2F%2Fwww.goodhousekeeping.com%2Flife%2Fpets%2Fg4531%2Fcutest-dog-breeds%2F&docid=2r6Arj4-hBjhNM&tbnid=Zcg-2Pqp8jFSiM&vet=12ahUKEwjF2pjJg7mLAxUq5skDHQ6bPGgQM3oECBYQAA..i&w=1200&h=1197&hcb=2&itg=1&ved=2ahUKEwjF2pjJg7mLAxUq5skDHQ6bPGgQM3oECBYQAA"), description: "Description", author: "Author", published: "2025-02-09T22:22:39Z"))
    }
}
