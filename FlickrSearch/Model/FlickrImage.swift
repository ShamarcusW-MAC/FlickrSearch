//
//  FlickrImage.swift
//  FlickrSearch
//
//  Created by Sha'Marcus Walker on 2/10/25.
//

import Foundation

struct FlickrResponse: Codable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [FlickrImage]
}

struct FlickrImage:Identifiable, Codable {
    let id = UUID()
    let title: String
    let media: Media
    let description: String
    let author: String
    let published: String
     
    var thumbnailURL: URL? {
        URL(string: media.m)
    }
    
    struct Media: Codable {
        let m: String
    }
}

//extension FlickrImage: Identifiable {
//    var id: String {
//        return UUID().uuidString
//    }
//}
