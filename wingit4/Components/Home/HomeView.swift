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
        NavigationView {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            VStack(alignment: .leading, spacing: 15) {
        
            ScrollView {
           
               
            if !homeViewModel.isLoading {
               
                    ForEach(self.homeViewModel.posts, id: \.postId) { post in
                          
                        VStack {
                            CardView(post: post)
                          }
                      }
               
            }
           }
           }.padding(.top, 10)
           .navigationBarTitle(Text("WingIt!"), displayMode: .inline).onAppear {
                 self.homeViewModel.loadTimeline()
<<<<<<< HEAD:wingit4/Components/Home/HomeView.swift
               //  self.profileViewModel.updateFollowCount(userId: Auth.auth().currentUser!.uid)
=======
                 self.homeViewModel.loadGemTimeline()
>>>>>>> 7b899fb (Remove all follow code):wingit4/View/Components/Home/HomeView.swift
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
        } .background(Color.black.opacity(0.03)
                        .ignoresSafeArea(.all, edges: .all))
        
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}







