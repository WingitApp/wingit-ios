//
//  HomeView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
  @StateObject var homeViewModel = HomeViewModel()
  @ObservedObject var headerCellViewModel = HeaderCellViewModel()
  
  func onAppear() {
    self.homeViewModel.loadTimeline()
    self.homeViewModel.loadGemTimeline()
  }
    
    var body: some View {
      NavigationView {
        VStack(alignment: .leading, spacing: 15) {
//          FeedToggle()
          HomeFeed()
        }
        .padding(.top, 10)
        .onAppear( perform: onAppear )
        .navigationBarTitle(Text("WingIt!"), displayMode: .inline)
        .navigationBarItems(leading:
          Button(action: {}) {
            NavigationLink(destination: UsersView()) {
              Image(systemName: "person.badge.plus")
                .imageScale(Image.Scale.large)
                .foregroundColor(.gray)
            }
          },trailing: Button(action: {}) {
            NavigationLink(destination: MessagesView()) {
              Image(systemName: "envelope").imageScale(Image.Scale.large).foregroundColor(.gray)
            }
          })
        .onDisappear {
          if self.homeViewModel.listener != nil {
            self.homeViewModel.listener.remove()
          }
        }
      }.environmentObject(homeViewModel)
    }
}
