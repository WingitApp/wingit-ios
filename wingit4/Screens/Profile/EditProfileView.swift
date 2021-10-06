//
//  EditProfileView.swift
//  wingit4
//
//  Created by Joshua Lee on 9/30/21.
//

import SwiftUI
import SPAlert
import FirebaseAuth
import Combine


struct EditProfileView: View, KeyboardReadable {
  @EnvironmentObject var profileViewModel: ProfileViewModel
  @EnvironmentObject var session: SessionStore
  @EnvironmentObject var updatePhotoVM: UpdatePhotoVM

  var originalBio: String
  @State private var bioText: String
  @State private var isTextEditorOpen: Bool = false
  @State private var isEditingImage: Bool = false
  
  let textLimit = 200
  
  init(bio: String) {
    self.originalBio = bio
    _bioText = State(initialValue: bio)
  }
  
  func areEditsMade() -> Bool {
    let prevUserBio = originalBio.trimmingCharacters(in: .whitespacesAndNewlines)
    let newUserBio = bioText.trimmingCharacters(in: .whitespacesAndNewlines)
    
    return prevUserBio != newUserBio
  }
  
  func onSave() {
      profileViewModel.editProfile(bio: bioText) {
        session.currentUser?.bio = bioText
        let alertView = SPAlertView(title: "Bio Updated.", message: nil, preset: SPAlertIconPreset.done)
        alertView.present(duration: 1)
        self.closeEditProfileView()
      }
   }
  
  func closeEditProfileView() {
    profileViewModel.isEditSheetOpen = false
  }
  
  func updateProfilePhoto() {
//    self.profileViewModel.isUpdatePicSheetOpen = true
    //ios14 fix
    withAnimation {
      isEditingImage = true
    }
  }
  
  func limitText(_ upper: Int) {
         if bioText.count > upper {
             bioText = String(bioText.prefix(upper))
         }
     }
   
  
  var body: some View {
      VStack{
        if isEditingImage {
          UpdateProfilePhoto(
            user: session.currentUser,
            onClose: {
              withAnimation {
                self.isEditingImage = false
              }
            }
          )
        } else {
          HStack {
            Button(action: closeEditProfileView) {
              Image(systemName: "xmark")
                  .foregroundColor(.gray)
                  .padding(10)
            }
            .opacity(0)
            .zIndex(-1)
            Spacer()
            Text("Edit Profile").bold()
            Spacer()
            CloseButton(onTap: closeEditProfileView)
              .padding(10)
          }
          .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
          Divider()
          
          
          if !isTextEditorOpen {
            HStack {
              Spacer()
                ZStack {
                  URLImageView(urlString: session.currentUser?.profileImageUrl)
                    .frame(width: 150, height: 150)
                    .cornerRadius(100)
                    .padding(5)
                    .zIndex(0)
                    .onTapGesture(perform: updateProfilePhoto)
                  
                  Text(
                    Image(systemName: "pencil")
                  )
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .cornerRadius(100)
                    .background(
                      LinearGradient(
                        gradient: Gradient(
                          colors: [Color.wingitBlue.lighter(by: 10), Color.wingitBlue]),
                          startPoint: .top,
                          endPoint: .bottom
                        )
                    )
                    .cornerRadius(100)
                    .offset(x: 60, y: 40)
                    .shadow(
                      color: Color.black.opacity(0.3),
                      radius: 1, x: 0, y: -1
                    )
                    .zIndex(1)
                    .onTapGesture(perform: updateProfilePhoto)

              }
              Spacer()
            }
            VStack(alignment: .leading, spacing: 5) {
              Text(session.currentUser?.displayName! ?? "")
                .font(.title).bold().foregroundColor(Color.black)
            }
            .padding(.bottom, 15)
            
            
            HStack {
              VStack(alignment: .leading, spacing: 0) {
                Text("Username")
                  .bold()
                  .padding(.bottom, 10)
                Text(session.currentUser?.username ?? "")
                  .foregroundColor(Color.wingitBlue)
      //            .foregroundColor(Color.black.opacity(0.7))
                  .padding(.bottom, 15)
              }
              Spacer()
            }
            .padding([.horizontal])
          }
          
          VStack(alignment: .leading, spacing: 0) {
            HStack {
              Text("Your Bio")
                .bold()
                .padding(.bottom, 10)
              Spacer()
              VStack(alignment: .trailing, spacing: 0){
                Text(
                  "\(bioText.count) / 200 chars"
                )
                  .font(.caption)
              }
              .padding(.trailing, 5)
              
              
            }
       
            TextEditor(
              text: $bioText
            )
              .onReceive(Just(bioText)) { _ in limitText(textLimit) }
              .padding(15)
              .cornerRadius(8)
              .overlay(
                RoundedRectangle(cornerRadius: 8)
                  .stroke(Color.borderGray, lineWidth: 1)
              )

          }
          .padding([.horizontal])
          
          Spacer()
          HStack {
            Button(action: onSave) {
              Text("Save")
                .fontWeight(.semibold)
                .frame(
                  width: UIScreen.main.bounds.width - 30,
                  height: 50
                )
                .foregroundColor(Color.white)
                .background(Color.wingitBlue)
                .cornerRadius(5)
            }
            .disabled(!areEditsMade())
            .opacity(areEditsMade() ? 1 : 0.6)
          }
          .padding(.top, 15)
          .padding(.bottom, 15)
        }

      }
      .environmentObject(updatePhotoVM)
      .background(
        Color.white.ignoresSafeArea(.all, edges: .all)
      )
      .onReceive(keyboardPublisher) { isKeyboardVisible in
        isTextEditorOpen = isKeyboardVisible
     }
      .onTapGesture {
        dismissKeyboard()
      }
  }
}
