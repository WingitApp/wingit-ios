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
   
    //recipientId --> current user.

  
    var body: some View {
      VStack(alignment: .leading){
        HStack(alignment: .top) {
          NotificationUserAvatar(imageUrl: referral.sender?.profileImageUrl ?? "", type: referral.status.rawValue)
                  .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                  Group {
                    Text(referral.sender?.displayName ?? "").fontWeight(.semibold) +
                    Text(" has referred you to help with ") +
                      Text(referral.ask?.username ?? "").fontWeight(.semibold) +
                    Text("'s ask. ") +
                    Text(
                      timeAgoSinceDate(
                        Date(timeIntervalSince1970: Double(referral.createdAt?.seconds ?? 0)),
                        currentDate: Date(),
                        numericDates: true
                      )
                    ).font(.caption).foregroundColor(.gray)
                      
                  }
                  .font(.subheadline)
                  .fixedSize(horizontal: false, vertical: true)
                 
                }
                
                Spacer()
                Button(
                    action: {
                        referralsViewModel.ignoreReferral(referralId: referral.id)
                        logToAmplitude(event: .ignoreReferral)
                },
                       label: {
                        Image(systemName: "xmark").foregroundColor(.gray)
                })
                }
           

        }
      .padding(.top, 10)
    }
}
