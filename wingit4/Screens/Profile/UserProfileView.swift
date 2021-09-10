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
    @StateObject var connectionsViewModel = ConnectionsViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 15){
                ScrollView {
                   VStack {
                    VStack{
                        ProfileInformation(user: user)
                        Connections(
                          user: user,
                          connectionsCount: $userProfileViewModel.connectionsCountState
                        )
                        ProfileHeader(
                          user: user,
                          postCount: userProfileViewModel.posts.count,
                          doneCount: userProfileViewModel.doneposts.count
                        )
                        HStack(spacing: 15) {
                          if userProfileViewModel.userBlocked == false {
                            ConnectButton(
                              user: user,
                              isConnected: $userProfileViewModel.isConnected, sentPendingRequest: $userProfileViewModel.sentPendingRequest,
                              connectionsCount: $userProfileViewModel.connectionsCountState
                            )
                            MessageButton(user: user)
                          }
                        }.padding(.leading, 20).padding(.trailing, 20)
                    }
                    .padding(.bottom, 10)
                    .background(Color(.white))
                    .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
                    
                    if !self.userProfileViewModel.posts.isEmpty {
                      ForEach(self.userProfileViewModel.posts.indices, id: \.self) { index in
                            LazyVStack {
                                AskCard(
                                  post: self.userProfileViewModel.posts[index],
                                  isProfileView: false,
                                  index: index
                                )
                            }
                       }
                    }
                       
                }
                                 
//                )}
               }
                .background(Color.black.opacity(0.03)
                .ignoresSafeArea(.all, edges: .all))
                .navigationBarTitle(Text(user.displayName ?? ""), displayMode: .automatic)
                .environmentObject(connectionsViewModel)
                 .onAppear {
                    logToAmplitude(event: .viewOtherProfile)
                    self.userProfileViewModel.checkUserBlocked(userId: Auth.auth().currentUser!.uid, postOwnerId: self.user.id ?? self.user.uid)
                 }
      
        
    }
}
    struct ConnectButton: View {

        @EnvironmentObject var connectionsViewModel: ConnectionsViewModel

        var user: User
        @Binding var connections_Count: Int
        @Binding var isConnected: Bool
        @Binding var sentPendingRequest: Bool

        init(user: User, isConnected: Binding<Bool>, sentPendingRequest: Binding<Bool>, connectionsCount: Binding<Int>) {
            self.user = user
            self._connections_Count = connectionsCount
            self._isConnected = isConnected
            self._sentPendingRequest = sentPendingRequest
        }
        
        func buttonTapped() {
            if !self.isConnected && !self.sentPendingRequest {
                    connectionsViewModel.sendConnectRequest(userId: user.id)
                    self.sentPendingRequest = true
                } else if self.isConnected {
                    connectionsViewModel.disconnect(userId: user.id,  connectionsCount_onSuccess: { (connectionsCount) in
                                 self.connections_Count = connectionsCount
                 })
                self.isConnected = false
            }
        }
        
        var body: some View {
            Button(action: buttonTapped) {
                Text((self.isConnected) ? "Disconnect" : (self.sentPendingRequest) ? "Pending" : "Connect").foregroundColor(Color("bw")).font(.callout).bold().padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30)).border(Color(.systemTeal)).lineLimit(1)
            }
        }
    }

    struct MessageButton: View {
        var user: User
        var body: some View {
            Button(action: {
                logToAmplitude(event: .tapMessageButton)
            }) {
            NavigationLink(destination: ChatView(recipientId: user.id ?? "", recipientAvatarUrl: user.profileImageUrl ?? "", recipientUsername: user.username ?? "")) {
                        Text("Message").foregroundColor(Color("bw")).font(.callout).bold().padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30)).border(Color(.systemTeal))
                   
                }
                
            }
        }
    }


}
