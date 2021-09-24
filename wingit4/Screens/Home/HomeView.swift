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
  @State var scrollProxy: ScrollViewProxy? = nil
  
  func onAppear() {
    // should move to mainView
    logToAmplitude(event: .viewHomeAsksFeed)

  }
  
  func passProxyToState(proxy: ScrollViewProxy) -> CGFloat {
    if scrollProxy == nil {
      self.scrollProxy = proxy
    }
    return 0
  }
      
    var body: some View {
      NavigationView {
        ScrollViewReader { proxy in
            ZStack {
              HStack {}
              .frame(
                height: self.passProxyToState(proxy: proxy)
              )
              .allowsHitTesting(false)
              .zIndex(-1)
              
              VStack(alignment: .leading, spacing: 0) {
                HomeFeed()
              }
              .zIndex(1)
            }
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
            .onTapGesture {
                if self.scrollProxy != nil {
                  self.scrollProxy!.scrollTo(0)
                }
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
            })
      }
      .environmentObject(homeViewModel)
    }
}
