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
  var url: URL
  
  
  init(urlString: String?) {
    url = URL(string: urlString ?? DEFAULT_PROFILE_AVATAR) ?? URL(string: DEFAULT_PROFILE_AVATAR)!
  }
  
  
    
  var body: some View {
  
    URLImage(url) {
      EmptyView()
    } inProgress: { progress in
        // Display progress
      HStack{}
        .background(Color.gray)
    } failure: { error, retry in
        // Display error and retry button
        VStack {
            Text(error.localizedDescription)
            Button("Retry", action: retry)
        }
    } content: { image in
        // Downloaded image
        image
        .resizable()
        .aspectRatio(contentMode: .fill)
        .background(Color.gray)
    }
  }
  
}
