//
//  UserProfileView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import SwiftUI
import FirebaseAuth
import URLImage

struct UserProfileView: View {
   
    var user: User

    @ObservedObject var userProfileViewModel = UserProfileViewModel()
    

    var body: some View {
        VStack(alignment: .leading, spacing: 15){
                ScrollView {
                   VStack {
                      ProfileInformation(user: user)
                      Connections(
                        user: user,
                        followingCount: $userProfileViewModel.followingCountState,
                        followersCount: $userProfileViewModel.followersCountState
                      )
                      ProfileHeader(
                        user: user,
                        postCount: userProfileViewModel.posts.count,
                        doneCount: userProfileViewModel.doneposts.count
                      )
                      HStack(spacing: 15) {
                        if userProfileViewModel.userBlocked == false {
                          FollowButton(
                            user: user,
                            isFollowing: $userProfileViewModel.isFollowing,
                            followingCount: $userProfileViewModel.followingCountState,
                            followersCount: $userProfileViewModel.followersCountState
                          )
                          MessageButton(user: user)
                        }
                      }.padding(.leading, 20).padding(.trailing, 20)
                    
                    Divider()
                    if !self.userProfileViewModel.posts.isEmpty {
                        ForEach(self.userProfileViewModel.posts, id: \.postId) { post in
                            LazyVStack {
                                AskCard(post: post, isProfileView: false)
                            }
                       }
                    }
                       
                }
                                 
                }
               }.background(Color.black.opacity(0.03)
                .ignoresSafeArea(.all, edges: .all))
                .padding(.top, 10) .navigationBarTitle(Text(self.user.username), displayMode: .automatic)
                 .onAppear {
                    logToAmplitude(event: .viewOtherProfile)
                    self.userProfileViewModel.checkUserBlocked(userId: Auth.auth().currentUser!.uid, postOwnerId: self.user.uid)

                 }
      
        
    }
}

//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//    }
//}

struct FollowButton: View {

    @ObservedObject var followViewModel = FollowViewModel()

    var user: User
    @Binding var following_Count: Int
    @Binding var followers_Count: Int
    @Binding var isFollowing: Bool

    init(user: User, isFollowing: Binding<Bool>, followingCount: Binding<Int>, followersCount: Binding<Int>) {
        self.user = user
        self._following_Count = followingCount
        self._followers_Count = followersCount
        self._isFollowing = isFollowing

    }
    

    func follow() {
        if !self.isFollowing {
            followViewModel.follow(userId: user.uid,  followingCount_onSuccess: { (followingCount) in
                       self.following_Count = followingCount
       }) { (followersCount) in
           self.followers_Count = followersCount
            }
            self.isFollowing = true

        } else {
            followViewModel.unfollow(userId: user.uid,  followingCount_onSuccess: { (followingCount) in
                             self.following_Count = followingCount
             }) { (followersCount) in
                 self.followers_Count = followersCount
                  }
            self.isFollowing = false
        }
    }
    
    
    var body: some View {
        Button(action: follow) {
     
            Text((self.isFollowing) ? "Unfollow" : "Follow").foregroundColor(Color("bw")).font(.callout).bold().padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30)).border(Color(.systemTeal))
   
        }
    }
}

struct MessageButton: View {
    var user: User
    var body: some View {
        Button(action: {
            logToAmplitude(event: .tapMessageButton)
        }) {
                NavigationLink(destination: ChatView(recipientId: user.uid, recipientAvatarUrl: user.profileImageUrl, recipientUsername: user.username)) {
                    Text("Message").foregroundColor(Color("bw")).font(.callout).bold().padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30)).border(Color(.systemTeal))
               
            }
            
        }
    }
}
