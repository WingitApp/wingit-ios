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
                            .foregroundColor(Color("bw"))
                        Spacer()
                        Button(action: {
                            //askId(postId) & senderId (auth.dude) & senderId(userId of the one selected
                            referViewModel.sendReferral(
                                askId: post.postId
                            )
                        },
                               label: {
                            Text("Send")
                                .fontWeight(.heavy)
                                .foregroundColor(.green)
                        })
                    }
                    .padding([.horizontal,.top])
                    .padding(.bottom, 10)
                    /// start list
                    List {
                        ForEach(self.referViewModel.allUsers, id: \.uid) { user in
                            CardView(user: user, userId: user.uid)
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
            URLImage(URL(string: user.profileImageUrl)!,
            content: {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            }).frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 5) {
                 Text(user.username).font(.headline).bold()
                    Text(user.bio).font(.subheadline)
                }
                Spacer()
                
                ZStack{
                    Circle()
                        .stroke(
                            self.referViewModel.selectedUsers.contains(userId) || self.referViewModel.allReferralRecipientIds.contains(userId)
                                ? Color.green
                                : Color.gray,
                                lineWidth: 1
                        )
                        .frame(width: 25, height: 25)
                    if self.referViewModel.selectedUsers.contains(userId) || self.referViewModel.allReferralRecipientIds.contains(userId) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size:25))
                            .foregroundColor(.green)
                    }
                }
            }
        .padding(10)
        .contentShape(Rectangle())
        .opacity(self.referViewModel.allReferralRecipientIds.contains(userId) ? 0.3 : 1)
        .onTapGesture(perform: onTapGesture)
//                }
               
        }
       

}

struct CardView: View {
    @EnvironmentObject var referViewModel: ReferViewModel

    var user: User
    var userId: String
    
    func onTapGesture() {
      //  print("onTap called")
        self.referViewModel.handleUserSelect(userId: userId)
    }
    
    var body: some View {
        
        HStack{
            URLImage(URL(string: user.profileImageUrl)!,
            content: {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            }).frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 5) {
                 Text(user.username).font(.headline).bold()
                    Text(user.bio).font(.subheadline)
                }
                Spacer()
                
                ZStack{
                    Circle()
                        .stroke(
                            self.referViewModel.selectedUsers.contains(userId)
                                ? Color.green
                                : Color.gray,
                                lineWidth: 1
                        )
                        .frame(width: 25, height: 25)
                    if self.referViewModel.selectedUsers.contains(userId) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size:25))
                            .foregroundColor(.green)
                    }
                }
            }
        .padding(10)
        .contentShape(Rectangle())
        .onTapGesture(perform: onTapGesture)
//                }
               
        }
       

}
