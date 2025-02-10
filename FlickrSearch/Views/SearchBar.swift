//
//  SearchBar.swift
//  FlickrSearch
//
//  Created by Sha'Marcus Walker on 2/10/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let viewModel: FlickrViewModel
    var onSearch: (String) -> Void
    
    var body: some View {
        HStack {
            
            TextField(Constants.searchBarHint, text: $text)
                .padding(8)
                .background(Color.cyan)
                .cornerRadius(8)
                .onChange(of: text) { newValue in
                    onSearch(newValue)
                }
                .autocorrectionDisabled(true)
            
            if !text.isEmpty {
                Button {
                    viewModel.flickrState = .idle
                    text = ""
                    onSearch("")
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
