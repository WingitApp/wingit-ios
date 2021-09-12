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
    
    func sendReferral(askId: String, receiverId: String?, senderId: String?) {
        guard let id = senderId, let receiverId = receiverId else { return }
        let referral = Referral(id: nil, createdAt: nil, askId: askId, children: nil, closedAt: nil, receiverId: receiverId, parentId: nil, senderId: id, status: .pending, text: nil)
        do {
            let _ = try Ref.FS_COLLECTION_REFERRALS.addDocument(from: referral)
        } catch {
            print(error)
        }
    }
    
    func rewingReferral(askId: String, receiverId: String?, parentId: String, senderId: String?) {
        guard let id = senderId, let receiverId = receiverId else { return }
        let referral = Referral(id: nil, createdAt: nil, askId: askId, children: nil, closedAt: nil, receiverId: receiverId, parentId: parentId, senderId: id, status: .pending, text: nil)
        do {
            let _ = try Ref.FS_COLLECTION_REFERRALS.addDocument(from: referral)
        } catch {
            print(error)
        }
    }
    
    func updateStatus(referralId: String, newStatus: ReferralStatus) {
        Ref.FS_COLLECTION_REFERRALS.document(referralId).updateData(["status": newStatus.rawValue])
    }
    
    func addChildrenId(referralId: String, childrenId: String){
        Ref.FS_COLLECTION_REFERRALS.document(referralId).updateData(["children": childrenId])
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

    func getReferrals(status: ReferralStatus, onSuccess: @escaping(_ referrals: [Referral]) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        Ref.FS_COLLECTION_REFERRALS
          .whereField("receiverId", isEqualTo: userId)
          .whereField("status", isEqualTo: status.rawValue)
          .order(by: "createdAt", descending: true)
          .addSnapshotListener { (snapshot, error) in
            // catch errors
            guard let snap = snapshot else { return }
            if let error = error { return print(error) }
            
            snap.documentChanges.forEach { (documentChange) in
                switch documentChange.type {
                case .added:
                  
                  let dispatchGroup = DispatchGroup()
                  
                  let referrals: [Referral] = snap.documents.compactMap {
                      return try? $0.data(as: Referral.self)
                  }
                  
                  var result = [Referral]()
                  for var referral in referrals {
                      dispatchGroup.enter()
                      Api.Post.loadPost(postId: referral.askId) { (post) in
                          referral.ask = post
                          
                          Api.User.loadUser(userId: referral.senderId) { (user) in
                              referral.sender = user
                              result.append(referral)
                              dispatchGroup.leave()
                          } onError: {
                            print("load user error")
                          }
                      }
                      
                      dispatchGroup.notify(queue: .main) {
                          onSuccess(result)
                      }
                }
                case .modified:
                    print("type: modified")
                case .removed:
                    print("type: removed")
                }
            }

        }
    }
}

