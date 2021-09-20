//
//  ReferConnections.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI
import Firebase
import URLImage
import SPAlert

struct ReferConnectionsList: View {
    @EnvironmentObject var referViewModel: ReferViewModel
    @Binding var post: Post
  //  var postId: String
  
    func onSend() {
      referViewModel.sendReferrals(
          askId: post.postId
      )
    }
  
    func onAppearLoadConnectionsList() {
      referViewModel.loadConnections(post: post)
    }
    
  

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 0){
                  HStack{
                      Text("Choose friends who can help")
                          .font(.title3)
                          .fontWeight(.semibold)
                          .foregroundColor(Color("bw"))
                      Spacer()
                      Button(
                        action: onSend,
                        label: {
                          Text("Send")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemTeal))
                      })
                  }
                  .padding([.horizontal,.top])
                  .padding(.bottom, 15)
              
                  HStack(alignment: .center) {
                    
                    UserBumpCountSummary(
                      users:
                        self.referViewModel.userBumps +
                        self.referViewModel.selectedUsers
                    )
              
                    Spacer()
                  }
                  .frame(width: UIScreen.main.bounds.width)
                  .padding(.bottom, 15)
              
                Text("Your Connections")
                  .font(.headline)
                  .padding(.leading, 15)
                  .padding(.bottom, 3)
                Divider()
                List {
                  ForEach(
                    Array(self.referViewModel.connections.enumerated()),
                    id: \.element
                  ) { index, user in
                        ReferralUserCard(
                          user: user,
                          isChecked: (
                            self.referViewModel.userBumps.contains(user) ||
                            self.referViewModel.selectedUsers.contains(user)
                          )
                        )
                        .opacity(self.referViewModel.userBumps.contains(user) ? 0.6 : 1)
                    }
//                  ForEach(
//                    Array(self.referViewModel.userBumps.enumerated()),
//                    id: \.element
//                  ) { index, user in
//                      ReferralUserCard(
//                        user: user,
//                        isChecked: true
//                      )
//                      .allowsHitTesting(false)
//                  }
                }
                .padding(.leading, -15)
              }
              .background(Color.white)
            
        }
        .preferredColorScheme(.light)
        .onAppear(perform: onAppearLoadConnectionsList)
        .environmentObject(referViewModel)
    }
}

