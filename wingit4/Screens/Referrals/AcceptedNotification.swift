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
    @Binding var post: Post

    // Menu
    @StateObject var askCardViewModel = AskCardViewModel()
    @StateObject var askMenuViewModel = AskMenuViewModel()
    @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
    // Comment
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var referViewModel = ReferViewModel()
    @StateObject var commentInputViewModel = CommentInputViewModel()
    // Like
    @StateObject var footerCellViewModel = FooterCellViewModel()

    var body: some View {
        
        NavigationLink(
            destination: AskDetailView(post: $post)
                .environmentObject(askCardViewModel)
                .environmentObject(askMenuViewModel)
                .environmentObject(askDoneToggleViewModel)
                .environmentObject(commentViewModel)
                .environmentObject(commentInputViewModel)
                .environmentObject(footerCellViewModel)
        )
        {
        HStack {
            URLImage(
                URL(string: referral.ask?.avatar ?? "")!,
              content: {
                 $0.image
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .clipShape(Circle())
            }).frame(width: 50, height: 50)
            HStack {
                Group {
                Text("You have accepted")
                    Text("\(referral.ask?.username ?? "")'s").bold()
                Text("ask")
                }.font(.subheadline)
            }
            Spacer()
            //TimeAgoStamp(date: activity.date)
        }.padding(.leading, 10)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct BumpedNotification: View {
    
    @Binding var referral: Referral
    @Binding var post: Post
    // Menu
    @StateObject var askCardViewModel = AskCardViewModel()
    @StateObject var askMenuViewModel = AskMenuViewModel()
    @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
    // Comment
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var referViewModel = ReferViewModel()
    @StateObject var commentInputViewModel = CommentInputViewModel()
    // Like
    @StateObject var footerCellViewModel = FooterCellViewModel()
    
    var body: some View {
 
            NavigationLink(
                destination: AskDetailView(post: $post)
                    .environmentObject(askCardViewModel)
                    .environmentObject(askMenuViewModel)
                    .environmentObject(askDoneToggleViewModel)
                    .environmentObject(commentViewModel)
                    .environmentObject(commentInputViewModel)
                    .environmentObject(footerCellViewModel)
            )
            {
        HStack {
            URLImage(
                URL(string: referral.ask?.avatar ?? "")!,
              content: {
                 $0.image
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .clipShape(Circle())
            }).frame(width: 50, height: 50)
            HStack {
                Group {
                Text("You have bumped")
                    Text("\(referral.ask?.username ?? "")'s").bold()
                Text("ask")
                }.font(.subheadline)
            }
            Spacer()
            //TimeAgoStamp(date: activity.date)
        }.padding(.leading, 10)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct ClosedNotification: View {
    
    @Binding var referral: Referral
    @Binding var post: Post
    // Menu
    @StateObject var askCardViewModel = AskCardViewModel()
    @StateObject var askMenuViewModel = AskMenuViewModel()
    @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
    // Comment
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var referViewModel = ReferViewModel()
    @StateObject var commentInputViewModel = CommentInputViewModel()
    // Like
    @StateObject var footerCellViewModel = FooterCellViewModel()
    
    var body: some View {
        NavigationLink(
            destination: AskDetailView(post: $post)
                .environmentObject(askCardViewModel)
                .environmentObject(askMenuViewModel)
                .environmentObject(askDoneToggleViewModel)
                .environmentObject(commentViewModel)
                .environmentObject(commentInputViewModel)
                .environmentObject(footerCellViewModel)
        )
        {
        HStack {
            URLImage(
                URL(string: referral.ask?.avatar ?? "")!,
              content: {
                 $0.image
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .clipShape(Circle())
            }).frame(width: 50, height: 50)
            HStack {
                Group {
                Text("You have closed")
                    Text("\(referral.ask?.username ?? "")'s").bold()
                Text("ask")
                }.font(.subheadline)
            }
            Spacer()
            //TimeAgoStamp(date: activity.date)
        }.padding(.leading, 10)
        .opacity(0.3)
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
