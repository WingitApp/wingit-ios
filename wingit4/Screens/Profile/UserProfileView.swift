//
//  UserProfileView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import SwiftUI
import FirebaseAuth
import URLImage


//TODO: Refacor and reorganize

struct UserProfileView: View {
    // props
    @EnvironmentObject var session: SessionStore
    @ObservedObject var userProfileViewModel = UserProfileViewModel()
    @StateObject var connectionsViewModel = ConnectionsViewModel()
  
    // state
   // @State var isImageSheetOpen: Bool = false
  
  init (userId: String?, user: User? ) {
    if user == nil {
      userProfileViewModel.fetchUserFromId(userId: userId!)
    } else {
      userProfileViewModel.user = user!
    }
  }
  
  func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
    if maxHeight + yOffset < minHeight {
      return minHeight
    }
    return maxHeight + yOffset
  }
  
//  func openImageSheet() {
//    self.isImageSheetOpen.toggle()
//  }
    
    func openPicSheet() {
        self.userProfileViewModel.isImageModalOpen.toggle()
    }
  
  
  var body: some View {
    
      ScrollView(showsIndicators: false) {
        ZStack {
          GeometryReader { geometry in
            URLImageView(urlString: userProfileViewModel.user.profileImageUrl)
                .frame(
                  height: self.calculateHeight(
                    minHeight: 0,
                    maxHeight: 230,
                    yOffset: geometry.frame(in: .global).origin.y
                  )
                )
                .clipped()
                .offset(
                  y: geometry.frame(in: .global).origin.y < 0
                    ? abs(geometry.frame(in: .global).origin.y)
                    : -geometry.frame(in: .global).origin.y
                )
                .blur(radius: 1)
          }
          .onTapGesture(perform: self.openPicSheet)
       //   .onTapGesture(perform: self.openImageSheet)
          .zIndex(0)
        
          
          VStack {
            HStack {
              URLImageView(urlString: userProfileViewModel.user.profileImageUrl)
                .frame(width: 150, height: 150)
                .cornerRadius(100)
                .padding(5)
            }
            .background(Color.white)
            .cornerRadius(100)
            .onTapGesture(perform: self.openPicSheet)
          //  .onTapGesture(perform: self.openImageSheet)
            .zIndex(2)
            .offset(y: -80)
            
            VStack {
              // user name
              HStack {
               
                Text(userProfileViewModel.user.firstName ?? "").font(.title).bold().foregroundColor(Color.black)
                
                Text(userProfileViewModel.user.lastName ?? "").font(.title).bold().foregroundColor(Color.black)
                
              }
              .frame(width: UIScreen.main.bounds.width)
              .background(
                Color.white
                 .cornerRadius(20, corners: [.topLeft, .topRight])
                 .padding(.top, -105)
               )
              .redacted(reason: self.userProfileViewModel.isLoadingUser ? .placeholder : [])
             
//              Text(user.bio ?? "")
//                .font(.subheadline)
//                .italic()

              Connections(
                user: userProfileViewModel.user,
                connectionsCount: $userProfileViewModel.connectionsCountState
              ).redacted(reason: self.userProfileViewModel.isLoadingUser ? .placeholder : [])
              
              HStack(spacing: 15) {
                if userProfileViewModel.userBlocked == false && userProfileViewModel.user.uid != Auth.auth().currentUser?.uid {
                  ConnectButton(
                    user: userProfileViewModel.user,
                    isConnected: $userProfileViewModel.isConnected, sentPendingRequest: $userProfileViewModel.sentPendingRequest,
                    connectionsCount: $userProfileViewModel.connectionsCountState
                  )
                 // MessageButton(user: userProfileViewModel.user)

                }
              }
              .frame(
                width: UIScreen.main.bounds.width
              )
              .redacted(reason: self.userProfileViewModel.isLoadingUser ? .placeholder : [])
              .padding(.top, 5)
              UserProfileHeader(
                user: userProfileViewModel.user,
                openCount: userProfileViewModel.openPosts.count,
                closedCount: userProfileViewModel.closedPosts.count
              )
              .redacted(reason: self.userProfileViewModel.isLoadingUser ? .placeholder : [])
              .padding(
                EdgeInsets(top: 5, leading: 20, bottom: 10, trailing: 20)
              )
            }
            .padding(.top, -80)
            .background(Color.white)
            .frame(width: UIScreen.main.bounds.width)
            .zIndex(1)
            
            if userProfileViewModel.showOpenPosts {
                if !userProfileViewModel.isLoading && userProfileViewModel.openPosts.count == 0 {
                    if userProfileViewModel.closedPosts.count == 0 {
                        EmptyState(
                          title: "Hm nothing was found...",
                          description: "\(userProfileViewModel.user.displayName!) has no posts.",
                          iconName: "magnifyingglass",
                          iconColor: Color(.systemBlue),
                          function: nil
                        )
                    } else {
                        EmptyState(
                          title: "Hm nothing was found...",
                          description: "\(userProfileViewModel.user.displayName!) has no open posts.",
                          iconName: "checkmark",
                          iconColor: Color("Color1"),
                          function: nil
                        )
                      }
                } else {
                    LazyVStack {
                      ForEach(Array(userProfileViewModel.openPosts.enumerated()), id: \.element) { index, post in
                          AskCard(
                            post: post,
                            isProfileView: true,
                            index: index
                          )
                        }
                    }
                }
            } else {
                if !userProfileViewModel.isLoading && userProfileViewModel.closedPosts.count == 0 {
                    EmptyState(
                      title: "Hm nothing was found...",
                      description: "\(userProfileViewModel.user.displayName!) has no closed posts.",
                      iconName: "magnifyingglass",
                      iconColor: Color(.systemBlue),
                      function: nil
                    )
                } else {
                    LazyVStack {
                      ForEach(Array(userProfileViewModel.closedPosts.enumerated()), id: \.element) { index, post in
                          AskCard(
                            post: post,
                            isProfileView: true,
                            index: index
                          )
                        }
                    }.onAppear {
                        logToAmplitude(event: .viewOtherProfile)
                        self.userProfileViewModel.checkUserBlocked(userId: Auth.auth().currentUser!.uid, postOwnerId: self.userProfileViewModel.user.id ?? self.userProfileViewModel.user.uid)
                      }
            }

          }
        
        }
          .zIndex(1)
          .padding(.top, 230)
      }
      }

    .navigationBarTitle(Text(userProfileViewModel.user.displayName ?? ""), displayMode: .inline)
    .onAppear {
      logToAmplitude(event: .viewOtherProfile)
      self.userProfileViewModel.checkUserBlocked(userId: Auth.auth().currentUser!.uid, postOwnerId: self.userProfileViewModel.user.id ?? self.userProfileViewModel.user.uid)
    }
    .background(
      Color.white.ignoresSafeArea(.all, edges: .all)
    )
    .sheet(
      isPresented: $connectionsViewModel.isConnectionsSheetOpen,
      content: {  ConnectionsView(user: userProfileViewModel.user).environmentObject(connectionsViewModel)
      }
    )
      .sheet(
        isPresented: $userProfileViewModel.isImageModalOpen,
        content: {
          profileImageView(userProfileViewModel: userProfileViewModel)
      })
      
    .environmentObject(connectionsViewModel)
    .environmentObject(userProfileViewModel)
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
                self.sentPendingRequest = true
                logToAmplitude(event: .sendConnectRequest, properties: [.userId: user.id])
                    connectionsViewModel.sendConnectRequest(userId: user.id)
                } else if self.isConnected {
                    logToAmplitude(event: .disconnectFromUser, properties: [.userId: user.id])
                    connectionsViewModel.disconnect(userId: user.id,  connectionsCount_onSuccess: { (connectionsCount) in
                                 self.connections_Count = connectionsCount
                 })
                self.isConnected = false
            }
        }
        
        var body: some View {
            Button(action: buttonTapped) {
              Image(systemName: (self.isConnected ? "person.badge.minus.fill" : "link"))
              Text((self.isConnected) ? "Disconnect" : (self.sentPendingRequest) ? "Pending" : "Connect")
                  .font(.callout)
                  .bold()
            }
            .disabled(self.sentPendingRequest)
            .frame(
              width: (UIScreen.main.bounds.width / 2) - 30
            )
            .padding(
              .init(top: 10, leading: 0, bottom: 10, trailing: 0)
            )
            .background(Color.lightGray)
            .foregroundColor(Color.black)
            .cornerRadius(5)
            .overlay(
              RoundedRectangle(cornerRadius: 5).stroke(Color(.lightGray),
              lineWidth: 1)
            )
        
        }
    }

    struct MessageButton: View {
        var user: User
        var body: some View {
            Button(action: {
                logToAmplitude(event: .tapMessageButton)
            }) {
            NavigationLink(destination: ChatView(recipientId: user.id ?? "", recipientAvatarUrl: user.profileImageUrl ?? "", recipientUsername: user.username ?? "")) {
                Image(systemName: "square.and.pencil")
                  .foregroundColor(Color(.white))
                Text("Message").foregroundColor(Color(.white)).font(.callout).bold().border(Color(.systemTeal)).lineLimit(1)
                }
              .frame(
                width: (UIScreen.main.bounds.width / 2) - 30
              )
              .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                
            }
            .background(Color(.systemTeal))
            .cornerRadius(5)
            .overlay(
              RoundedRectangle(cornerRadius: 5).stroke(Color(.lightGray),
              lineWidth: 1)
            )
        }
    }


