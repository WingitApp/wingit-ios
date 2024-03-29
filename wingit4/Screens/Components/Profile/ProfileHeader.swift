//
//  ProfileHeader.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import SwiftUI
struct ProfileHeader: View {
 //   @EnvironmentObject var session: SessionStore
    var user: User?
    var postCount: Int
//    var doneCount: Int
    
    @State var done: Bool = false
    
    var body: some View {
        
            if user != nil {
                VStack(alignment:.center){
                    HStack{
                    VStack {
                        Text("\(postCount)").font(.headline)
                        Text("Asks").font(.subheadline).foregroundColor(.gray)
                    }.padding(10)
//                    NavigationLink(
//                        destination: DoneView(user: user!),
//                        label: {
//                            VStack{
//                            Text("\(doneCount)").font(.headline).foregroundColor(Color("bw"))
//                            Text("Done").font(.subheadline).foregroundColor(.gray)
//                            }.padding(10)
//                        })
                    }
            
            }
//            .sheet(isPresented: $done, content: {
//                DoneView(user: user!)   })

        }
    }
}

