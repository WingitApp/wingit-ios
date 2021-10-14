//
//  ReactionBar.swift
//  wingit4
//
//  Created by Joshua Lee on 9/25/21.
//

import SwiftUI


struct ReactionBar: View {
  @EnvironmentObject var reactionBarViewModel: ReactionBarViewModel
  @EnvironmentObject var commentSheetViewModel: CommentSheetViewModel
  @EnvironmentObject var reactionSheetViewModel: ReactionSheetViewModel

  @EnvironmentObject var session: SessionStore
  
  var comment: Comment
  var isOwnPost: Bool
  var scrollToComment: (() -> Void)? = nil
  
  @State var text: String = ""
  @State var showSheet: Bool = false
  
  @State private var totalHeight
  = CGFloat.zero       // << variant for ScrollView/List
  //    = CGFloat.infinity   // << variant for VStack
  
  private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
    return GeometryReader { geometry -> Color in
      let rect = geometry.frame(in: .local)
      DispatchQueue.main.async {
        binding.wrappedValue = rect.size.height
      }
      return .clear
    }
  }
  
  var body: some View {
    VStack {
      GeometryReader { geometry in
        self.generateContent(in: geometry)
      }
    }
    .frame(height: totalHeight)
    //.frame(maxHeight: totalHeight) // << variant for VStack
  }
  
  private func generateContent(in g: GeometryProxy) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    
    return ZStack(alignment: .topLeading) {
      ForEach(Array(self.reactionBarViewModel.reactions.enumerated()), id: \.element) { index, reaction in
        HStack {
          ReactionButton(
            reaction: reaction,
            comment: comment
          )
          if !self.reactionBarViewModel.reactions.isEmpty, reaction == self.reactionBarViewModel.reactions.last! {
            Button(action: {
              Haptic.impact(type: "small")
              commentSheetViewModel.openCommentSheet(
                comment: comment,
                isOwnPost: isOwnPost,
                reactions: self.reactionBarViewModel.reactions,
                showEmojiKeyboard: true,
                scrollToComment: self.scrollToComment,
                onOpen: {}
              )
            } ) {
              Image(systemName: "plus")
                .padding(4)
                .background(Color.lightGray)
                .cornerRadius(100)
                .font(.system(size: 10))
                
            }
            .padding(.leading, 5)
          }
        }
        .padding([.horizontal, .vertical], 4)
        .alignmentGuide(.leading, computeValue: { d in
          if (abs(width - d.width) > g.size.width)
          {
            width = 0
            height -= d.height
          }
          let result = width
          if reaction == self.reactionBarViewModel.reactions.last! {
            width = 0 //last item
          } else {
            width -= d.width
          }
          return result
        })
        .alignmentGuide(.top, computeValue: {d in
          let result = height
          if reaction == self.reactionBarViewModel.reactions.last! {
            height = 0 // last item
          }
          return result
        })
        
      }
      
    }
    .background(viewHeightReader($totalHeight))
    .environmentObject(reactionBarViewModel)
    .environmentObject(commentSheetViewModel)
    .environmentObject(reactionSheetViewModel)
  }
  
  
}
