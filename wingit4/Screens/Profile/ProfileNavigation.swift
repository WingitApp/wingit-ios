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
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    var user: User?
    let uid = Auth.auth().currentUser?.uid
    
    var body: some View {
        
        VStack{
            HStack{
                URLImage(URL(string: user!.profileImageUrl!)!,
            content: {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            }).frame(width: 50, height: 50)
              .padding(.horizontal, 15)
                
                VStack(alignment: .leading, spacing: 5) {
                 Text(user!.username).font(.headline).bold()
                    Text(user!.bio? "").font(.subheadline)
                }.foregroundColor(Color("bw"))
              
            }.frame(maxWidth: .infinity, alignment: .center)
        }
            .padding(.horizontal, 10)
            .frame(height: 90)
            .background(Color.white)
        
//        if profileViewModel.offset  > 250{
//            Divider()
//        }
    }
}

