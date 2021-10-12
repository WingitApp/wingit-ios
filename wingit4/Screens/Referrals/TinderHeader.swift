//
//  Tinder1.swift
//  wingit4
//
//  Created by Amy Chun on 10/6/21.
//

import SwiftUI

struct TinderHeader: View {
  
  @EnvironmentObject var referralsViewModel: ReferralsViewModel
  @Binding var referral: Referral
  
  var body: some View {
    
    HStack(alignment: .top) {
      Image("user-placeholder")
              .resizable()
              .clipShape(Circle())
              .frame(width: 50, height: 50)
              .overlay(
                RoundedRectangle(cornerRadius: 100)
                  .stroke(Color.gray, lineWidth: 1)
              )
              .padding([.horizontal])
            
            VStack(alignment: .leading) {
              Group {
                Text("Sender").fontWeight(.semibold) +
                Text(" Hey I think you can help her.")
                Text("5 min ago").font(.caption).foregroundColor(.gray)
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
    }.padding(.vertical).padding(.trailing, 10)
      .background(Color.white)
    
  }
}

//struct TinderHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        TinderScreen()
//    }
//}
