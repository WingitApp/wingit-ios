//
//  ReferFooter.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/2/21.
//

import SwiftUI

struct ReferFooter: View {
  @Binding var referral: Referral
  
    var body: some View {
        
        HStack(spacing: 20){
            
            BumpButton()
            AcceptButton()
            
        }
    }
}

struct AcceptButton: View {
    var body: some View {
        
      
        
        Button(action: {},
               label: {
                VStack{
                    Text("Accept")
                        .foregroundColor(.green)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .frame(width: UIScreen.main.bounds.width - 235, height: UIScreen.main.bounds.width / 9)
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.green.opacity(0.5),lineWidth: 1.5))
        })

    }
}

struct BumpButton: View {
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
               label: {
                VStack{
                    Text("Bump")
                        .foregroundColor(.pink)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .frame(width: UIScreen.main.bounds.width - 235, height: UIScreen.main.bounds.width / 9)
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.pink.opacity(0.5),lineWidth: 1.5))
        })

    }
}

//struct BumpButton: View {
//    @EnvironmentObject var referViewModel: ReferViewModel
//    @Binding var post: Post
//  //  @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
////    @EnvironmentObject var session: SessionStore
//
//    var body: some View {
//        Button(action: {
//            referViewModel.isReferListOpen.toggle()
//        }
////                ReferConnectionsList(post: $post)
////                .environmentObject(referViewModel)
//            ,
//            label: {
//                Image(systemName: "person.3")
//                    .foregroundColor(.gray)
//                    .padding(.trailing, 10)
//            })
////        Button(
////          action: onTapReferIcon,
////          label: {
////            Image(systemName: "person.3")
////        })
////        .foregroundColor(.gray)
////        .padding(.trailing, 10)
//    }
//}
//
