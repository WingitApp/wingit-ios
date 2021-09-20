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

    var body: some View {
        VStack {
            VStack{
                Spacer()
                VStack(spacing: 18){
                    HStack{
                        Text("Who can help?")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("Color1"))
                        Spacer()
                        Button(action: {
                            referViewModel.sendReferrals(
                                askId: post.postId
                            )
                        },
                               label: {
                            Text("Send")
                                .fontWeight(.heavy)
                                .foregroundColor(Color(.systemTeal))
                        })
                    }
                    .padding([.horizontal,.top])
                    .padding(.bottom, 10)
                    /// start list
                    List {
                        ForEach(self.referViewModel.allUsers, id: \.id) { user in
                            if (user.id != post.ownerId) {
                                CardView(user: user, userId: user.id ?? "")
                            }
                        }
                    }
                    ///end list
                }
//                .padding(.bottom,10)
//                .padding(.top,10)
                .background(Color.white)
            }
            
        }
        .onAppear {
            referViewModel.loadConnections(askId: post.postId)
        }
        .preferredColorScheme(.light)
    }
}

struct CardView: View {
    @EnvironmentObject var referViewModel: ReferViewModel

    var user: User
    var userId: String
    
    func onTapGesture() {
      //  print("onTap called")
        if self.referViewModel.allReferralRecipientIds.contains(userId) {
            return
        }
        
        self.referViewModel.handleUserSelect(userId: userId)
    }
    
    var body: some View {
        
        HStack{
            URLImageView(urlString: user.profileImageUrl)
                .clipShape(Circle())
                .frame(width: 40, height: 40)
                .overlay(
                  RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.gray, lineWidth: 1)
                )
                VStack(alignment: .leading, spacing: 5) {
                    Text(user.displayName ?? user.username ?? "").font(.headline).bold()
                    Text("@\(user.username ?? "")").font(.subheadline)
                        .foregroundColor(Color(.systemTeal))
                }
                .padding(.leading, 5)
                Spacer()
                
                ZStack{
                    Circle()
                        .stroke(
                            self.referViewModel.selectedUsers.contains(userId) || self.referViewModel.allReferralRecipientIds.contains(userId)
                              ? Color(.systemTeal)
                                : Color.gray,
                                lineWidth: 1
                        )
                        .frame(width: 25, height: 25)
                    if self.referViewModel.selectedUsers.contains(userId) || self.referViewModel.allReferralRecipientIds.contains(userId) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size:25))
                            .foregroundColor(Color("Color"))
                    }
                }
            }
        .padding(
          EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        )
        .contentShape(Rectangle())
        .opacity(self.referViewModel.allReferralRecipientIds.contains(userId) ? 0.3 : 1)
        .onTapGesture(perform: onTapGesture)
      }

}
