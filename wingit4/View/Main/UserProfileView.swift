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

    @StateObject var profileViewModel = ProfileViewModel()
    @State var selection: Selection = .globe

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
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
                ConnectButton(user: user)
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
                .environmentObject(profileViewModel)
    }
}

struct ConnectButton: View {

    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    var user: User

    init(user: User) {
        self.user = user
    }
    
    func buttonTapped() {
        if !profileViewModel.isConnected && !profileViewModel.hasPendingRequest {
                connectionsViewModel.sendConnectRequest(userId: user.uid)
                profileViewModel.hasPendingRequest = true
            } else if profileViewModel.isConnected {
                connectionsViewModel.disconnect(userId: user.uid,  connectionsCount_onSuccess: { (connectionsCount) in
                             connectionsViewModel.connectionsCount = connectionsCount
             })
            profileViewModel.isConnected = false
        }
    }
    
    var body: some View {
        Button(action: buttonTapped) {
            Text((profileViewModel.isConnected) ? "Disconnect" : (profileViewModel.hasPendingRequest) ? "Pending" : "Connect").foregroundColor(Color("bw")).font(.callout).bold().padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30)).border(Color(.systemTeal)).lineLimit(1)
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
