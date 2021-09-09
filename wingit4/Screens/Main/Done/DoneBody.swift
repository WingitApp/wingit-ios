//
//  DoneBody.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/8/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct DoneBody: View {
    let uid = Auth.auth().currentUser!.uid
    @State var ImageScreen: Bool = false
    @State var reportScreen: Bool = false
    @ObservedObject var doneViewModel = DoneViewModel()
 //   @ObservedObject var commentViewModel = CommentViewModel()
    @State var showComments : Bool = false
    
    init(donepost: DonePost) {
        self.doneViewModel.donepost = donepost
    }
    var body: some View {
        VStack{
            
            HStack{
       
                    Text(doneViewModel.donepost.caption).font(.subheadline).padding(.bottom, 2).fixedSize(horizontal: false, vertical: true)
                 
          
                Spacer(minLength: 0)
                if doneViewModel.donepost.doneMediaUrl != "" {
                    Button(action: {
                        withAnimation(.easeInOut){
                            ImageScreen.toggle()
                        }
                    }, label: {
                        URLImage(URL(string: doneViewModel.donepost.doneMediaUrl)!,
                                 content: {
                                    $0.image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                 }).frame(width: 200, height: 250).cornerRadius(3).clipped()
                    })
                    
                }
            }.padding(.horizontal)
            
        }
       
        .sheet(isPresented: $ImageScreen, content: {
            doneMediaView(donepost: doneViewModel.donepost)
        })
    }
}
