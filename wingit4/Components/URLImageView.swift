//
//  URLImageView.swift
//  wingit4
//
//  Created by Daniel Yee on 9/7/21.
//

import Foundation
import URLImage
import SwiftUI

struct URLImageView: View {
    let inputURL: String?

    var validURL: Bool {
        if let safeURL = inputURL, !safeURL.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    @ViewBuilder
    var body: some View {
        if validURL {
            URLImage(URL(string: inputURL!)!) { proxy in
                proxy.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        } else {
            Image(IMAGE_USER_PLACEHOLDER)
            .resizable()
            .aspectRatio(contentMode: .fill)
        }
    }
}
