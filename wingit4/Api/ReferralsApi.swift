//
//  ReferralsApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/1/21.
//


import Foundation
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

class ReferralsApi {
    
    func sendReferral(askId: String, receiverId: String, senderId: String?) {
        guard let id = senderId else { return }
        let referral = Referral(id: nil, createdTime: nil, lastUpdatedTime: nil, askId: askId, children: nil, closedTime: nil, mediaUrl: "", receiverId: receiverId, parentId: nil, senderId: id, status: .pending, text: nil)
        do {
            let _ = try Ref.FS_COLLECTION_REFERRALS.addDocument(from: referral)
        } catch {
            print(error)
        }
    }
    
    func statusToBumped(askId: String, receiverId: String){

        Ref.FS_COLLECTION_REFERRALS_FOR_ASK(askId: askId)?.whereField("receiverId", isEqualTo: receiverId).getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
            } else if let doc = snapshot?.documents {
               
                if let data = doc.first, data.exists {
                    data.reference.updateData(["status": "bumped"])
                }
            }
        }
    }
    
    func acceptReferral(askId: String, receiverId: String) {
        
        Ref.FS_COLLECTION_REFERRALS_FOR_ASK(askId: askId)?.whereField("receiverId", isEqualTo: receiverId).getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
            } else if let doc = snapshot?.documents {
               
                if let data = doc.first, data.exists {
                    data.reference.updateData(["status": "accepted"])
                }
            }
        }
    }
    
    func ignoreReferral(askId: String, receiverId: String) {
        
        Ref.FS_COLLECTION_REFERRALS_FOR_ASK(askId: askId)?.whereField("receiverId", isEqualTo: receiverId).getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
            } else if let doc = snapshot?.documents {
               
                if let data = doc.first, data.exists {
                    data.reference.updateData(["status": "closed"])
                }
            }
        }
    }
    
    
    /*
     1. If referral status is opened show on the current user's referral notification.
     2. So the function has to be get referrals in which the status is not closed.
     */
    
//    func getOpenReferrals(askId: String, receiverId: String, onSuccess: @escaping(_ referrals: [Referral]) -> Void) {
//
//        Ref.FS_COLLECTION_OPEN_REFERRALS_FOR_USER(userId: receiverId)?.whereField("askId", isEqualTo: askId).getDocuments { (snapshot, error) in
//            guard let snap = snapshot else {
//                return
//            }
//            var referrals = [Referral]()
//            for referral in snap.documents {
//                let dict = referral.data()
//                guard let decodedReferral = try? Referral.init(fromDictionary: dict) else {return}
//                referrals.append(decodedReferral)
//            }
//            onSuccess(referrals)
//        }
//    }
    
    func getOpenReferralForAsk(askId: String, receiverId: String, onSuccess: @escaping(_ referrals: [Referral]) -> Void) {

        Ref.FS_COLLECTION_OPEN_REFERRALS_FOR_USER(userId: receiverId)?.whereField("askId", isEqualTo: askId).getDocuments { (snapshot, error) in
            if let error = error {
              print(error)
            } else if let snapshot = snapshot {
              let referrals: [Referral] = snapshot.documents.compactMap {
                return try? $0.data(as: Referral.self)
              }
                onSuccess(referrals)
            }
        }
    }

    func getReferralsByAskId(askId: String, onSuccess: @escaping(_ recipientIds: [String]) -> Void) {
        Ref.FS_COLLECTION_REFERRALS.whereField("askId", isEqualTo: askId)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print(error)
                } else if let snapshot = snapshot {
                    let referrals = snapshot.documents.compactMap { (document) -> Referral? in
                        return try? document.data(as: Referral.self)
                    }
                    
                    var recipientIds: [String] = []

                    for referral in referrals {
                        recipientIds.append(referral.receiverId)
                    }
                    
                    onSuccess(recipientIds)
                }
            }
    }
  
  
    func getReferralsByUserId(
      userId: String,
      onSuccess: @escaping(_ referrals: [Referral]) -> Void
    ) {
      Ref.FS_COLLECTION_REFERRALS.whereField("receiverId", isEqualTo: userId)
        .getDocuments { (snapshot, error) in
          guard let snap = snapshot else { return }
          if let error = error { return print(error) }
          
          var referrals = [Referral]()
          for doc in snap.documents {
            if let referral = try? doc.data(as: Referral.self) {
              referrals.append(referral)
            }
          }

          onSuccess(referrals)
        }
    }
    
    func getPostFromReferralAskId(
      askIds: [String],
      onSuccess: @escaping(_ posts: [Post]) -> Void
    ) {
      
      
      let dispatchGroup = DispatchGroup();
      var posts: [Post] = []
      
      for askId in askIds {
        dispatchGroup.enter()
        
        Ref.FS_DOC_ASKS_FOR_ASKID(askId: askId)?.getDocument { (document, error) -> Void in
          if let error = error {return print(error) }
                  
            if let decodedPost = try? document?.data(as: Post.self) {
              posts.append(decodedPost)
            }
          
          dispatchGroup.leave()
        }
      }
      
      dispatchGroup.notify(queue: .main) {
        // code executes when all posts are fetched
          onSuccess(posts)
      }
      
      
    }
  
    func getReferralsWithJoins(onSuccess: @escaping(_ referrals: [NSMutableDictionary]) -> Void) {
      
      Api.Connections.getConnections(userId: Auth.auth().currentUser!.uid ) { (users) in
        // get connections and make a dictionary
        let allConnections = users.reduce([String: User]()) { (dict, user) -> [String: User] in
          var dict = dict
          dict[user.id!] = user
          return dict
        }
      
      
      Ref.FS_COLLECTION_REFERRALS.whereField("receiverId", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
        // catch errors
        guard let snap = snapshot else { return }
        if let error = error { return print(error) }
        
        var referralDicts: [NSMutableDictionary] = []
        var askIds: [String] = []
        
        for document in snap.documents {
          let referralDict = document.data()
          askIds.append(referralDict["askId"] as! String)
          referralDicts.append((referralDict as? NSDictionary)!.mutableCopy() as! NSMutableDictionary)
        }
        
        self.getPostFromReferralAskId(askIds: askIds) { (posts) in
            // get posts and create accessable dictionary
            let allReferralPosts = posts.reduce([String: Post]()) { (dict, post) -> [String: Post] in
              var dict = dict
              dict[post.postId] = post
              return dict
            }
          

          var results: [NSMutableDictionary] = []

          for referralDict in referralDicts {
            // create new referral dict with user and post joins
            let postId = referralDict["askId"]
            let senderId = referralDict["senderId"]
            // add User & Post to Referral
            referralDict["ask"] = allReferralPosts[postId as! String]
            referralDict["sender"] = allConnections[senderId as! String]
            results.append(referralDict)

          }
          // returns referral with joins
          onSuccess(results)
        }
      }
  }


  //struct Referral: Codable, Identifiable {
  //    @DocumentID var id: String?
  //    @ServerTimestamp var createdTime: Timestamp?
  //    @ServerTimestamp var firstInteractionTime: Timestamp? // first interaction with the referral
  //    @ServerTimestamp var closedTime: Timestamp? // when the receiver is officially done helping and has moved it into a closed state
  //    var askId: String /// postId
  //    var children: [String]? // referral can be bumped and create more referrals
  //    var mediaUrl: String /// avatar pic? okie
  //    var receiverId: String
  //    var parentId: String? // referral that led to this referral
  //    var senderId: String ///Auth.auth().currentUser?.id
  //    var status: ReferralStatus
  //    var text: String
  //}
  //
  //enum ReferralStatus: String, Codable {
  //    case accepted
  //    case bumped
  //    case closed
  //    case pending
  //}
    }

}
