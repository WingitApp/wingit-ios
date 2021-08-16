//
//  HomeView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import FirebaseAuth

struct
HomeView: View {
    
    @ObservedObject var homeViewModel = HomeViewModel()
    //@ObservedObject var profileViewModel = ProfileViewModel()
    @ObservedObject var headerCellViewModel = HeaderCellViewModel()
    @State var selection: Selection = .friends
    
   // @Environment(\.deepLink) var deepLink
   // var posts: [Post] = Bundle.main.decode("post.json")
    @State var cellSelected: Int?

    
    var body: some View {
//        ZStack{
//            FollowingCount(followingCount: $profileViewModel.followingCountState)
        NavigationView {
            ScrollViewReader { proxy in
            VStack(alignment: .leading, spacing: 15) {
            Picker(selection: $selection, label: Text("Grid or Table")) {
               ForEach(Selection.allCases) { selection in
                   selection.image.tag(selection)

               }
            }.pickerStyle(SegmentedPickerStyle()).padding(.leading, 20).padding(.trailing, 20)

            ScrollView {
           
               
            if !homeViewModel.isLoading {
                if selection == .friends {
                    ForEach(self.homeViewModel.posts, id: \.postId) { post in
                          
                        VStack {
                            HeaderCell(
                                post: post,
                                isProfileView: false
                            )
                              FooterCell(post: post)
                          }.padding(.top, 10)
                      }
                } else {
                    ForEach(self.homeViewModel.gemposts, id: \.postId) { gempost in
                        
                        VStack {
                            gemHeader(gempost: gempost, isProfileView: false)
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
//            .onChange(of: deepLink) { deepLink in
//              guard let deepLink = deepLink else { return }
//
//              switch deepLink {
//              case .details(let postID):
//                // 2
//                if let index = posts.firstIndex(where: {
//                  $0.postId == postID
//                }) {
//                  // 3
//                  proxy.scrollTo(index, anchor: .bottom)
//                  // 4
//                  cellSelected = index
//                }
//              case .home:
//                break
//              }
//            }
        }
       }

    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}







