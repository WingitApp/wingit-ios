//
//  ReferConnections.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI
import Firebase
import URLImage
import SPAlert


struct ReferConnectionsList: View {
    @EnvironmentObject var referViewModel: ReferViewModel
    @Binding var post: Post?
    @State var isContactsOpen: Bool = false
  var referral: Referral?

  //  var postId: String
  
    func onSend() {
      Haptic.impact(type: "medium")
      if let ref = referral {
        logToAmplitude(
          event: .rewingReferral,
          properties: [.askId : ref.askId]
        )
        referViewModel.rewingReferral(
          askId: ref.askId,
          parentId: ref.id
        )
      } else {
        referViewModel.sendReferrals(
          askId: post?.postId
        )
      }
    }
  
    func onAppearLoadConnectionsList() {
      referViewModel.resetToInitialState()
      referViewModel.loadConnections(post: post)
    }
  
  func openPhoneContactList() {
    logToAmplitude(
        event: .tapInviteContacts,
        properties: [.screen: "Refer Connections"]
    )
    Haptic.impact(type: "soft")
    isContactsOpen.toggle()
  }
    
  

    var body: some View {
      NavigationView {
        VStack {
          
          NavigationLink(destination: ContactsListView(), isActive: $isContactsOpen) { EmptyView() }.hidden()
             Capsule()
              .fill(Color.gray)
              .frame(width: 60, height: 4)
              .padding(.top, 15)
             Spacer()
             VStack(alignment: .leading, spacing: 0){
                   HStack{
                       Text("Choose friends who can help")
                           .font(.title3)
                           .fontWeight(.semibold)
                           .foregroundColor(Color("bw"))
                       Spacer()
                       Button(
                         action: onSend,
                         label: {
                           Text(
                            Image(systemName: "paperplane")
                           )
                            .font(.system(size:20))
                            .fontWeight(.semibold)
                           .foregroundColor(self.referViewModel.selectedUsers.isEmpty ? .gray : .wingitBlue)
                         }).disabled(self.referViewModel.isDisabled || self.referViewModel.selectedUsers.isEmpty)
                   }
                   .padding([.horizontal,.top])
                   .padding(.bottom, 15)
 
                   HStack(alignment: .center) {
 
                     UserBumpCountSummary(
                       users:
                         self.referViewModel.userBumps +
                         self.referViewModel.selectedUsers,
                       limit: 3,
                       size: 30
                     )
                     Spacer()
                   }
                   .frame(width: UIScreen.main.bounds.width)
                   .padding(.bottom, 15)
 
//              if referViewModel.showOnSuccessAnimation {
//                LottieView(
//                  name: Bool.random() ? "socialmedia" : "network",
//                  onAnimationEnd: {
//                    self.referViewModel.toggleReferListScreen()
//                    let alertView = SPAlertView(
//                      title: "Done!",
//                      preset: SPAlertIconPreset.done);
//                    alertView.present(duration: 2)
//                  },
//                  animationSpeed: 4.5
//                )
//                  .transition(.moveAndFade)
//                .offset(y: -50)
//                  .padding(.top, -30)
//              } else {
                HStack{
                    Text("Your Connections")
                      .font(.headline)
                      .padding(.leading, 15)
                      .padding(.bottom, 5)
                    Spacer()
                    Text(
                      Image(systemName: "person.badge.plus")
                    )
                    .font(.system(size:20))
                    .foregroundColor(.gray)
                    .padding(.trailing, 17)
                    .onTapGesture(perform: openPhoneContactList)
                }
                .padding(.bottom, 10)
                Divider()
               ScrollView(showsIndicators: false){
                 LazyVStack(alignment: .leading){
                   ForEach(
                     Array(self.referViewModel.connections.enumerated()),
                     id: \.element
                   ) { index, user in
                         ReferralUserCard(
                           user: user,
                           isChecked: (
                             !referViewModel.userBumps.filter { $0.id == user.id }.isEmpty ||
                               !referViewModel.selectedUsers.filter {$0.id == user.id}.isEmpty
                           )
                         )
                         .opacity(!referViewModel.userBumps.filter { $0.id == user.id }.isEmpty ? 0.6 : 1)
                         .padding([.horizontal])
                      Divider()
                     }
                 }
                 .background(Color.white)
               }
               .background(Color.white)
 
        }
        .preferredColorScheme(.light)
        .onAppear(perform: onAppearLoadConnectionsList)
        .environmentObject(referViewModel)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        }
    }
}

}
