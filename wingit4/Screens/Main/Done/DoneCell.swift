//
//  DoneCell.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/22/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct DoneCell: View {

    let uid = Auth.auth().currentUser!.uid
    @State var ImageScreen: Bool = false
    @State var reportScreen: Bool = false
    @ObservedObject var doneViewModel = DoneViewModel()
    @ObservedObject var commentViewModel = CommentViewModel()
    @State var showComments : Bool = false
    
    init(donepost: DonePost) {
        self.doneViewModel.donepost = donepost
    }
    
    
    var body: some View {
        VStack{
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
                
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        Text(doneViewModel.donepost.askcaption).font(.subheadline).padding(.bottom, 2).fixedSize(horizontal: false, vertical: true)
                        HStack{
                        Text(timeAgoSinceDate(Date(timeIntervalSince1970: doneViewModel.donepost.askdate), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
//                            NavigationLink(
//                                destination: CommentView(postId: self.doneViewModel.donepost.postId),
//                          label: {
//                              Image(systemName: "message").foregroundColor(.gray).padding(.leading, 15)
//                          })
                            Button(action: {
                                logToAmplitude(event: .viewComments)
                                showComments.toggle()
                            },
                                   label: {
                                    Image(systemName: "message").foregroundColor(.gray).padding(.leading, 15).accentColor(.red)
                            })
                            if !commentViewModel.comments.isEmpty {
                                Text("\(commentViewModel.comments.count)").foregroundColor(.gray).font(.caption)
                            }
                        }
                    }.padding(.horizontal)
                    Spacer(minLength: 0)
                    
                    if doneViewModel.donepost.mediaUrl != "" {
                        Button(action: {
                            withAnimation(.easeInOut){
                                ImageScreen.toggle()
                            }
                        }, label: {
                            URLImage(URL(string: doneViewModel.donepost.mediaUrl)!,
                                     content: {
                                        $0.image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                     }).frame(width: 200, height: 250).cornerRadius(3).clipped()
                        })
                        
                    }
                }
             
                
            }
         
        DoneCellView(donepost: self.doneViewModel.donepost)
        Divider()
        }
        .sheet(isPresented: $ImageScreen, content: {
            doneImageView(donepost: doneViewModel.donepost)
        })
        .sheet(isPresented: $showComments, content: {
//            CommentView(postId: doneViewModel.donepost.postId)
        })
        .onAppear {
            self.commentViewModel.postId = doneViewModel.post == nil ? doneViewModel.donepost.postId : doneViewModel.donepost.postId
            self.commentViewModel.loadComments()
        }
        .onDisappear {
            if self.commentViewModel.listener != nil {
                self.commentViewModel.listener.remove()
            }}
    }

}
    

struct DoneCellView: View {
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
                VStack(alignment: .leading, spacing: 10){
                    Text(doneViewModel.donepost.caption).font(.subheadline).padding(.bottom, 2).fixedSize(horizontal: false, vertical: true)
                    Text(timeAgoSinceDate(Date(timeIntervalSince1970: doneViewModel.donepost.donedate), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                }.padding(.horizontal)
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
            }
            
        } .sheet(isPresented: $ImageScreen, content: {
            doneMediaView(donepost: doneViewModel.donepost)
        })
    }
}
