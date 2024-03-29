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
    @Binding var post: Post?

    // Menu
    @StateObject var askCardViewModel = AskCardViewModel()
    @StateObject var askMenuViewModel = AskMenuViewModel()
    @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
    // Comment
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var referViewModel = ReferViewModel()
    @StateObject var commentInputViewModel = CommentInputViewModel()

    var body: some View {
        
        NavigationLink(
            destination: AskDetailView(post: $post)
                .environmentObject(askCardViewModel)
                .environmentObject(askMenuViewModel)
                .environmentObject(askDoneToggleViewModel)
                .environmentObject(commentViewModel)
                .environmentObject(commentInputViewModel)
        )
        {
        HStack {
          NotificationUserAvatar(imageUrl: referral.ask?.avatar ?? "", type: referral.status.rawValue)
            .padding(.trailing, 10)
          
            HStack {
              VStack(alignment: .leading) {
                Group {
                Text("You've accepted ") +
                  Text("\(referral.sender?.displayName ?? "")" + "'s").fontWeight(.semibold) +
                Text(" request to help ") +
                  Text("\(referral.ask?.username ?? "").").fontWeight(.semibold)
                }
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
                Spacer()

                TimeAgoStamp(date: Double(referral.updatedAt?.seconds ?? 0))

                }

                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.gray).padding(10)
                    .font(.system(size: 10))
            }

          
            //TimeAgoStamp(date: notification.date)
        }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }.buttonStyle(PlainButtonStyle())
    }
}

struct WingNotification: View {
    
    @Binding var referral: Referral
    @Binding var post: Post?
    // Menu
    @StateObject var askCardViewModel = AskCardViewModel()
    @StateObject var askMenuViewModel = AskMenuViewModel()
    @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
    // Comment
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var referViewModel = ReferViewModel()
    @StateObject var commentInputViewModel = CommentInputViewModel()
    
    var body: some View {
 
            NavigationLink(
                destination: AskDetailView(post: $post)
                    .environmentObject(askCardViewModel)
                    .environmentObject(askMenuViewModel)
                    .environmentObject(askDoneToggleViewModel)
                    .environmentObject(commentViewModel)
                    .environmentObject(commentInputViewModel)
            )
            {
        HStack {
          NotificationUserAvatar(imageUrl: referral.ask?.avatar ?? "", type: referral.status.rawValue)
            .padding(.trailing, 10)
      
            HStack {
              VStack(alignment: .leading) {
                Group {
                  Text("You've re-winged ") +
                  Text("\(referral.ask?.username ?? "")'s").fontWeight(.semibold) +
                  Text(" ask.")
                }
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
                Spacer()
                TimeAgoStamp(date: Double(referral.updatedAt?.seconds ?? 0))
              }
                

                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.gray).padding(10)
                    .font(.system(size: 10))
            }
        
            //TimeAgoStamp(date: notification.date)
        }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }.buttonStyle(PlainButtonStyle())
    }
}

struct ClosedNotification: View {
    
    @Binding var referral: Referral
    @Binding var post: Post?
    // Menu
    @StateObject var askCardViewModel = AskCardViewModel()
    @StateObject var askMenuViewModel = AskMenuViewModel()
    @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
    // Comment
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var referViewModel = ReferViewModel()
    @StateObject var commentInputViewModel = CommentInputViewModel()
    
    var body: some View {
        NavigationLink(
            destination: AskDetailView(post: $post)
                .environmentObject(askCardViewModel)
                .environmentObject(askMenuViewModel)
                .environmentObject(askDoneToggleViewModel)
                .environmentObject(commentViewModel)
                .environmentObject(commentInputViewModel)
        )
        {
        HStack {
          NotificationUserAvatar(imageUrl: referral.ask?.avatar ?? "", type: referral.status.rawValue)
            .padding(.trailing, 10)
            HStack {
              VStack(alignment: .leading){
                Group {
                Text("You've declined ") +
                  Text("\(referral.sender?.displayName ?? "")'s").fontWeight(.semibold) +
                  Text(" request to help ") +
                  Text("\(referral.ask?.username ?? "").").fontWeight(.semibold)
                }
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
                Spacer()
                TimeAgoStamp(date: Double(referral.updatedAt?.seconds ?? 0))
              }
               

                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.gray).padding(10)
                    .font(.system(size: 10))
            }
     
            //TimeAgoStamp(date: notification.date)
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
