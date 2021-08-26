//
//  PostPopularViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

//import SwiftUI
//
//
//class PostPopularViewModel: ObservableObject {
//    @Published var gemposts: [gemPost] = []
//    @Published var isLoading = false
//    var splitted: [[gemPost]] = []
//    func loadPostPopular() {
//        isLoading = true
//        Api.gemPost.loadPosts() { (gemposts) in
//            self.isLoading = false
//            self.gemposts = gemposts
//            self.splitted = self.gemposts.splited(into: 3)
//        }
//    }
//}
