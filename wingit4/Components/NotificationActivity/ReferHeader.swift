//
//  ReferHeader.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI
import URLImage

struct ReferHeader: View {
    
    @EnvironmentObject var referralsViewModel: ReferralsViewModel
    @Binding var referral: Referral
    @Binding var post: Post
    
   // @Binding var post: Post
    
    //senderId --> header
    
    //askId --> postId (body)
    //mediaUrl --> avatar of the asker. (body)
   
    //receiverId --> current user.

  
    var body: some View {
      VStack(alignment: .leading){
            HStack {
                URLImageView(urlString: referral.sender?.profileImageUrl)
                  .clipShape(Circle())
                  .frame(width: 35, height: 35)
                  .overlay(
                    RoundedRectangle(cornerRadius: 100)
                      .stroke(Color.gray, lineWidth: 1)
                  )
                
                VStack(alignment: .leading) {
                    Text(referral.sender?.username ?? "")
                      .fontWeight(.semibold)
                      .modifier(UserNameStyle())
                    TimeAgoStamp(date: Double(referral.createdAt?.seconds ?? 0))
                }
                
                Spacer()
                Button(action: {referralsViewModel.ignoreReferral(referralId: referral.id)},
                       label: {
                        Image(systemName: "xmark").foregroundColor(.gray)
                })
                }
            Text("Hey, I'm referring you to help with this ask.")
              .font(.system(size: 14))
              .padding(.top, 5)
        }
        .padding(
          EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        )
    }
}
