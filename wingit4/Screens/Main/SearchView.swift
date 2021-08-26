//
//  SearchView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

//import SwiftUI
//
//struct SearchView: View {
//        
//        @ObservedObject var postPopularViewModel = PostPopularViewModel()
//    
////        @State var selection: Selection = .grid
//        var body: some View {
//            return
//                NavigationView {
//                    ScrollView {
//                            
////                            Picker(selection: $selection, label: Text("Grid or Table")) {
////                            ForEach(Selection.allCases) { selection in
////                                    selection.image.tag(selection)
////
////                                }
////                            }.pickerStyle(SegmentedPickerStyle()).padding()
//                            if !postPopularViewModel.isLoading {
////                                  if selection == .grid {
////                                      GridPosts(splitted: self.postPopularViewModel.splitted)
////                                  } else {
//                                      ForEach(self.postPopularViewModel.gemposts, id: \.postId) { gempost in
//                                          VStack {
//                                            gemHeader(gempost: gempost)
//                                          }
//                                      }       
//                            }
//                              
//                            }.padding(.top, 10).navigationBarTitle(Text("Discover"), displayMode: .inline)
//                                .navigationBarItems(
//                                    leading: Button(action: {}) {
//                                                NavigationLink(destination: UsersView()) {
//                                                Image(systemName: "person.badge.plus").imageScale(Image.Scale.large).foregroundColor(.gray)
//                                                }
//                                            }).onAppear {
//                                                self.postPopularViewModel.loadPostPopular()    }
//                }
//        
//        }
//}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
