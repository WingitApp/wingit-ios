//
//  ProfileInformation.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import FirebaseAuth

struct ProfileInformation: View {
    var user: User?
    let uid = Auth.auth().currentUser?.uid
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            if user != nil && self.user!.uid == uid{
                
                Button(action: {Api.User.updateDetails(field: "Name")}) {

              Text("Hi, I'm \(user!.username)").font(.system(size: 30, weight: .medium, design: .default)).foregroundColor(.black)
                                               .fixedSize(horizontal: false, vertical: true)
                }
                              
                             
              Button(action: {Api.User.updateDetails(field: "bio")}) {
                  
                  Text(user!.bio).foregroundColor(.secondary)
                    }
            } else {
                Text("Hi, I'm \(user!.username)").font(.system(size: 30, weight: .medium, design: .default)).foregroundColor(.black)
                Text(user!.bio).foregroundColor(.secondary)
            }
            
        }.padding(.leading, 20)
    }
}

