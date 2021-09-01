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
    func getConnections(userId: String, onSuccess: @escaping(_ users: [User]) -> Void) {
        Ref.FIRESTORE_COLLECTION_CONNECTIONS_FOR_USER(userId: userId).getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
                return
            }
            var users = [User]()
            for connection in snap.documents {
                let connectionId = connection.documentID
                Ref.FIRESTORE_DOCUMENT_USERID(userId: connectionId).getDocument{ (document, error) in
                    if let decodedUser = try? document?.data(as: User.self) {
                        users.append(decodedUser)
                    }
                    onSuccess(users)
                }
            }
        }
    }
}
