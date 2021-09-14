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
  @ObservedObject var urlImageViewModel: URLImageViewModel
  
  static var defaultImage = UIColor.systemGray6.image(CGSize(width: 128, height: 128))

  
  init(urlString: String?) {
    urlImageViewModel = URLImageViewModel(urlString: urlString)
  }
    
  var body: some View {
    Image(uiImage: urlImageViewModel.image ?? URLImageView.defaultImage)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .background(Color.gray)
  }
  
}
