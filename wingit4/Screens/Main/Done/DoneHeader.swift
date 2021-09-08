//
//  DoneHeader.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/7/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct DoneHeader: View {
    
    @ObservedObject var doneViewModel = DoneViewModel()
    
    init(donepost: DonePost) {
        self.doneViewModel.donepost = donepost
    }
    
    var body: some View {
        VStack{
           
            HStack {
                
                URLImage(URL(string: doneViewModel.donepost.avatar)!,
                         content: {
                            $0.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                         }).frame(width: 35, height: 35)
                
                VStack(alignment: .leading) {
                    Text(doneViewModel.donepost.username).font(.subheadline).bold()
                    Text(timeAgoSinceDate(Date(timeIntervalSince1970: doneViewModel.donepost.donedate), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                    // Text("location").font(.caption)
                }
                
                Spacer()
                if doneViewModel.donepost.ownerId == doneViewModel.uid {
                Menu(content: {

                    Button(action: {Api.Post.deletePost(userId: doneViewModel.donepost.ownerId, postId: doneViewModel.donepost.postId)}) {

                        Text("Delete")
                    }

//                        Button(action: {}) {
//
//                            Text("Undo Done")
//                        }

                }, label: {

                    Image(systemName: "ellipsis")
            
                })
            }
                
            }.padding(.trailing, 15).padding(.leading, 15)
            
           
         
            
        }
    }
}

