//
//  Constants.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

let COLOR_LIGHT_GRAY = Color(red: 0, green: 0, blue: 0, opacity: 0.15)
let COLOR_WINGIT = Color(red: 93, green: 180, blue: 221, opacity: 0.15)
let DEFAULT_PROFILE_AVATAR = """
                  https://firebasestorage.googleapis.com/v0/b/wingitapp-1fe28.appspot.com/o/avatar%2Fdefault%2Fuser-placeholder-copy.jpg?alt=media&token=a8b07293-d9db-466c-97f6-8a5e6b42adb0
                  """
let CARD_CORNER_RADIUS = 8

// Sign in and Sign up pages
let TEXT_NEED_AN_ACCOUNT = "Don't have an account?"
let TEXT_SIGN_UP = "Sign up"
let TEXT_SIGN_IN = "Login"
let TEXT_EMAIL = "Email"
let TEXT_FIRST_NAME = "First Name"
let TEXT_LAST_NAME = "Last Name"
let TEXT_USERNAME = "Username"
let TEXT_BIO = "Bio"
let TEXT_PASSWORD = "Password"
let TEXT_SIGNIN_HEADLINE = "Wingit"
let TEXT_SIGNIN_SUBHEADLINE = "You never know until you ask."
let LINK_TERMS_OF_SERVICE = Link("Terms of Service", destination: URL(string: "https://www.wingitapp.co/terms-of-use")!)
let LINK_PRIVACY_POLICY = Link("Privacy Policy", destination: URL(string: "https://www.wingitapp.co/policy")!)
let TEXT_SIGNUP_PASSWORD_REQUIRED = "At least 8 characters required"
let IMAGE_UPLOAD_TEXT = "Tap on the image to add a picture"
let IMAGE_LOGO = "logo"
let IMAGE_USER_PLACEHOLDER = "user-placeholder"
let IMAGE_PHOTO = "camera.viewfinder"

//DeepLinks
let APPSTOREID = "1572569005"
let LOGO_URL = """
                  https://firebasestorage.googleapis.com/v0/b/wingitapp-1fe28.appspot.com/o/Frame%203.png?alt=media&token=a4d069bd-3163-42d9-8981-c1cf046eacf3
                  """

class Ref {
    // Storage
       static var STORAGE_ROOT = Storage.storage().reference(forURL: "gs://wingitapp-1fe28.appspot.com")
    
        // Storage - Ask
        static var STORAGE_ASKS = STORAGE_ROOT.child("asks")
        static func STORAGE_ASK_ID(askId: String) -> StorageReference {
              return STORAGE_POSTS.child(askId)
        }
       
       // Storage - Avatar
       static var STORAGE_AVATAR = STORAGE_ROOT.child("avatar")
       static func STORAGE_AVATAR_USERID(userId: String) -> StorageReference {
           return STORAGE_AVATAR.child(userId)
       }
       
       // Storage - Posts
       static var STORAGE_POSTS = STORAGE_ROOT.child("posts")
       static func STORAGE_POST_ID(postId: String) -> StorageReference {
             return STORAGE_POSTS.child(postId)
       }
    
        // Storage - Chat
        static var STORAGE_CHAT = STORAGE_ROOT.child("chat")
        static func STORAGE_CHAT_ID(chatId: String) -> StorageReference {
              return STORAGE_CHAT.child(chatId)
        }
       
       // Firestore - Database Root
       static var FS_ROOT = Firestore.firestore()
       
       // Firestore - Users
       static var FS_COLLECTION_USERS = FS_ROOT.collection("users")
       static func FS_DOC_USERID(userId: String) -> DocumentReference {
           return FS_COLLECTION_USERS.document(userId)
       }

        // Firestore - Block
        static var FS_COLLECTION_BLOCKED = FS_ROOT.collection("Blocked")
        static func FS_DOC_BLOCKED_USERID(userId: String) -> DocumentReference {
            return FS_COLLECTION_BLOCKED.document(userId)
        }
    // Firestore - Devices
    static var FS_COLLECTION_DEVICES = FS_ROOT.collection("devices")
    
    // Firestore - Asks
    static var FS_COLLECTION_ASKS = FS_ROOT.collection("asks")
    static func FS_COLLECTION_ASKS_FOR_USER(userId: String) -> CollectionReference? {
        return FS_COLLECTION_ASKS.whereField("createdby", isEqualTo: userId) as? CollectionReference
    }
    static func FS_COLLECTION_OPEN_ASKS_FOR_USER(userId: String) -> CollectionReference? {
        return FS_COLLECTION_ASKS_FOR_USER(userId: userId)?.whereField("status", isEqualTo: "open") as? CollectionReference
    }
    static func FS_COLLECTION_CLOSED_ASKS_FOR_USER(userId: String) -> CollectionReference? {
        return FS_COLLECTION_ASKS_FOR_USER(userId: userId)?.whereField("status", isEqualTo: "closed") as? CollectionReference
    }
    static func FS_COLLECTION_ASKS_FOLLOWING(userId: String) -> CollectionReference? {
        return FS_COLLECTION_ASKS.whereField("followers", arrayContains: userId) as? CollectionReference
    }
    static func FS_COLLECTION_ASKS_BUMPED(userId: String) -> CollectionReference? {
        return FS_COLLECTION_ASKS.whereField("bumpedBy", arrayContains: userId) as? CollectionReference
    }
  
    static func FS_DOC_ASKS_FOR_ASKID(askId: String) -> DocumentReference? {
        return FS_COLLECTION_ASKS.document(askId)
    }
    
    // Firestore - Referrals
    static var FS_COLLECTION_REFERRALS = FS_ROOT.collection("referrals")
    static func FS_COLLECTION_REFERRALS_RECEIVED_BY(userId: String) -> CollectionReference? {
        return FS_COLLECTION_REFERRALS.whereField("receiverId", isEqualTo: userId) as? CollectionReference
    }
    static func FS_COLLECTION_PENDING_REFERRALS_FOR_USER(userId: String) -> CollectionReference? {
        return FS_COLLECTION_REFERRALS_RECEIVED_BY(userId: userId)?.whereField("status", isEqualTo: "pending") as? CollectionReference
    }
    static func FS_COLLECTION_REFERRALS_SENT_BY(userId: String) -> CollectionReference? {
        return FS_COLLECTION_REFERRALS.whereField("senderId", isEqualTo: userId) as? CollectionReference
    }
    static func FS_COLLECTION_REFERRALS_FOR_ASK(postId: String) -> CollectionReference? {
        return FS_COLLECTION_REFERRALS.whereField("askId", isEqualTo: postId) as? CollectionReference
    }
    
    ///askId
//    static func FS_COLLECTION_REFERRALS_FOR_ASK(askId: String) -> CollectionReference? {
//        return FS_COLLECTION_REFERRALS.whereField("askId", isEqualTo: askId) as? CollectionReference
//    }
    
    
    // Firestore - Comments
    static var FS_COLLECTION_COMMENTS = FS_ROOT.collection("comments")
    static func FS_COLLECTION_COMMENTS_FOR_ASK(askId: String) -> CollectionReference? {
        return FS_COLLECTION_ASKS.whereField("askId", isEqualTo: askId) as? CollectionReference
    }
    
    // Firestore - Timeline
    static var FS_COLLECTION_TIMELINE = FS_ROOT.collection("timeline")
    static func FS_COLLECTION_ASK_TIMELINE_FOR_USER(userId: String) -> CollectionReference? {
        return FS_COLLECTION_TIMELINE.document(userId).collection("askTimeline")
    }
    
       static func FS_DOC_TIMELINE_FOR_USERID(userId: String) -> DocumentReference {
          return FS_COLLECTION_TIMELINE.document(userId)
       }
       
        // Firestore - Posts
        static var FS_COLLECTION_ALL_POSTS = FS_ROOT.collection("all_posts")
        static var FS_COLLECTION_MY_POSTS = FS_ROOT.collection("myPosts")
    
        static var FS_COLLECTION_ALL_DONE = FS_ROOT.collection("all_done")
        
       static func FS_DOC_COMMENTS_FOR_POSTID(postId: String) -> DocumentReference {
              return FS_COLLECTION_COMMENTS.document(postId)
        }
    
        static var FS_COLLECTION_REPORTS = FS_ROOT.collection("reports")
        static func FS_DOC_REPORTS_FOR_POSTID(postId: String) -> DocumentReference {
               return FS_COLLECTION_REPORTS.document(postId)
         }
    
        static var FS_COLLECTION_CHAT = FS_ROOT.collection("chat")
        static func FS_COLLECTION_CHATROOM(senderId: String, recipientId: String) -> CollectionReference {
            return FS_COLLECTION_CHAT.document(senderId).collection("chatRoom").document(recipientId).collection("chatItems")
        }
        static var FS_COLLECTION_INBOX_MESSAGES = FS_ROOT.collection("messages")
        static func FS_COLLECTION_INBOX_MESSAGES(userId: String?) -> CollectionReference? {
            guard let userId = userId else { return nil }
                  return FS_COLLECTION_INBOX_MESSAGES.document(userId).collection("inboxMessages")
        }
    
        static func FS_DOC_INBOX_DICTIONARY_BETWEEN(senderId: String, recipientId: String) -> DocumentReference {
           return FS_COLLECTION_INBOX_MESSAGES.document(senderId).collection("inboxMessages").document(recipientId)
        }
    
        static var FS_COLLECTION_CONNECT_REQUESTS = FS_ROOT.collection("connectRequests")
        static func FS_COLLECTION_CONNECT_REQUESTS_SENT_BY(userId: String) -> CollectionReference {
            return FS_COLLECTION_CONNECT_REQUESTS.document(userId).collection("userSentRequests")
        }
        static func FS_COLLECTION_CONNECT_REQUESTS_INBOX_FOR_USER(userId: String) -> CollectionReference {
            return FS_COLLECTION_CONNECT_REQUESTS.document(userId).collection("userReceivedRequests")
        }
        static func FS_DOC_CONNECT_REQUEST_SENT(sentByUserId: String, receivedByUserId: String) -> DocumentReference {
            return FS_COLLECTION_CONNECT_REQUESTS.document(sentByUserId).collection("userSentRequests").document(receivedByUserId)
        }
    
        static func FS_DOC_CONNECT_REQUEST_RECEIVED(receivedByUserId: String, sentFromUserId: String) -> DocumentReference {
            return FS_COLLECTION_CONNECT_REQUESTS.document(receivedByUserId).collection("userReceivedRequests").document(sentFromUserId)
        }
    
        static var FS_COLLECTION_CONNECTIONS = FS_ROOT.collection("connections")
        static func FS_DOC_CONNECTION_BETWEEN_USERS(user1Id: String, user2Id: String) -> DocumentReference {
            return FS_COLLECTION_CONNECTIONS.document(user1Id).collection("userConnections").document(user2Id)
        }
        static func FS_COLLECTION_CONNECTIONS_FOR_USER(userId: String) -> CollectionReference {
               return FS_COLLECTION_CONNECTIONS.document(userId).collection("userConnections")
        }
    
        static var FS_COLLECTION_ACTIVITY = FS_ROOT.collection("activity")
        static func FS_COLLECTION_ACTIVITY_EVENTS_FOR_USER(userId: String) -> CollectionReference {
               return FS_COLLECTION_CONNECTIONS.document(userId).collection("events")
        }
  
        static func FS_COLLECTION_USER_BUMPS_BY_POST(userId: String, postId: String) -> CollectionReference {
          return FS_COLLECTION_USERS.document(userId).collection("bumpedPosts").document(postId).collection("users")
        }
}

