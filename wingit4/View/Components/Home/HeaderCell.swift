//
//  HeaderCell.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct HeaderCell: View {
    @ObservedObject var headerCellViewModel = HeaderCellViewModel()

    @State var reportScreen: Bool = false
    @State var ImageScreen: Bool = false
    @State var done: Bool = false
    @State var isProfileView: Bool = false
    
    init(post: Post, isProfileView: Bool) {
        self.headerCellViewModel.post = post
        if !isProfileView {
            self.headerCellViewModel.getUserFromPost(postOwnerId: post.ownerId)
        } else {
            self.isProfileView = true
        }
    }
    
    
    var body: some View {
        VStack {
           
            HStack {
                NavigationLink(destination: self.headerCellViewModel.user != nil ? AnyView(UserProfileView(user: self.headerCellViewModel.user)) : AnyView(HomeView())) {
                    URLImage(URL(string: headerCellViewModel.post.avatar)!,
                             content: {
                                $0.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                             }).frame(width: 35, height: 35)
                    
                }.disabled(self.headerCellViewModel.user == nil && self.isProfileView)
                
                VStack(alignment: .leading) {
                    Text(headerCellViewModel.post.username).font(.subheadline).bold()
                    // Text("location").font(.caption)
                }
                
                    Spacer()
        
                if headerCellViewModel.post.ownerId == headerCellViewModel.uid {
                    Button(action: {done.toggle()},
                           label: {
                        Image(systemName: "checkmark.circle")
                    })
                   
                    Menu(content: {

                        Button(action: {Api.Post.deletePost(userId: headerCellViewModel.uid, postId: headerCellViewModel.post.postId)}) {

                            Text("Delete")
                        }

//                        Button(action: {}) {
//
//                            Text("Edit")
//                        }

                    }, label: {

                        Image(systemName: "ellipsis")
                
                    })
                }
                
                if headerCellViewModel.post.ownerId != headerCellViewModel.uid {
                Menu(content: {

                    Button(action: {Api.Post.hidePost(userId: headerCellViewModel.post.ownerId, postId: headerCellViewModel.post.postId)}) {

                        Text("Hide Post")
                    }
                    
                    Button(action: {reportScreen.toggle()}) {

                        Text("Report")
                    }


                    Button(action: {headerCellViewModel.blockUser()}) {

                        Text("Block")
                    }


                }, label: {

                    Image(systemName: "ellipsis")
            
                })
                }
               
                }.padding(.trailing, 15).padding(.leading, 15)
            
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text(headerCellViewModel.post.caption).font(.subheadline).padding(.bottom, 2).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
                    Text(timeAgoSinceDate(Date(timeIntervalSince1970: headerCellViewModel.post.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                }.padding(.horizontal).padding(.bottom, 2)
                Spacer(minLength: 0)
                if headerCellViewModel.post.mediaUrl != "" {
                    Button(action: {
                        withAnimation(.easeInOut){
                            ImageScreen.toggle()
                        }
                    }, label: {
                        URLImage(URL(string: headerCellViewModel.post.mediaUrl)!,
                              content: {
                                  $0.image
                                      .resizable()
                                      .aspectRatio(contentMode: .fill)
                              }).frame(width: 200, height: 250).cornerRadius(3).clipped()
                    })
                
                }
            }
           
        }.sheet(isPresented: $ImageScreen, content: {
            ImageView(headerCellViewModel: headerCellViewModel)
        })
//        .background(Color(.white)).cornerRadius(5).shadow(color: COLOR_LIGHT_GRAY, radius: 5, x: 0, y: 0)
         .sheet(isPresented: $reportScreen, content: {
            ReportInput(post: self.headerCellViewModel.post, postId: self.headerCellViewModel.post.postId)
        })
        .sheet(isPresented: $done, content: {
            DoneToggle(post: self.headerCellViewModel.post)
        })

    
    }
    

    
}



