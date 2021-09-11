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
    var user: User

    @EnvironmentObject var session: SessionStore
    @ObservedObject var userProfileViewModel = UserProfileViewModel()
    @StateObject var connectionsViewModel = ConnectionsViewModel()
  
    // state
    @State var isImageSheetOpen: Bool = false
  
  
  
  func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
    // If scrolling up, yOffset will be a negative number
    if maxHeight + yOffset < minHeight {
      // SCROLLING UP
      // Never go smaller than our minimum height
      return minHeight
    }
    
    // SCROLLING DOWN
    return maxHeight + yOffset
  }
  
  func openImageSheet() {
    self.isImageSheetOpen.toggle()
  }
  
  
  var body: some View {
      ScrollView(showsIndicators: false) {
        ZStack {
          GeometryReader { geometry in
              URLImageView(inputURL: user.profileImageUrl)
                .frame(
                  height: self.calculateHeight(
                    minHeight: 0,
                    maxHeight: 230,
                    yOffset: geometry.frame(in: .global).origin.y
                  )
                )
                .clipped()
                .offset(
                  y: geometry.frame(in: .global).origin.y < 0 // Is it going up?
                    ? abs(geometry.frame(in: .global).origin.y) // Push it down!
                    : -geometry.frame(in: .global).origin.y
                ) // Push it up!
                .blur(radius: 1)
          }
          .onTapGesture(perform: self.openImageSheet)
          .zIndex(0)
        
          
          VStack {
            URLImageView(inputURL: user.profileImageUrl)
                .clipShape(Circle())
                .frame(width: 150, height: 150)
                .padding(5)
                .background(Color.white)
                .cornerRadius(100)
            .onTapGesture(perform: self.openImageSheet)
            .zIndex(2)
            .offset(y: -80)
            VStack {
              // user name
              HStack {
                Button(action: {Api.User.updateField(field: "firstName", user: user ) }) {
                  Text(user.firstName ?? "").font(.title).bold().foregroundColor(Color("bw"))
                }
                
                Button(action: {Api.User.updateField(field: "lastName", user: user) }) {
                  Text(user.lastName ?? "").font(.title).bold().foregroundColor(Color("bw"))
                }
              }
              .frame(width: UIScreen.main.bounds.width)
              .background(
                Color.white
                 .cornerRadius(20, corners: [.topLeft, .topRight])
                 .padding(.top, -105)
               )
             
//              Text(user.bio ?? "")
//                .font(.subheadline)
//                .italic()

              Connections(
                user: user,
                connectionsCount: $userProfileViewModel.connectionsCountState
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
              }
              .frame(
                width: UIScreen.main.bounds.width
              )
              ProfileHeader(
                user: user,
                postCount: userProfileViewModel.posts.count,
                doneCount: userProfileViewModel.doneposts.count
              )
              
              .padding(
                EdgeInsets(top: 5, leading: 20, bottom: 10, trailing: 20)
              )
            }
            .padding(.top, -80)
            .background(Color.white)
            .frame(width: UIScreen.main.bounds.width)
            
            LazyVStack {
              ForEach(userProfileViewModel.posts.indices, id: \.self) { index in
                  AskCard(
                    post: userProfileViewModel.posts[index],
                    isProfileView: true,
                    index: index
                  )
                }
            }
          }
          .zIndex(1)
          .padding(.top, 230)
        }
      }
     
    .navigationBarTitle(Text(user.displayName ?? ""), displayMode: .inline)
    .onAppear {
      logToAmplitude(event: .viewOtherProfile)
      self.userProfileViewModel.checkUserBlocked(userId: Auth.auth().currentUser!.uid, postOwnerId: self.user.id ?? self.user.uid)
    }
    .background(
      Color.white.ignoresSafeArea(.all, edges: .all)
    )
    .sheet(
      isPresented: $connectionsViewModel.isConnectionsSheetOpen,
      content: {  ConnectionsView(user: user).environmentObject(connectionsViewModel) }
    )
    .environmentObject(connectionsViewModel)
    
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
              Text((self.isConnected) ? "Disconnect" : (self.sentPendingRequest) ? "Pending" : "Connect")
                  .font(.callout)
                  .foregroundColor(Color(.systemTeal))
                  .bold()
                  .lineLimit(1)
                  .padding(
                    .init(top: 10, leading: 30, bottom: 10, trailing: 30)
                  )
                  .cornerRadius(5)
                  .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(.systemTeal), lineWidth: 1))
              
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
                Image(systemName: "square.and.pencil")
                  .foregroundColor(Color(.white))
                Text("Message").foregroundColor(Color(.white)).font(.callout).bold().border(Color(.systemTeal)).lineLimit(1)
                }
              .padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                
            }
            .background(Color(.systemTeal))
            .cornerRadius(5)
        }
    }


