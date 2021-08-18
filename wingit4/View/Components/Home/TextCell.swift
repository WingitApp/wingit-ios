//
//  TextCellView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/18/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct TextCell: View {
    
    @ObservedObject var headerCellViewModel = HeaderCellViewModel()
    @State var ImageScreen: Bool = false
    
    init(post: Post) {
        self.headerCellViewModel.post = post
    }
    var body: some View {
        
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text(headerCellViewModel.post.caption).font(.subheadline).padding(.bottom, 2).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
                Text(timeAgoSinceDate(Date(timeIntervalSince1970: headerCellViewModel.post.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
            }.padding(.horizontal).padding(.bottom, 2)
            Spacer(minLength: 0)
            if headerCellViewModel.post.mediaUrl != "" {
                Button(action: {
                    withAnimation(.easeInOut){
                        ImageScreen.toggle()
                    }
                }, label: {
                    URLImage(URL(string: headerCellViewModel.post.mediaUrl)!,
                          content: {
                              $0.image
                                  .resizable()
                                  .aspectRatio(contentMode: .fill)
                          }).frame(width: 200, height: 250).cornerRadius(3).clipped()
                })
            
            }
        }.sheet(isPresented: $ImageScreen, content: {
            ImageView(headerCellViewModel: headerCellViewModel)
        })
       
    }
}
