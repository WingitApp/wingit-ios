//
//  FooterCellViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/10/21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

class FooterCellViewModel: ObservableObject {
    
    var post: Post!
    @Published var isLoading = false
    @Published var isLiked = false
    let uid = Auth.auth().currentUser!.uid
    
    func checkPostIsLiked() {
        isLiked = (post.likes["\(uid)"] == true) ? true : false
    }

    func like() {
        post.likeCount += 1
        isLiked = true
        
        Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: post.ownerId).collection("userPosts").document(post.postId).updateData(["likes.\(uid)" : true,
                                                                                                                               "likeCount":  post.likeCount])
        Ref.FIRESTORE_COLLECTION_ALL_ASKS.document(post.postId).updateData(["likes.\(uid)" : true,
                                                                             "likeCount":  post.likeCount])
        Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: post.ownerId).collection("timelinePosts").document(post.postId).updateData(["likes.\(uid)" : true,
                                                                                                                                   "likeCount":  post.likeCount])
        // find followers and update posts in their timeline using Cloud Function
        if Auth.auth().currentUser!.uid != post.ownerId {
            let activityId = Ref.FIRESTORE_COLLECTION_ACTIVITY.document(post.ownerId).collection("feedItems").document().documentID
            let activityObject = Activity(activityId: activityId, type: "like", username: Auth.auth().currentUser!.displayName!, userId: uid, userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, postId: post.postId, mediaUrl: post.mediaUrl, comment: "", gemComment: "", date: Date().timeIntervalSince1970)
            guard let activityDict = try? activityObject.toDictionary() else { return }

            Ref.FIRESTORE_COLLECTION_ACTIVITY.document(post.ownerId).collection("feedItems").document(activityId).setData(activityDict)
        }
    }
    
    func unlike() {
        post.likeCount -= 1
        isLiked = false
        
        Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: post.ownerId).collection("userPosts").document(post.postId).updateData(["likes.\(uid)" : false,
                                                                                                                                  "likeCount":  post.likeCount])
        Ref.FIRESTORE_COLLECTION_ALL_ASKS.document(post.postId).updateData(["likes.\(uid)" : false,
                                                                                "likeCount":  post.likeCount])
        Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: post.ownerId).collection("timelinePosts").document(post.postId).updateData(["likes.\(uid)" : false,
                                                                                                                                      "likeCount":  post.likeCount])
        if Auth.auth().currentUser!.uid != post.ownerId {
            Ref.FIRESTORE_COLLECTION_ACTIVITY.document(post.ownerId).collection("feedItems").whereField("type", isEqualTo: "like").whereField("userId", isEqualTo: uid).whereField("postId", isEqualTo:  post.postId).getDocuments { (snapshot, error) in
                if let doc = snapshot?.documents {
                    if let data = doc.first, data.exists {
                        data.reference.delete()
                    }
                }
            }
         }
    }
    
    func shareButtonTapped(onSuccess: @escaping(_ post: Post) -> Void){
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.wingit.co"
        components.path = "/terms-of-use"
        let itemIDQueryItem = URLQueryItem(name: "postId", value: post.postId)
        components.queryItems = [itemIDQueryItem]
        
        guard let linkParameter = components.url else { return }
        print("I am sharing \(linkParameter.absoluteString)")
        
        let domain = "https://www.wingit.co"
        guard let linkBuilder =
                DynamicLinkComponents.init(link: linkParameter, domainURIPrefix: domain) else {
            return
        }
        // 1
        if let myBundleId = Bundle.main.bundleIdentifier {
          linkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: myBundleId)
        }
        // 2
        linkBuilder.iOSParameters?.appStoreID = "1572569005"
        // 3
        linkBuilder.socialMetaTagParameters = DynamicLinkMetaTagParameters()
        linkBuilder.socialMetaTagParameters?.title = "From Wingit"
        linkBuilder.socialMetaTagParameters?.descriptionText = post.caption
        linkBuilder.socialMetaTagParameters?.imageURL = post.mediaUrl

        guard let longURL = linkBuilder.url else { return }
        print("The long dynamic link is \(longURL.absoluteString)")

    }

}

