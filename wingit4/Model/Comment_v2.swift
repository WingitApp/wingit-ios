//
//  Comment.swift
//  wingit4
//
//  Created by Daniel Yee on 8/31/21.
//

//import FirebaseFirestore
//import FirebaseFirestoreSwift
//import Foundation
//
//struct Comment_v2: Codable, Identifiable {
//    @DocumentID var id: String? // = askId or recId
//    @ServerTimestamp var createdAt: Timestamp?
//    var askId: String?
//    var children: [String]? // commentIds
//    var createdByUser: User?
//    var createdBy: String?
//    var likeCount: Int?
//    var likedBy: [String: Bool]?
//    var mediaUrls: [String]?
//    var parentId: String?
//    var recId: String?
//    var referralId: String?
//    var text: String?
//    var type: CommentType?
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case createdAt
//        case askId
//        case createdBy
//        case likeCount
//        case likedBy
//        case mediaUrls
//        case parentId
//        case recId
//        case text
//        case type
//    }
//}
