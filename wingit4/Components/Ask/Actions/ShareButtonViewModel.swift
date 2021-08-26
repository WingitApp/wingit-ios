//
//  ReferButtonViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 8/25/21.
//


import Foundation
import SwiftUI
import URLImage
import Firebase

class ShareButtonViewModel: ObservableObject{
  @State var activityIndicator = false
  @Published var isShareSheetShown = false
  
  func createDLink(post: Post){
      var components = URLComponents()
      components.scheme = "https"
      components.host = "www.wingit.co"
      components.path = "/policy"

      let itemIDQueryItem = URLQueryItem(
        name: "postId",
        value: post.postId
      )
      components.queryItems = [itemIDQueryItem]

      guard let linkParameter = components.url else { return }
      print("I am sharing \(linkParameter.absoluteString)")
//
      let domain = "https://ask.wingitapp.co"
      guard let linkBuilder =
              DynamicLinkComponents.init(link: linkParameter, domainURIPrefix: domain) else {
          return
      }
      // 1
      if let myBundleId = Bundle.main.bundleIdentifier {
        linkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: myBundleId)
      }
      // 2
      linkBuilder.iOSParameters?.appStoreID = APPSTOREID
      // 3
      linkBuilder.socialMetaTagParameters =  DynamicLinkSocialMetaTagParameters()
      linkBuilder.socialMetaTagParameters?.title = "\(post.username) requested on Wingit"
      linkBuilder.socialMetaTagParameters?.descriptionText = post.caption
     // image of profile pic? or post? (still thinking...)
              linkBuilder.socialMetaTagParameters?.imageURL = URL(string: LOGO_URL)!

//        // TODO 6
      guard let longURL = linkBuilder.url else { return }
      print("The long dynamic link is \(longURL.absoluteString)")
     // shareItem(with: longURL)
//
      // TODO 7
      linkBuilder.shorten { url, warnings, error in
        if let error = error {
          print("Oh no! Got an error! \(error)")
          return
        }
        if let warnings = warnings {
          for warning in warnings {
            print("FDL Warning: \(warning)")
          }
        }
        guard let url = url else { return }
        print("I have a short url to share! \(url.absoluteString)")

        self.shareItem(with: url, post: post)
      }
  }
//
  // Share dynamic link
  func shareItem(with url: URL, post: Post) {
    self.activityIndicator = false
    self.isShareSheetShown.toggle()
    
    let subjectLine = "\(post.username) requested '\(post.caption)'"
    let activityView = UIActivityViewController(activityItems: [subjectLine, url], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
  }
  
}

