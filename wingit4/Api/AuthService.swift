//
//  AuthService.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage

class AuthService {
    
    static func signInUser(email: String, password: String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
                if !String.isValidEmailAddress(emailAddress: email) {
                    onError("Email input is not a valid email address.")
                    return
                }
               Auth.auth().signIn(withEmail: email.normalizeEmail(), password: password) { (authData, error) in
                   if error != nil {
                        print(error!.localizedDescription)
                        onError(error!.localizedDescription)
                        return
                    }
                    
                    guard let userId = authData?.user.uid else { return }
                    Api.User.loadUser(userId: userId) { (decodedUser) in
                      onSuccess(decodedUser)
                    } onError: {
                        //todo
                        print("error")
                    }
               }
           
    }
    
    static func signupUser(firstName: String, lastName: String, username: String, email: String, password: String, imageData: Data, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
                if !String.isValidEmailAddress(emailAddress: email) {
                    onError("Email input is not a valid email address.")
                    return
                }
        if !String.isValidUsername(username: username) {
            onError("Username must be alphanumeric or underscores with no whitespaces.")
            return
        }
                let normalizedEmail = email.normalizeEmail()
                Auth.auth().createUser(withEmail: normalizedEmail, password: password) { (authData, error) in
                    if error != nil {
                        // TODO: Show toast
                        //    print(error!.localizedDescription)
                        onError(error!.localizedDescription)
                        return
                    }
                    
                    guard let userId = authData?.user.uid else { return }
                    
                    
                    let storageAvatarUserId = Ref.STORAGE_AVATAR_USERID(userId: userId)
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpg"
                    
                    StorageService.saveUser(userId: userId, firstName: firstName, lastName: lastName, username: username, email: email, normalizedEmail: normalizedEmail, imageData: imageData, metadata: metadata, storageAvatarRef: storageAvatarUserId, onSuccess: onSuccess, onError: onError)
 
                }
    }
}
