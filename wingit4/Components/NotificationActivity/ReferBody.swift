//
//  ReferBody.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/2/21.
//

import SwiftUI
import URLImage
import FirebaseAuth



struct ReferBody: View {
  @Binding var referral: Referral
  @Binding var post: Post

    var body: some View {
//NavigationLink (
//    destination: AskDetailView(post: $post),
//    label: {
//        VStack {
//            HStack {
//                    Image(systemName: "camera").resizable().clipShape(Circle())
//                        .frame(width: 35, height: 35)
//                    VStack(alignment: .leading) {
//                        Text(referral.ask?.username ?? "").font(.subheadline).bold()
//                    }
//                    Spacer()
//                Image(systemName: "ellipsis")
//                }.padding(.trailing, 15).padding(.leading, 15)
//
//            PostText(ask: referral.ask)
//        }
//        .padding(.top, 10).padding(.bottom, 10)
//        .frame(width: UIScreen.main.bounds.width - 30)
//        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.5),lineWidth: 1.5))
//    })
        VStack {
            HStack {
                URLImage(URL(string: referral.ask?.avatar ?? "")!,
                   content: {
                      $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                   }).frame(width: 35, height: 35)
//                    Image(systemName: "camera").resizable().clipShape(Circle())
//                        .frame(width: 35, height: 35)
                    VStack(alignment: .leading) {
                        Text(referral.ask?.username ?? "").font(.subheadline).bold()
                    }
                    Spacer()
                Image(systemName: "ellipsis")
                }.padding(.trailing, 15).padding(.leading, 15)

            PostText(ask: referral.ask)
        }
        .padding(.top, 10).padding(.bottom, 10)
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.5),lineWidth: 1.5))

    }
}

import SwiftUI

struct PostText: View {
    var ask: Post?
    var body: some View {
        HStack{

            VStack(alignment: .leading, spacing: 10){
                Text(ask?.caption ?? "")
            }.padding(.horizontal)
            Spacer(minLength: 0)
//                Image("photo2").resizable().scaledToFill()
//                               .frame(width: 200, height: 250).clipped()
        }
    }
}


