//
//  ProfileNavigation.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/26/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct ProfileNavigation: View {
    
    var user: User?
    let uid = Auth.auth().currentUser?.uid
    
    var body: some View {
        

            HStack {
                URLImage(URL(string: user!.profileImageUrl)!,
            content: {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            }).frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 5) {
                 Text(user!.username).font(.headline).bold()
                    Text(user!.bio).font(.subheadline)
                }.foregroundColor(Color("bw"))
              
            }.padding(10)
        
    }
}

