//
//  DoneCell.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/22/21.
//
//
//import SwiftUI
//import URLImage
//import FirebaseAuth
//
//struct DoneCell: View {
//
//    @ObservedObject var headerCellViewModel = HeaderCellViewModel()
//
//    @State var reportScreen: Bool = false
//    @State var ImageScreen: Bool = false
//   // @State var DoneScreen: Bool = false
//
//
//    init(donepost: DonePost) {
//        self.headerCellViewModel.donepost = donepost
//    }
//
//
//    var body: some View {
//        VStack {
//
//            HStack {
//
//                URLImage(URL(string: headerCellViewModel.donepost.avatar)!,
//                         content: {
//                            $0.image
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .clipShape(Circle())
//                         }).frame(width: 35, height: 35)
//
//                VStack(alignment: .leading) {
//                    Text(headerCellViewModel.donepost.username).font(.subheadline).bold()
//                    // Text("location").font(.caption)
//                }
//
//                    Spacer()
//
//                if headerCellViewModel.donepost.ownerId == headerCellViewModel.uid {
////                    Button(action: {DoneScreen.toggle()}, label: {
////                        Image(systemName: "checkmark.circle")
////                    })
//
//                    Menu(content: {
//
//                        Button(action: {Api.Post.deleteDonePost(userId: headerCellViewModel.uid, postId: headerCellViewModel.donepost.postId)}) {
//
//                            Text("Delete")
//                        }
//
////                        Button(action: {}) {
////
////                            Text("Edit")
////                        }
//
//                    }, label: {
//
//                        Image(systemName: "ellipsis")
//
//                    })
//                }
//
//                if headerCellViewModel.donepost.ownerId != headerCellViewModel.uid {
//                Menu(content: {
//
//
//                    Button(action: {reportScreen.toggle()}) {
//
//                        Text("Report")
//                    }
//
//
//                    Button(action: {headerCellViewModel.blockUserdone()}) {
//
//                        Text("Block")
//                    }
//
//
//                }, label: {
//
//                    Image(systemName: "ellipsis")
//
//                })
//                }
//
//                }.padding(.trailing, 15).padding(.leading, 15)
//
//            HStack{
//                VStack(alignment: .leading, spacing: 10){
//                    Text(headerCellViewModel.donepost.caption).font(.subheadline).padding(.bottom, 2).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
////                    Text(timeAgoSinceDate(Date(timeIntervalSince1970: headerCellViewModel.post.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
//                }.padding(.horizontal).padding(.bottom, 2)
//                Spacer(minLength: 0)
//                if headerCellViewModel.donepost.doneMediaUrl != "" {
//                    Button(action: {
//                        withAnimation(.easeInOut){
//                            ImageScreen.toggle()
//                        }
//                    }, label: {
//                        URLImage(URL(string: headerCellViewModel.donepost.doneMediaUrl)!,
//                              content: {
//                                  $0.image
//                                      .resizable()
//                                      .aspectRatio(contentMode: .fill)
//                              }).frame(width: 200, height: 250).cornerRadius(3).clipped()
//                    })
//
//                }
//            }
//
//        }.sheet(isPresented: $ImageScreen, content: {
//            ImageView(headerCellViewModel: headerCellViewModel)
//        })
//        .background(Color(.white)).cornerRadius(5).shadow(color: COLOR_LIGHT_GRAY, radius: 5, x: 0, y: 0)
//         .sheet(isPresented: $reportScreen, content: {
//            DoneReportInput(donepost: self.headerCellViewModel.donepost, postId: self.headerCellViewModel.donepost.postId)
//        })
////        .sheet(isPresented: $DoneScreen, content: {
////            DoneView(post: self.headerCellViewModel.post)
////        })
//
//    }
//}
//


