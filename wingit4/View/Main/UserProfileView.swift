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
        VStack(alignment: .leading, spacing: 15){
            Picker(selection: $selection, label: Text("Grid or Table")) {
                       ForEach(Selection.allCases) { selection in
                           selection.image.tag(selection)

                       }
            }
            .pickerStyle(SegmentedPickerStyle()).padding(.leading, 20).padding(.trailing, 20)
            .onChange(of: selection) { selection in
                if selection == .globe {
                    logToAmplitude(event: .viewOthersRecs)
                } else {
                    logToAmplitude(event: .viewOthersRequests)
                }
            }
                ScrollView {
                   VStack {
                    ProfileHeader(user: user, postCount: profileViewModel.posts.count, gemPostCount: profileViewModel.gemposts.count, doneCount: profileViewModel.doneposts.count, connectionsCount: $profileViewModel.connectionsCountState)

                    HStack(spacing: 15) {
                if !profileViewModel.userBlocked {
                    ConnectButton(user: user, isConnected: $profileViewModel.isConnected, hasPendingRequest: $profileViewModel.hasPendingRequest, connectionsCount: $profileViewModel.connectionsCountState)
                    MessageButton(user: user)
                    }
                    }.padding(.leading, 20).padding(.trailing, 20)
                    
                    Divider()
                    
                    if !profileViewModel.isLoading {
                                  if selection == .globe {
                                    ForEach(self.profileViewModel.gemposts, id: \.postId) { gempost in
                                        VStack {
                                            
                                            gemHeader(gempost: gempost, isProfileView: true)
                                           
                                        }
                                    }
                                 } else {
                                    ForEach(self.profileViewModel.posts, id: \.postId) { post in
                                        VStack {
                                            HeaderCell(
                                                post: post,
                                                isProfileView: true
                                            )
                                            FooterCell(post: post)
                                        }
                                   }

                                     
                                  }
                      
                    }
                       
                }
                                 
                }
               }.padding(.top, 10) .navigationBarTitle(Text(self.user.username), displayMode: .automatic)
                 .onAppear {
                    logToAmplitude(event: .viewOtherProfile)
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

struct ConnectButton: View {

    @ObservedObject var connectViewModel = ConnectViewModel()

    var user: User
    @Binding var connections_Count: Int
    @Binding var isConnected: Bool
    @Binding var hasPendingRequest: Bool

    init(user: User, isConnected: Binding<Bool>, hasPendingRequest: Binding<Bool>, connectionsCount: Binding<Int>) {
        self.user = user
        self._connections_Count = connectionsCount
        self._isConnected = isConnected
        self._hasPendingRequest = hasPendingRequest

    }
    
    func buttonTapped() {
        if !self.isConnected && !self.hasPendingRequest {
                connectViewModel.sendConnectRequest(userId: user.uid)
                self.hasPendingRequest = true
            } else if self.isConnected {
                connectViewModel.disconnect(userId: user.uid,  connectionsCount_onSuccess: { (connectionsCount) in
                             self.connections_Count = connectionsCount
             })
            self.isConnected = false
        }
    }
    
    var body: some View {
        Button(action: buttonTapped) {
            Text((self.isConnected) ? "Disconnect" : (self.hasPendingRequest) ? "Pending" : "Connect").foregroundColor(Color("bw")).font(.callout).bold().padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30)).border(Color(.systemTeal)).lineLimit(1)
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
