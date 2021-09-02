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
    

    var body: some View {

        VStack {
            HStack {
                    Image("photo1").resizable().clipShape(Circle())
                        .frame(width: 35, height: 35)
                    VStack(alignment: .leading) {
                        Text("David").font(.subheadline).bold()
                    }
                    Spacer()
                Image(systemName: "ellipsis")
                }.padding(.trailing, 15).padding(.leading, 15)

          Text("helphelphelp")

//            ZStack(alignment: .trailing){
//                VStack(alignment: .leading){
//                Text("This studio room is fantastic! Highly recommend people to check it out. ").font(.subheadline).padding(.leading, 15)
//                }
//            Image("photo2").resizable().scaledToFill()
//                .frame(width: 200, height: 250).clipped()
//            }
        }
        .padding(.top, 10).padding(.bottom, 10)
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.5),lineWidth: 1.5))

    }
}

