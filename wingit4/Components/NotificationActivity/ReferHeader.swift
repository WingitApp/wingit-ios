//
//  ReferHeader.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI

struct ReferHeader: View {
    var body: some View {
        VStack {
            HStack {
                    Image(systemName: "camera").resizable().clipShape(Circle())
                        .frame(width: 35, height: 35)
                    VStack(alignment: .leading) {
                        Text("David").font(.subheadline).bold()

                    }
                    Spacer()
                Button(action: {},
                       label: {
                        Image(systemName: "xmark").foregroundColor(.gray)
                })
                }.padding(.trailing, 15).padding(.leading, 15)
            VStack(alignment: .leading, spacing: 10){
                Text("Hey can you help my friend? You’re the first person that popped into my head when thinking about dog care. He’s awesome and would love to buy you food in return.  ").font(.system(size: 14)).padding(.horizontal)
            }
        }.padding(.top, 10)
    }
}

//
//import SwiftUI
//
//struct BumperHeader: View {
//    var body: some View {
//        VStack {
//            HStack {
//                    Image(systemName: "camera").resizable().clipShape(Circle())
//                        .frame(width: 35, height: 35)
//                    VStack(alignment: .leading) {
//                        Text("David").font(.subheadline).bold()
//
//                    }
//                    Spacer()
//                Button(action: {},
//                       label: {
//                        Image(systemName: "xmark").foregroundColor(.gray)
//                })
//                }.padding(.trailing, 15).padding(.leading, 15)
//            VStack(alignment: .leading, spacing: 10){
//                Text("Hey can you help my friend? You’re the first person that popped into my head when thinking about dog care. He’s awesome and would love to buy you food in return.  ").font(.system(size: 14)).padding(.horizontal)
//            }
//        }.padding(.top, 10)
//    }
//}
//



//import SwiftUI
//import URLImage
//import FirebaseAuth
//
//struct BumperBody: View {
//    @EnvironmentObject var askCardViewModel: AskCardViewModel
//
//    var body: some View {
//
//        VStack {
//            HStack {
//                    Image("photo1").resizable().clipShape(Circle())
//                        .frame(width: 35, height: 35)
//                    VStack(alignment: .leading) {
//                        Text("David").font(.subheadline).bold()
//                    }
//                    Spacer()
//                Image(systemName: "ellipsis")
//                }.padding(.trailing, 15).padding(.leading, 15)
//
//          postText()
//
////            ZStack(alignment: .trailing){
////                VStack(alignment: .leading){
////                Text("This studio room is fantastic! Highly recommend people to check it out. ").font(.subheadline).padding(.leading, 15)
////                }
////            Image("photo2").resizable().scaledToFill()
////                .frame(width: 200, height: 250).clipped()
////            }
//        }
//        .padding(.top, 10).padding(.bottom, 10)
//        .frame(width: UIScreen.main.bounds.width - 30)
//        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.5),lineWidth: 1.5))
//
//    }
//}
//




//import SwiftUI
//
//struct BumperFooter: View {
//    var body: some View {
//        HStack(spacing: 40){
//            AcceptButton()
//            BumpButton()
//        }
//
//    }
//}
//
//struct AcceptButton: View {
//    var body: some View {
//        Button(action: {},
//               label: {
//                VStack{
//                    Text("Accept")
//                }
//                .padding(.vertical, 10)
//                .padding(.horizontal, 30)
//                .frame(width: UIScreen.main.bounds.width - 300, height: UIScreen.main.bounds.width / 9)
//                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5),lineWidth: 1.5))
//        })
//
//    }
//}
//
//struct BumpButton: View {
//    var body: some View {
//        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
//               label: {
//                VStack{
//                    Text("Bump")
//                }
//                .padding(.vertical, 10)
//                .padding(.horizontal, 30)
//                .frame(width: UIScreen.main.bounds.width - 300, height: UIScreen.main.bounds.width / 9)
//                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5),lineWidth: 1.5))
//        })
//
//    }
//}
//



