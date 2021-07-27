//
//  UserProfileView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import SwiftUI
import FirebaseAuth

struct UserProfileView: View {
   
    var user: User

    @ObservedObject var profileViewModel = ProfileViewModel()
    @State var selection: Selection = .globe
    
//    func usertoPost(){
//        if self.user.uid == self.profileViewModel.post.ownerId {
//            let user = Post
//        }
//    }

    var body: some View {
            
                ScrollView {
                   VStack(alignment: .leading, spacing: 15) {
                    
                      Picker(selection: $selection, label: Text("Grid or Table")) {
                                 ForEach(Selection.allCases) { selection in
                                     selection.image.tag(selection)

                                 }
                      }.pickerStyle(SegmentedPickerStyle()).padding(.leading, 20).padding(.trailing, 20)
                    
                    
                    UserProfileHeader(user: user, postCount: profileViewModel.posts.count, gemPostCount: profileViewModel.gemposts.count, followingCount: $profileViewModel.followingCountState, followersCount: $profileViewModel.followersCountState)

                    HStack(spacing: 15) {
                if profileViewModel.userBlocked == false {
                    FollowButton(user: user, isFollowing: $profileViewModel.isFollowing, followingCount: $profileViewModel.followingCountState, followersCount: $profileViewModel.followersCountState)
                    MessageButton(user: user)
                    }
                    }.padding(.leading, 20).padding(.trailing, 20)
                    
                    Divider()
                    
                    if !profileViewModel.isLoading {
                                  if selection == .globe {
                                    ForEach(self.profileViewModel.gemposts, id: \.postId) { gempost in
                                        VStack {
                                            
                                           gemHeader(gempost: gempost)
                                           
                                        }
                                    }
                                 } else {
                                   
                                    ForEach(self.profileViewModel.posts, id: \.postId) { post in
                                        VStack {
                                          HeaderCell(post: post)
                                          FooterCell(post: post)
                                        }
                                   }

                                     
                                  }
                      
                    }
                       
                }.padding(.top, 10)
                                 
                }.navigationBarTitle(Text(self.user.username), displayMode: .automatic)
                 .onAppear {
                    self.profileViewModel.checkUserBlocked(userId: Auth.auth().currentUser!.uid, postOwnerId: self.user.uid)
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
    //    updateFollowCount()
       // checkFollowState()
        
 
       

//        self.followersCount = followViewModel.followersCount
//        self.followingCount =  followViewModel.followingCount
    }
    
//    func checkFollowState() {
//        followViewModel.checkFollow(userId: self.user.uid)
//    }
    
    
//    func updateFollowCount() {
//        followViewModel.updateFollowCount(userId: user.uid, followingCount_onSuccess: { (following_Count) in
//            self.following_Count = following_Count
//        }) { (followers_Count) in
//            self.followers_Count = followers_Count
//        }
//    }
//

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
     
            Text((self.isFollowing) ? "Unfollow" : "Follow").foregroundColor(Color(.darkGray)).font(.caption)
            
            Image(systemName: (self.isFollowing) ? "person.badge.minus" : "person.fill.badge.plus").foregroundColor(Color(.gray))
   
        }
    }
}

struct MessageButton: View {
    var user: User
    var body: some View {
        Button(action: {}) {
                NavigationLink(destination: ChatView(recipientId: user.uid, recipientAvatarUrl: user.profileImageUrl, recipientUsername: user.username)) {
                    Image(systemName: "message").foregroundColor(Color(.systemTeal))
               
            }
            
        }
    }
}
