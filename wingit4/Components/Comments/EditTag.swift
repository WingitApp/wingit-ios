//
//  EditTag.swift
//  wingit4
//
//  Created by Joshua Lee on 10/13/21.
//

import SwiftUI

struct EditTag: View {
  @EnvironmentObject var commentSheetViewModel: CommentSheetViewModel
  var comment: Comment

    var body: some View {
      if commentSheetViewModel.isEditingComment && commentSheetViewModel.comment == comment {
          Image(systemName: "rectangle.and.pencil.and.ellipsis")
            .foregroundColor(Color.gray)
            .font(.system(size: 12))
        }
    }
}

