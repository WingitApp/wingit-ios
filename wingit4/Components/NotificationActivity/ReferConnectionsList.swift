//
//  ReferConnections.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI
import Firebase
import URLImage

struct ReferConnectionsList: View {
    
    @StateObject var referViewModel = ReferViewModel()
 //   @Binding var post: Post
    //var user: User
   
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
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
                               label: {
                            Text("Done")
                                .fontWeight(.heavy)
                                .foregroundColor(.green)
                        })
                    }
                    .padding([.horizontal,.top])
                    .padding(.bottom, 10)
                    /// start list
                   CardView()
                    ///end list
                }
//                .padding(.bottom,10)
//                .padding(.top,10)
                .background(Color.white)
            }
            
        }
        .environmentObject(referViewModel)
        .onAppear {
            referViewModel.loadConnections()
        }
    }
}

struct CardView: View {
    @EnvironmentObject var referViewModel: ReferViewModel
    @State var checked: Bool = false
    
    var body: some View {
        
        List {
            ForEach(self.referViewModel.users, id: \.uid) { user in
//                Button(action:{checked.toggle()}){
                        HStack {
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
                            
                               // ZStack{
//                                    Circle()
//                                        .stroke(checked ? Color.green : Color.gray, lineWidth: 1)
//                                        .frame(width: 25, height: 25)
//                                    if checked {
//                                        Image(systemName: "checkmark.circle.fill")
//                                            .font(.system(size:25))
//                                            .foregroundColor(.green)
//                                    }
                              //  }
                        }
                        .padding(10)
                        .contentShape(Rectangle())
                        .onTapGesture(perform: {})
//                }
               
            }
        }
//        List {
//            ForEach(self.referViewModel.users, id: \.uid) { user in
////                Button(action:{checked.toggle()}){
//                        HStack {
//                        URLImage(URL(string: user.profileImageUrl)!,
//                        content: {
//                            $0.image
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .clipShape(Circle())
//                        }).frame(width: 50, height: 50)
//
//                            VStack(alignment: .leading, spacing: 5) {
//                             Text(user.username).font(.headline).bold()
//                                Text(user.bio).font(.subheadline)
//                            }
//                            Spacer()
//                                ZStack{
//                                    Circle()
//                                        .stroke(checked ? Color.green : Color.gray, lineWidth: 1)
//                                        .frame(width: 25, height: 25)
//                                    if checked {
//                                        Image(systemName: "checkmark.circle.fill")
//                                            .font(.system(size:25))
//                                            .foregroundColor(.green)
//                                    }
//                                }
//                        }
//                        .padding(10)
//                        .contentShape(Rectangle())
//                        .onTapGesture(perform: {})
////                }
//
//            }
//        }
    }
}
