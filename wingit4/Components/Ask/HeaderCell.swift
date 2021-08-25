//
//  HeaderCell.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct HeaderCell: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @ObservedObject var headerCellViewModel = HeaderCellViewModel()
  
  var post: Post

    @State var reportScreen: Bool = false
    @State var ImageScreen: Bool = false
    @State var done: Bool = false
    @State var isProfileView: Bool = false
  
  
        
    var body: some View {
        VStack {
            HStack {
              NavigationLink(destination: self.askCardViewModel.destination) {
                URLImage(URL(string: post.avatar)!,
                   content: {
                      $0.image
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .clipShape(Circle())
                   }).frame(width: 35, height: 35)
              }.disabled(self.askCardViewModel.isNavLinkDisabled)
              Text(post.username).modifier(UserNameStyle())
              Spacer()
              AskDoneToggle() // rename later
              EllipsisMenu()
            }.padding(.trailing, 15).padding(.leading, 15)
        }
        .padding(.top, 10)
    }
}
