//
//  ConnectionsApi.swift
//  wingit4
//
//  Created by Daniel Yee on 8/10/21.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase


class ConnectionsApi {
    func getConnections(userId: String, onSuccess: @escaping(_ users: [User]) -> Void, onEmpty: @escaping() -> Void) {
      Ref.FS_COLLECTION_CONNECTIONS_FOR_USER(userId: userId).getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
                return
            }
            var users = [User]()
        
            if snap.documents.isEmpty {
                return onEmpty()
            }
        
            for connection in snap.documents {
                let connectionId = connection.documentID
                Ref.FS_DOC_USERID(userId: connectionId).getDocument{ (document, error) in
                    if let decodedUser = try? document?.data(as: User.self) {
                        users.append(decodedUser)
                    }
                    onSuccess(users)
                }
            }
        }
    }
    
    func getConnections(userId: String, onSuccess: @escaping(_ users: [User]) -> Void) {
      Ref.FS_COLLECTION_CONNECTIONS_FOR_USER(userId: userId).getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
                return
            }
            var users = [User]()

            for connection in snap.documents {
                let connectionId = connection.documentID
                Ref.FS_DOC_USERID(userId: connectionId).getDocument{ (document, error) in
                    if let decodedUser = try? document?.data(as: User.self) {
                        users.append(decodedUser)
                    }
                    onSuccess(users)
                }
            }
        }
    }
  
  func addConnection(user1Id: String?, user2Id: String?) {
    guard let user1Id = user1Id, let user2Id = user2Id else { return }
    Ref.FS_DOC_CONNECTION_BETWEEN_USERS(user1Id: user1Id, user2Id: user2Id).setData([:])
  }
}
