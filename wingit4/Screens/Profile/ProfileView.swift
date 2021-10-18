
//
//  ProfileView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import FirebaseAuth


struct ProfileView: View {
  @EnvironmentObject var session: SessionStore
  @EnvironmentObject var updatePhotoVM: UpdatePhotoVM

  @StateObject var userProfileViewModel: UserProfileViewModel
  @StateObject var connectionsViewModel = ConnectionsViewModel()

  @State var isOwnProfile: Bool
  var profileTab: Bool

  init (userId: String? = nil, user: User? = nil, profileTab: Bool = false) {
    var isOwnProfile: Bool {
      if userId == nil && user == nil {
        return true
      }
      
      if userId != nil && userId == Auth.auth().currentUser?.uid {
        return true
      }
      
      if user != nil && user?.id == Auth.auth().currentUser?.uid {
        return true
      }
      
      return false
    }
    
    switch(isOwnProfile) {
      case true:
        _isOwnProfile = State(initialValue: true)
        _userProfileViewModel = StateObject(
          wrappedValue: UserProfileViewModel(userId: nil, user: nil)
        )

      case false:
        _isOwnProfile = State(initialValue: false)
        _userProfileViewModel = StateObject(
          wrappedValue: UserProfileViewModel(userId: userId, user: user)
        )
    }
    
    self.profileTab = profileTab
  }



    func openUpdatePicSheet() {
      Haptic.impact(type: "soft")
      self.session.isUpdatePicSheetOpen.toggle()
    }
    
    func openPicSheet() {
      Haptic.impact(type: "soft")
      self.userProfileViewModel.isImageModalOpen.toggle()
    }
  
  
  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        VStack {
          VStack {
            ProfileParallax(
              user: isOwnProfile ? session.currentUser : userProfileViewModel.user
            )
          }
//          .frame(minHeight: (UIScreen.main.bounds.height / 3.5)) // ios 15
           .onTapGesture(perform: isOwnProfile ? self.openUpdatePicSheet : self.openPicSheet)
            VStack(alignment: .leading) {
              HStack(alignment: .bottom) {
                HStack {
                  URLImageView(urlString: isOwnProfile
                     ? session.currentUser?.profileImageUrl
                     : userProfileViewModel.user.profileImageUrl
                  )
                    .frame(width: 120, height: 120)
                    .cornerRadius(100)
                    .padding(5)
                }
                .background(Color.white)
                .cornerRadius(100)
                .onTapGesture(perform: isOwnProfile ? self.openUpdatePicSheet : self.openPicSheet)
                .zIndex(2)
                Spacer()
                ProfileButton(
                  user: isOwnProfile ? session.currentUser : userProfileViewModel.user,
                  isOwnProfile: isOwnProfile
                )
                .offset(y: -20)
                  
              }
              .offset(y: -64)
              .padding(.bottom, -70)
              .padding(.leading, 15)
              .padding(.trailing, 15)
              .frame(
                width: UIScreen.main.bounds.width
              )
              
            ProfileUserHeader(
              user: isOwnProfile ? session.currentUser : userProfileViewModel.user,
              isOwnProfile: isOwnProfile
            )
            .environmentObject(connectionsViewModel)
              .padding(.leading, 15)
            ProfileDetailView(
              user: isOwnProfile ? session.currentUser : userProfileViewModel.user,
              isOwnProfile: isOwnProfile
            )
            }

          .frame( width: UIScreen.main.bounds.width)
          .background(
            Color.white
            .cornerRadius(30, corners: .topLeft)
            .cornerRadius(30, corners: .topRight)
          )
          .offset(y: -30)
          .padding(.top, -30)
          .redacted(reason: userProfileViewModel.isLoadingUser ? .placeholder : [])
        }
        
      }
      .environmentObject(userProfileViewModel)
      .environmentObject(connectionsViewModel)
      .environmentObject(updatePhotoVM)
      .navigationBarTitle("", displayMode: .inline)
      .navigationBarHidden(!profileTab)
        .navigationBarItems(
          leading:
              Button(action: {}) {
                if isOwnProfile {
                  NavigationLink(destination: UsersView()) {
                    Image(systemName: "magnifyingglass")
                      .imageScale(Image.Scale.medium)
                      .foregroundColor(Color.black)
                  }
                }
          },
          trailing:
            Button(action: {}) {
              if isOwnProfile {
                NavigationLink(destination: SettingsView().environmentObject(session)) {
                  Image(systemName: "gearshape.fill")
                    .imageScale(Image.Scale.medium)
                    .foregroundColor(Color.black)
                }
              }
        })
//              Button(action: {
//                if isOwnProfile {
//                  self.session.logout()
//                }
//              }) {
//                if isOwnProfile {
//                  Text("Logout")
//                    .font(.subheadline)
//                    .foregroundColor(Color.black)
//                  Image(systemName: "arrow.right.circle")
//                    .imageScale(Image.Scale.medium)
//                    .foregroundColor(Color.black)
//                }
//            })
      }
      .switchStyle(if: UIDevice.current.userInterfaceIdiom == .phone)
      .edgesIgnoringSafeArea(.top)
      .onAppear {
        if !isOwnProfile {
          if session.isLoggedIn {
            logToAmplitude(event: .viewOtherUsersProfile, properties: [.userId: userProfileViewModel.user.id])
          }
          self.userProfileViewModel.checkUserBlocked(
            userId: Auth.auth().currentUser?.uid ?? "",
            postOwnerId: self.userProfileViewModel.user.id ?? self.userProfileViewModel.user.uid
          )
        } else {
          if session.isLoggedIn {
            logToAmplitude(event: .viewOwnProfile)
          }
        }
      }
      .sheet(
           isPresented: $userProfileViewModel.isImageModalOpen,
           content: {
               profileImageView().environmentObject(userProfileViewModel)
         })
      .modifier(Popup(
        isPresented: session.isUpdatePicSheetOpen,
        alignment: .center,
        direction: .bottom,
        content: {
          UpdateProfilePhoto(user: session.currentUser)
            .environmentObject(updatePhotoVM)
        }))
    .modifier(Popup(
      isPresented: session.isEditSheetOpen,
      alignment: .center,
      direction: .bottom,
      content: {
        EditProfileView(bio: session.currentUser?.bio ?? "")
        .environmentObject(updatePhotoVM)
      }))
  }
}
