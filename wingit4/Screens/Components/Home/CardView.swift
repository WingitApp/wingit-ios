//
//  CardView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/18/21.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var headerCellViewModel = HeaderCellViewModel()
    
    init(post: Post) {
        self.headerCellViewModel.post = post
    }
    
    var body: some View {
        VStack{
            HeaderCell(post: $headerCellViewModel.post)
            TextCell(post: headerCellViewModel.post)
            FooterCell(post: $headerCellViewModel.post)
        }.background(Color(.white)).cornerRadius(20)

    }
}

