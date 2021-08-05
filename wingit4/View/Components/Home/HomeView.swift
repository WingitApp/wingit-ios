//
//  HomeView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @ObservedObject var homeViewModel = HomeViewModel()
    //@ObservedObject var profileViewModel = ProfileViewModel()
    @ObservedObject var headerCellViewModel = HeaderCellViewModel()
    @State var selection: Selection = .friends
    
    var body: some View {
//        ZStack{
//            FollowingCount(followingCount: $profileViewModel.followingCountState)
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
            Picker(selection: $selection, label: Text("Grid or Table")) {
               ForEach(Selection.allCases) { selection in
                   selection.image.tag(selection)

               }
            }
            .pickerStyle(SegmentedPickerStyle()).padding(.leading, 20).padding(.trailing, 20)
            .onChange(of: selection) { selection in
                if selection == .globe {
                    logToAmplitude(event: .viewHomeRecsFeed)
                } else {
                    logToAmplitude(event: .viewHomeRequestsFeed)
                }
            }
           ScrollView {
           
               
            if !homeViewModel.isLoading {
                if selection == .friends {
                    ForEach(self.homeViewModel.posts, id: \.postId) { post in
                          
                        VStack {
                              HeaderCell(post: post)
                              FooterCell(post: post)
                          }.padding(.top, 10)
                      }
                } else {
                    ForEach(self.homeViewModel.gemposts, id: \.postId) { gempost in
                        
                        VStack {
                            gemHeader(gempost: gempost)
                          }.padding(.top, 10)
                      }
                }
            }
           }
           }.padding(.top, 10)
           .navigationBarTitle(Text("WingIt!"), displayMode: .inline).onAppear {
                 self.homeViewModel.loadTimeline()
                 self.homeViewModel.loadGemTimeline()
               //  self.profileViewModel.updateFollowCount(userId: Auth.auth().currentUser!.uid)
           }.navigationBarItems(leading:
                                    Button(action: {}) {
                                        
                                        NavigationLink(destination: UsersView()) {
                                            Image(systemName: "person.badge.plus").imageScale(Image.Scale.large).foregroundColor(.gray)
                                        }
                                    },
                                trailing: Button(action: {}) {
                          NavigationLink(destination: MessagesView()) {
                              Image(systemName: "envelope").imageScale(Image.Scale.large).foregroundColor(.gray)
                          }
                      }
            )
           .onDisappear {
                if self.homeViewModel.listener != nil {
                    self.homeViewModel.listener.remove()

                }
             }
       }

    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}







