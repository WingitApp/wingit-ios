//
//  Tinder1.swift
//  wingit4
//
//  Created by Amy Chun on 10/6/21.
//

import SwiftUI
import URLImage


struct TinderHeader: View {
  
  @EnvironmentObject var referralsViewModel: ReferralsViewModel
  @Binding var referral: Referral
  
  var body: some View {
    
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
                action: { },
                   label: {
                    Image(systemName: "xmark").foregroundColor(.gray)
            })
    }.padding()
      .background(Color.white)
      .frame(width: 375)
    
  }
}

//struct TinderHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        TinderScreen()
//    }
//}
