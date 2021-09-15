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
        HStack(alignment: .top) {
                URLImageView(urlString: referral.sender?.profileImageUrl)
                  .clipShape(Circle())
                  .frame(width: 50, height: 50)
                  .overlay(
                    RoundedRectangle(cornerRadius: 100)
                      .stroke(Color.gray, lineWidth: 1)
                  )
                  .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                  Group {
                    Text(referral.sender?.displayName ?? "").fontWeight(.semibold) +
                    Text(" referred you to help ") +
                      Text(referral.ask?.username ?? "").fontWeight(.semibold) +
                    Text("'s ask.")
                  }
                  .font(.subheadline)
                  .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    TimeAgoStamp(date: Double(referral.createdAt?.seconds ?? 0))
                }
                
                Spacer()
                Button(action: {referralsViewModel.ignoreReferral(referralId: referral.id)},
                       label: {
                        Image(systemName: "xmark").foregroundColor(.gray)
                })
                }
           

        }
        .padding(
          EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        )
    }
}
