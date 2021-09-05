//
//  ReferHeader.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI
import URLImage

struct ReferHeader: View {
    
    @EnvironmentObject var referViewModel: ReferViewModel
    @Binding var referral: Referral
   // @Binding var post: Post
    
    //senderId --> header
    
    //askId --> postId (body)
    //mediaUrl --> avatar of the asker. (body)
   
    //receiverId --> current user.

    
    var body: some View {
        VStack {
            HStack {
//                URLImage(URL(string: post.avatar)!,
//                   content: {
//                      $0.image
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .clipShape(Circle())
//                   }).frame(width: 35, height: 35)
                    Image(systemName: "camera").resizable().clipShape(Circle())
                        .frame(width: 35, height: 35)
                    VStack(alignment: .leading) {
                        Text(referral.sender?.username ?? "").font(.subheadline).bold()
                    }
                
                    Spacer()
                Button(action: {},
                       label: {
                        Image(systemName: "xmark").foregroundColor(.gray)
                })
                }.padding(.trailing, 15).padding(.leading, 15)
            VStack(alignment: .leading, spacing: 10){
                Text(referral.text ?? "").font(.system(size: 14)).padding(.horizontal)
            }
        }.padding(.top, 10)
    }
}


