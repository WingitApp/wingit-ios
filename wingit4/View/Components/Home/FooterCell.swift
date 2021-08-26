//
//  FooterCell.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import SwiftUI
import URLImage
import Firebase

struct FooterCell: View {
    
    @ObservedObject var footerCellViewModel = FooterCellViewModel()
    @ObservedObject var commentViewModel = CommentViewModel()
    @State var showComments : Bool = false
    @State var activityIndicator = false
    @State private var isShareSheetShowing = false
    let screen = UIScreen.main.bounds
    
    init(post: Post) {
        self.footerCellViewModel.post = post
        self.footerCellViewModel.checkPostIsLiked()
    }
    
//    func sharePost(){
//        footerCellViewModel.shareButtonTapped { post in
//            self.footerCellViewModel.post = post
//        }
//    }
    
    var body: some View {
       
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Image(systemName: (self.footerCellViewModel.isLiked) ? "hand.raised.fill" : "hand.raised").onTapGesture {
                    if self.footerCellViewModel.isLiked {
                        self.footerCellViewModel.unlike()
                    } else {
                        logToAmplitude(event: .upvote)
                        self.footerCellViewModel.like()
                    }
                }
                if footerCellViewModel.post.likeCount > 0 {
                    Text("\(footerCellViewModel.post.likeCount)").font(.caption).foregroundColor(.gray)
                        //.padding(.leading, 15).padding(.top, 5)
                }
               
                HStack{
//                    NavigationLink(
//                        destination: CommentView(post: self.footerCellViewModel.post),
//                        label: {
//                            Image(systemName: "message").foregroundColor(.gray).padding(.leading, 15)
//                        })
                    Button(action: {
                            logToAmplitude(event: .viewComments)
                            showComments.toggle()
                    },
                           label: {
                            Image(systemName: "message").foregroundColor(.gray).padding(.leading, 15).accentColor(.red)
                    })
                if !commentViewModel.comments.isEmpty {
                    Text("\(commentViewModel.comments.count)").foregroundColor(.gray).font(.caption)
                }
                }
                Spacer()
                Button(action: {createDLink()},
                       label: {
                    Image(systemName: "arrowshape.turn.up.right")
                })
            }.padding(.trailing, 15).padding(.leading, 15)
            
          
        }.padding(.bottom, 10).padding(.top, 5)
        .sheet(isPresented: $showComments, content: {
            CommentView(post: self.footerCellViewModel.post)
        })
        .onAppear {
            self.commentViewModel.postId = self.footerCellViewModel.post == nil ? self.footerCellViewModel.post.postId : self.footerCellViewModel.post?.postId
            self.commentViewModel.loadComments()
        }
        .onDisappear {
            if self.commentViewModel.listener != nil {
                self.commentViewModel.listener.remove()
            }
        }
    
    }
    
    func createDLink(){
//
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.wingit.co"
        components.path = "/policy"

        let itemIDQueryItem = URLQueryItem(name: "postId", value: footerCellViewModel.post.postId)
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
        linkBuilder.socialMetaTagParameters?.title = "\(footerCellViewModel.post.username) requested on Wingit"
        linkBuilder.socialMetaTagParameters?.descriptionText = footerCellViewModel.post.caption
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

          shareItem(with: url)
        }
    }
//
    // Share dynamic link
    func shareItem(with url: URL) {
      activityIndicator = false
      isShareSheetShowing.toggle()
        let subjectLine = "\(footerCellViewModel.post.username) requested '\(footerCellViewModel.post.caption)'"
      let activityView = UIActivityViewController(activityItems: [subjectLine, url], applicationActivities: nil)
      UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
    
}


