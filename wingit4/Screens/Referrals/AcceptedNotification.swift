//
//  AcceptedNotification.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/8/21.
//

import SwiftUI
import URLImage

struct AcceptedNotification: View {

    @State var referral: Referral
 //   @Binding var post: Post 

    var body: some View {
        VStack{
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
        }.padding()
            Divider()
        }
    }
}

struct BumpedNotification: View {
    
    @State var referral: Referral
    
    var body: some View {
        VStack{
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
        }.padding()
            Divider()
        }
    }
}

struct ClosedNotification: View {
    
    @State var referral: Referral
    
    var body: some View {
        VStack{
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
        }.padding()
        .opacity(0.3)
            Divider()
        }
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
