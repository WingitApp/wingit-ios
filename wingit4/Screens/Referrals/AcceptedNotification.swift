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

    var body: some View {
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
    }
}

struct BumpedNotification: View {
    
    @State var referral: Referral
    
    var body: some View {
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
    }
}


