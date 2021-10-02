//
//  EditProfileView.swift
//  wingit4
//
//  Created by Joshua Lee on 9/30/21.
//

import SwiftUI
import SPAlert
import FirebaseAuth

struct EditProfileView: View {
  @EnvironmentObject var profileViewModel: ProfileViewModel
  @EnvironmentObject var session: SessionStore
  
  func areEditsMade() -> Bool {
    guard let currentUser = self.session.currentUser else { return false }
    let trimmedUserBio = profileViewModel.bio.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if trimmedUserBio != currentUser.bio {
      return true
    }
    return false
  }
  
  func editProfile() {
    if areEditsMade() {
      profileViewModel.editProfile() {
          let alertView = SPAlertView(title: "Profile Updated.", message: nil, preset: SPAlertIconPreset.done)
          alertView.present(duration: 1)
      }
    } else {
//      // no edits were made
    }
//
   }
  
  func closeEditProfileView() {
    profileViewModel.isEditSheetOpen = false
  }
   
  
  var body: some View {
      VStack{
        // header
        HStack {
          Spacer()
          Text("Edit Profile").bold()
          Spacer()
          Button(action: closeEditProfileView) {
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .padding(10)
          }
        }
        .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
        Divider()

        // user info summary
        HStack {
          Spacer()
          URLImageView(urlString: session.currentUser?.profileImageUrl)
            .frame(width: 150, height: 150)
            .cornerRadius(100)
            .padding(5)
          Spacer()
        }
        VStack(alignment: .leading, spacing: 5) {
          Text("Joshua Lee")
            .font(.title).bold().foregroundColor(Color.black)
        }
        .padding(.bottom, 15)
        
        
        HStack {
          VStack(alignment: .leading, spacing: 0) {
            Text("Username")
              .bold()
              .padding(.bottom, 10)
            Text("@joshlee93")
              .foregroundColor(Color.wingitBlue)
  //            .foregroundColor(Color.black.opacity(0.7))
              .padding(.bottom, 15)
          }
          Spacer()
        }
        .padding([.horizontal])

//            .bold()
//            .font(.subheadline)
//            .foregroundColor(Color.wingitBlue)
        VStack(alignment: .leading, spacing: 0) {

          Text("Your Bio")
            .bold()
            .padding(.bottom, 10)
          TextEditor(
            text: $profileViewModel.bio
          )
            .padding(15)
            .cornerRadius(8)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.borderGray, lineWidth: 1)
            )

        }
        .padding([.horizontal])
        
        Spacer()

      }
      .background(
          Color.white.ignoresSafeArea(.all, edges: .all)
        )
  }
}


struct EditProfileView_Previews: PreviewProvider {
  static var previews: some View {
      EditProfileView()
  }
}
