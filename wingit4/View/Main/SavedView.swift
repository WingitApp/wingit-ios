//
//  SavedView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/6/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct SavedView: View {
    @State var selection: Selection = .friends
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        ScrollView {
        VStack(alignment: .leading, spacing: 15) {
                 Picker(selection: $selection, label: Text("Grid or Table")) {
                    ForEach(Selection.allCases) { selection in
                        selection.image.tag(selection)

                    }
                 }.pickerStyle(SegmentedPickerStyle()).padding(.leading, 20).padding(.trailing, 20)
        Divider()
            if !profileViewModel.isLoading {
             if selection == .friends {
                ForEach(self.profileViewModel.posts, id: \.postId) { post in
                    VStack {
                        HeaderCell(post: post)
                        FooterCell(post: post)
                    }
                }
             } else {

                ForEach(self.profileViewModel.gemposts, id: \.postId) { gempost in
                    VStack {

                       gemHeader(gempost: gempost)

                    }
                }

             }
         }
         }.padding(.top, 10)
        }.navigationBarTitle(Text("Saved"), displayMode: .inline)
        .onAppear {
            self.profileViewModel.loadUserPosts(userId: Auth.auth().currentUser!.uid)
            self.profileViewModel.loadGemPosts(userId: Auth.auth().currentUser!.uid)
    }
    }
}

