//
//  AcceptedNotification.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/8/21.
//

import SwiftUI
import URLImage

struct AcceptedNotification: View {

    @Binding var referral: Referral
    var post: Post


    var body: some View {
        
      NavigationLink( destination: AskDetailView(postId: post.postId, post: post, isProfileView: false)) {
        HStack {
          NotificationUserAvatar(imageUrl: referral.ask?.avatar ?? "", type: referral.status.rawValue)
            .padding(.trailing, 10)
          
            HStack {
              VStack(alignment: .leading) {
                Group {
                Text("You have accepted ") +
                  Text("\(referral.sender?.displayName ?? "")" + "'s").fontWeight(.semibold) +
                Text(" request to help ") +
                  Text("\(referral.ask?.username ?? "").").fontWeight(.semibold)
                }
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
                Spacer()

                TimeAgoStamp(date: Double(referral.createdAt?.seconds ?? 0))

                }

                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.gray).padding(10)
                    .font(.system(size: 10))
            }

          
            //TimeAgoStamp(date: activity.date)
        }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }.buttonStyle(PlainButtonStyle())
    }
}

struct WingNotification: View {
    
    @Binding var referral: Referral
    var post: Post
    
    var body: some View {
 
            NavigationLink(destination: AskDetailView(postId: post.postId, post: post, isProfileView: false)) {
        HStack {
          NotificationUserAvatar(imageUrl: referral.ask?.avatar ?? "", type: referral.status.rawValue)
            .padding(.trailing, 10)
      
            HStack {
              VStack(alignment: .leading) {
                Group {
                  Text("You have winged ") +
                  Text("\(referral.ask?.username ?? "")'s").fontWeight(.semibold) +
                  Text(" ask.")
                }
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
                Spacer()
                TimeAgoStamp(date: Double(referral.createdAt?.seconds ?? 0))
              }
                

                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.gray).padding(10)
                    .font(.system(size: 10))
            }
        
            //TimeAgoStamp(date: activity.date)
        }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }.buttonStyle(PlainButtonStyle())
    }
}

struct ClosedNotification: View {
    
    @Binding var referral: Referral
    var post: Post
    
    var body: some View {
        NavigationLink(
          destination: AskDetailView(postId: post.postId, post: post, isProfileView: false)
        ) {
        HStack {
          NotificationUserAvatar(imageUrl: referral.ask?.avatar ?? "", type: referral.status.rawValue)
            .padding(.trailing, 10)
            HStack {
              VStack(alignment: .leading){
                Group {
                Text("You have declined ") +
                  Text("\(referral.sender?.displayName ?? "")'s").fontWeight(.semibold) +
                  Text(" request to help ") +
                  Text("\(referral.ask?.username ?? "").").fontWeight(.semibold)
                }
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
                Spacer()
                TimeAgoStamp(date: Double(referral.createdAt?.seconds ?? 0))
              }
               

                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.gray).padding(10)
                    .font(.system(size: 10))
            }
     
            //TimeAgoStamp(date: activity.date)
        }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }.buttonStyle(PlainButtonStyle())
    }
}


//.overlay(
//  RoundedRectangle(cornerRadius: 20)
//    .stroke(Color.gray, lineWidth: 0.5)
//)
//.padding(
//  EdgeInsets(top: 5, leading: 15, bottom: 3, trailing: 15)
//)
//.modifier(FeedItemShadow())
