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
    @Binding var followingCount: Int
    @Binding var followersCount: Int
    var body: some View {
        
        
            if user != nil {
                HStack {
                    VStack{
                URLImage(URL(string: user!.profileImageUrl)!,
                content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                }).frame(width: 100, height: 100).padding(.leading, 20)
                     //   EditProfileButton().padding(.leading, 20)
                }
                    VStack{
                        ProfileInformation(user: user)
                    }
                
                }
                
                VStack(alignment: .leading){
//                    Text("quote").foregroundColor(.secondary).font(.body)
//                        .padding(.leading, 20).padding(.bottom, 10)
                    VStack(alignment: .leading){
                    HStack {
                        Text("\(postCount)").font(.caption).foregroundColor(.gray)
                        Text("Asks").font(.caption2).foregroundColor(.gray)
                        Text("|").padding(.horizontal).foregroundColor(.gray)
                        Text("\(gemPostCount)").font(.caption).foregroundColor(.gray)
                        Text("Recommendations").font(.caption2).foregroundColor(.gray)
                    }.padding(.leading, 20).padding(.bottom, 5)
                        
                
                    HStack{
                        NavigationLink(
                            destination: FollowerView(user: user!),
                            label: {
                                HStack {
                                    Text("\(followersCount)").font(.caption).foregroundColor(.gray)
                                    Text("Followers").font(.caption2).foregroundColor(.gray)
                                }.padding(.leading, 20)
                            })
                        NavigationLink(
                            destination: FollowingView(user: user!),
                            label: {
                                HStack {
                                    Text("\(followingCount)").font(.caption).foregroundColor(.gray)
                                    Text("Following").font(.caption2).foregroundColor(.gray)
                                }.padding(.leading, 5)
                            })
                    
                }
                }
            }
        }
    }
}

struct UserProfileHeader: View {
   
    var user: User?
    var postCount: Int
    var gemPostCount: Int
    @Binding var followingCount: Int
    @Binding var followersCount: Int
    var body: some View {
        
        
            if user != nil {
                HStack {
                URLImage(URL(string: user!.profileImageUrl)!,
                content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                }).frame(width: 100, height: 100).padding(.leading, 20)
                
                    VStack{
                        ProfileInformation(user: user)
                    }
                
                }
                
                VStack(alignment: .leading){
//                    Text("quote").foregroundColor(.secondary).font(.body)
//                        .padding(.leading, 20).padding(.bottom, 10)
                    VStack(alignment: .leading){
                        HStack {
                            Text("\(postCount)").font(.caption).foregroundColor(.gray)
                            Text("Asks").font(.caption2).foregroundColor(.gray)
                            Text("|").padding(.horizontal).foregroundColor(.gray)
                            Text("\(gemPostCount)").font(.caption).foregroundColor(.gray)
                            Text("Recommendations").font(.caption2).foregroundColor(.gray)
                        }.padding(.leading, 20).padding(.bottom, 5)
                    
                    HStack{
                    
                        NavigationLink(
                            destination: FollowerView(user: user!),
                            label: {
                                HStack {
                                    Text("\(followersCount)").font(.caption).foregroundColor(.gray)
                                    Text("Followers").font(.caption2).foregroundColor(.gray)
                                }.padding(.leading, 20)
                            })

                        NavigationLink(
                            destination: FollowingView(user: user!),
                            label: {
                                HStack {
                                    Text("\(followingCount)").font(.caption).foregroundColor(.gray)
                                    Text("Following").font(.caption2).foregroundColor(.gray)
                                }.padding(.leading, 5)
                            })
                }
                }
            }
        }
    }
}

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
