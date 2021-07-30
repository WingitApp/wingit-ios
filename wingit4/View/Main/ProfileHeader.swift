//
//  ProfileHeader.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import SwiftUI
import URLImage
struct ProfileHeader: View {
 //   @EnvironmentObject var session: SessionStore
    var user: User?
    var postCount: Int
    var gemPostCount: Int
    var doneCount: Int
    @Binding var followingCount: Int
    @Binding var followersCount: Int
    @State var done: Bool = false
    
    var body: some View {
        
            if user != nil {
                VStack(alignment:.center){
              
               
                 ProfileInformation(user: user)
                HStack{
                    NavigationLink(
                        destination: FollowerView(user: user!),
                        label: {
                            HStack {
                                Text("\(followersCount)").font(.caption).foregroundColor(.gray)
                                Text("Followers").font(.caption2).foregroundColor(.gray)
                            }.padding(.top, 5).padding(.trailing, 15)
                        })
                    NavigationLink(
                        destination: FollowingView(user: user!),
                        label: {
                            HStack {
                                Text("\(followingCount)").font(.caption).foregroundColor(.gray)
                                Text("Following").font(.caption2).foregroundColor(.gray)
                            }.padding(.top, 5).padding(.leading, 15)
                        })
                    }
                    HStack{
                    VStack {
                        Text("\(postCount)").font(.headline).foregroundColor(.black)
                        Text("Asks").font(.subheadline).foregroundColor(.gray)
                    }.padding(10)
                    NavigationLink(
                        destination: DoneView(user: user!),
                        label: {
                            VStack{
                            Text("\(doneCount)").font(.headline).foregroundColor(.black)
                            Text("Done").font(.subheadline).foregroundColor(.gray)
                            }.padding(10)
                        })
                    VStack {
                        Text("\(gemPostCount)").font(.headline).foregroundColor(.black)
                        Text("Recs").font(.subheadline).foregroundColor(.gray)
                    }.padding(10)
                    }
            
            }
                .sheet(isPresented: $done, content: {
                    DoneView(user: user!)
            })

        }
    }
}

//struct UserProfileHeader: View {
//   
//    var user: User?
//    var postCount: Int
//    var gemPostCount: Int
//    @Binding var followingCount: Int
//    @Binding var followersCount: Int
//    var body: some View {
//        
//        
//        if user != nil {
//            VStack(alignment:.center){
//          
//            URLImage(URL(string: user!.profileImageUrl)!,
//            content: {
//                $0.image
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .clipShape(Circle())
//            }).frame(width: 100, height: 100)
//             ProfileInformation(user: user)
//            HStack{
//                NavigationLink(
//                    destination: FollowerView(user: user!),
//                    label: {
//                        HStack {
//                            Text("\(followersCount)").font(.caption).foregroundColor(.gray)
//                            Text("Followers").font(.caption2).foregroundColor(.gray)
//                        }.padding(.top, 5).padding(.trailing, 15)
//                    })
//                NavigationLink(
//                    destination: FollowingView(user: user!),
//                    label: {
//                        HStack {
//                            Text("\(followingCount)").font(.caption).foregroundColor(.gray)
//                            Text("Following").font(.caption2).foregroundColor(.gray)
//                        }.padding(.top, 5).padding(.leading, 15)
//                    })
//                }
//                HStack{
//                VStack {
//                    Text("\(postCount)").font(.headline).foregroundColor(.black)
//                    Text("Asks").font(.subheadline).foregroundColor(.gray)
//                }.padding(10)
//                NavigationLink(
//                    destination: DoneView(),
//                    label: {
//                        VStack{
//                        Text("\(doneCount)").font(.headline).foregroundColor(.black)
//                        Text("Done").font(.subheadline).foregroundColor(.gray)
//                        }.padding(10)
//                    })
//                VStack {
//                    Text("\(gemPostCount)").font(.headline).foregroundColor(.black)
//                    Text("Recs").font(.subheadline).foregroundColor(.gray)
//                }.padding(10)
//                }
//        
//        }
//            .sheet(isPresented: $done, content: {
//            DoneView()
//        })
//
//    }
//
//        }
//    }
//}

//struct FollowingCount: View {
//
//
//    @Binding var followingCount: Int
//
//
//    var body: some View {
//
//
//        if followingCount == 0 {
//            Text("Follow your friends to get started~").foregroundColor(Color(.systemTeal))
//            }else {
//                Text("")
//            }
//    }
//}

//struct ProfileHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeader()
//    }
//}
