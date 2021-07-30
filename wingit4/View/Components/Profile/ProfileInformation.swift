//
//  ProfileInformation.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import FirebaseAuth
import URLImage

struct ProfileInformation: View {
    var user: User?
    let uid = Auth.auth().currentUser?.uid
    
    var body: some View {
        
        VStack{
            if user != nil && self.user!.uid == uid{
                
                URLImage(URL(string: user!.profileImageUrl)!,
                content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                }).frame(width: 100, height: 100)
                
                Button(action: {Api.User.updateDetails(field: "Name")}) {

                    Text(user!.username).bold().foregroundColor(Color("bw"))
                }
                              
                             
              Button(action: {Api.User.updateDetails(field: "bio")}) {
                  
                Text("@\(user!.bio)").font(.caption).foregroundColor(.gray)
                    }
            } else {
                URLImage(URL(string: user!.profileImageUrl)!,
                content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                }).frame(width: 100, height: 100)
                Text(user!.username).bold()
                Text(user!.bio).font(.caption).foregroundColor(.gray)
            }
            
        }
    }
}

