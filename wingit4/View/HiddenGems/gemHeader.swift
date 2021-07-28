//
//  gemHeader.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/1/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct gemHeader: View {

    let uid = Auth.auth().currentUser!.uid
    @State var ImageScreen: Bool = false
    @State var reportScreen: Bool = false
    @ObservedObject var gemHeaderViewModel = GemHeaderViewModel()
    @ObservedObject var commentViewModel = CommentViewModel()
    @State var showComments : Bool = false
    
    init(gempost: gemPost) {
        self.gemHeaderViewModel.gempost = gempost
    }
    
    
    var body: some View {
        VStack {
           
            HStack {
                URLImage(URL(string: gemHeaderViewModel.gempost.avatar)!,
                               content: {
                                   $0.image
                                       .resizable()
                                       .aspectRatio(contentMode: .fill)
                                       .clipShape(Circle())
                               }).frame(width: 35, height: 35)
    
                    VStack(alignment: .leading) {
                        Text(gemHeaderViewModel.gempost.username).font(.subheadline).bold()
                       // Text("location").font(.caption)
                    }
                       
                    
                    Spacer()
                
                if gemHeaderViewModel.gempost.ownerId == uid {
                    Menu(content: {

                        Button(action: {Api.gemPost.deletePost(userId: uid, postId: gemHeaderViewModel.gempost.postId)}) {

                            Text("Delete")
                        }

                        Button(action: {}) {

                            Text("Edit")
                        }

                    }, label: {

                        Image(systemName: "ellipsis")
                
                    })
                }
                if gemHeaderViewModel.gempost.ownerId != uid {
                Menu(content: {

                    Button(action: {Api.gemPost.hidePost(userId: gemHeaderViewModel.gempost.ownerId, postId: gemHeaderViewModel.gempost.postId)}) {

                        Text("Hide Post")
                    }
                    
                    Button(action: {reportScreen.toggle()}) {

                        Text("Report")
                    }


                    Button(action: {gemHeaderViewModel.blockUser()}) {

                        Text("Block")
                    }


                }, label: {

                    Image(systemName: "ellipsis")
            
                })
                }
               
               
                }.padding(.trailing, 15).padding(.leading, 15)
            
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text(gemHeaderViewModel.gempost.caption).font(.subheadline).padding(.bottom, 2).fixedSize(horizontal: false, vertical: true)
                    Text(timeAgoSinceDate(Date(timeIntervalSince1970: gemHeaderViewModel.gempost.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                }.padding(.horizontal)
                Spacer(minLength: 0)
                if gemHeaderViewModel.gempost.mediaUrl != "" {
                    Button(action: {
                        withAnimation(.easeInOut){
                            ImageScreen.toggle()
                        }
                    }, label: {
                        URLImage(URL(string: gemHeaderViewModel.gempost.mediaUrl)!,
                              content: {
                                  $0.image
                                      .resizable()
                                      .aspectRatio(contentMode: .fill)
                              }).frame(width: 200, height: 250).cornerRadius(3).clipped()
                    })
//                URLImage(URL(string: gempost.mediaUrl)!,
//                          content: {
//                              $0.image
//                                  .resizable()
//                                  .aspectRatio(contentMode: .fill)
//                          }).frame(width: 200, height: 250).cornerRadius(3).clipped()
                    
                }
            }
            HStack{
//                Button(action: {showComment.toggle()},
//                       label: {
//                        Image(systemName: "message").foregroundColor(.gray).padding(.leading, 15)
//                })
//                NavigationLink(
//                    destination: gemCommentView(gempost: gemHeaderViewModel.gempost),
//                    label: {
//                        Image(systemName: "message").foregroundColor(.gray).padding(.leading, 15)
//                    })
                Button(action: {showComments.toggle()},
                       label: {
                        Image(systemName: "message").foregroundColor(.gray).padding(.leading, 15).accentColor(.red)
                       }).padding(.top, 5)
                if !commentViewModel.comments.isEmpty {
                    Text("\(commentViewModel.comments.count)").foregroundColor(.gray).font(.caption)
                }
                
                Spacer()
            }
            Divider()
           
        }
        .onAppear {
            self.commentViewModel.postId = gemHeaderViewModel.gempost == nil ? gemHeaderViewModel.gempost.postId : gemHeaderViewModel.gempost.postId
            self.commentViewModel.loadComments()
        }
        .onDisappear {
            if self.commentViewModel.listener != nil {
                self.commentViewModel.listener.remove()
            }}
        .sheet(isPresented: $ImageScreen, content: {
            gemImageView(gempost: gemHeaderViewModel.gempost)
        })
        .sheet(isPresented: $reportScreen, content: {
            GemReportInput(gempost: gemHeaderViewModel.gempost, postId: gemHeaderViewModel.gempost.postId)
       })
        .sheet(isPresented: $showComments, content: {
            gemCommentView(gempost: gemHeaderViewModel.gempost)
        })
        
        
//        if showComment {
//            gemCommentView(gempost: self.gempost)
//                .padding(.top, 100)
//                .transition(.move(edge: .trailing))
//                .animation(.spring())
//        }
    }

}
    
