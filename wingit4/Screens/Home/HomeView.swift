//
//  HomeView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
  
  @EnvironmentObject var homeViewModel: HomeViewModel
  
  func onAppear() {
    // should move to mainView
    logToAmplitude(event: .viewHomeAsksFeed)

  }
    
    var body: some View {
      NavigationView {
        VStack(alignment: .leading, spacing: 0) {
          // Header Toggle
//          HomeFeedHeader()
          HomeFeed()
        }
        .onAppear( perform: onAppear )
        .background(Color.backgroundGray.ignoresSafeArea(.all, edges: .all))
        .toolbar {
          ToolbarItem(placement: .principal) {
            VStack {
              Image(IMAGE_LOGO).resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 35)
              Text("Wingit")
                .bold()
                .padding(.top, -5)
            }
          }
        }
        .navigationBarItems(
            leading: Button(action: {}) {
                NavigationLink(destination: UsersView()) {
                  Image(systemName: "magnifyingglass")
                    .imageScale(Image.Scale.medium)
                    .foregroundColor(.gray)
                }
            },
            trailing:
                NavigationLink(destination: ContactsListView()) {
                    Image(systemName: "person.fill.badge.plus")
                      .imageScale(Image.Scale.medium)
                      .foregroundColor(.gray)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    logToAmplitude(
                        event: .tapInviteFriends,
                        properties: [.screen: "home"]
                    )
                })
        )
      }.environmentObject(homeViewModel)
    }
}
