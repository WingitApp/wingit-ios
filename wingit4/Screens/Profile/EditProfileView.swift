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
  
  
//  func areEditsMade() -> Bool {
//    let currentUser = Auth.auth().currentUser
//
//  }
  
  
  func editProfile() {
//    if areEditsMade() {
      profileViewModel.editProfile() {
          let alertView = SPAlertView(title: "Profile Updated.", message: nil, preset: SPAlertIconPreset.done)
          alertView.present(duration: 1)
      }
//    } else {
//      // no edits were made
//    }
//
   }
   
  
  var body: some View {
      VStack{
          HStack{
              Button(action: {profileViewModel.isPresented.toggle()}){
              Text("Cancel").foregroundColor(.black)
          }
          Spacer()
          Text("Edit Profile").bold()
          Spacer()
          Button(action: {
              editProfile()
          }){
              Text("Done").bold()
          }
          }.padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
          Divider()
  //            VStack(alignment: .center, spacing: 15) {
  //
  //                ZStack {
  //                    UserAvatarSignup(
  //                        image: Image("user-placeholder"),
  //                      height: 65,
  //                      width: 65,
  //                      onTapGesture: {
  //
  //                      }
  //                    )
  //                    .zIndex(0)
  //                    Image(systemName: "plus.circle")
  //                      .font(.system(size: 12))
  //                      .foregroundColor(.white)
  //                      .padding(5)
  //                      .background(
  //                        LinearGradient(
  //                          gradient: Gradient(
  //                            colors: [Color("Color").lighter(by: 10), Color("Color")]),
  //                            startPoint: .top,
  //                            endPoint: .bottom
  //                          )
  //                      )
  //                      .cornerRadius(100)
  //                      .offset(x: 20, y: 20)
  //                      .frame(width: 20, height: 20)
  //                      .shadow(
  //                        color: Color.black.opacity(0.3),
  //                        radius: 1, x: 0, y: -1
  //                      )
  //                      .zIndex(1)
  //
  //                }
  //            }
          VStack(alignment: .leading, spacing: 12){
              
              HStack{
              VStack{
                  TextField("first", text: $profileViewModel.first)
              Divider()
                  }
              VStack{
                  TextField("last", text: $profileViewModel.last)
              Divider()
                  }
              }
              TextField("username", text: $profileViewModel.username)
              Divider()

              TextView("bio", text: $profileViewModel.bio)
              Divider().padding(.top)
         Spacer()
          }
          .padding(.horizontal,25)
          .padding(.top,25)

      }
      .background(
          Color.white.ignoresSafeArea(.all, edges: .all)
        )
  }
}


//struct EditProfileView_Previews: PreviewProvider {
//  static var previews: some View {
//      EditProfileView()
//  }
//}
