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
  
  func placeholderColor() -> UIColor{
    let randomInt = Int.random(in: 1..<6)
    
    switch(randomInt) {
//      
//      case 1:
//        return UIColor(Color.apricotWhite)
//      case 2:
//        return UIColor(Color.carnationRed)
//      case 3:
//        return UIColor(Color.yellow)
//      case 4:
//        return UIColor(Color.orange)
//      case 5:
//        return UIColor(Color.downeyGreen)
    default:
      return UIColor.systemGray6
    }

  }
  
  func defaultImage() -> UIImage {
    return placeholderColor().image(CGSize(width: 128, height: 128))
  }

  
  init(urlString: String?) {
    urlImageViewModel = URLImageViewModel(urlString: urlString)
  }
    
  var body: some View {
    Image(uiImage: urlImageViewModel.image ?? defaultImage())
      .resizable()
      .aspectRatio(contentMode: .fill)
      .background(Color.gray)
  }
  
}
