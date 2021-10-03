//
//  TextCellView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/18/21.
//

import SwiftUI
import FirebaseAuth

struct TextCell: View {
    
    @ObservedObject var headerCellViewModel = HeaderCellViewModel()
    @State var ImageScreen: Bool = false
    
    init(post: Post) {
        self.headerCellViewModel.post = post
    }
    var body: some View {
        
        VStack{
            VStack(alignment: .leading, spacing: 10){
                Text(headerCellViewModel.post.caption ?? "").font(.subheadline).padding(.bottom, 2).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
                Text(timeAgoSinceDate(Date(timeIntervalSince1970: headerCellViewModel.post.date ?? 0), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
            }.padding(.horizontal).padding(.bottom, 2)
            
            Spacer(minLength: 0)
            
            if headerCellViewModel.post.mediaUrl != "" {
               
                Button(action: {
                    withAnimation(.easeInOut){
                        ImageScreen.toggle()
                    }
                }, label: {
                    URLImageView(urlString: headerCellViewModel.post.mediaUrl)
                      .frame(width: UIScreen.main.bounds.width - 60, height: 250)
                      .cornerRadius(15)
                })
        
            }
        }.sheet(isPresented: $ImageScreen, content: {
          ImageView(post: $headerCellViewModel.post)
        })
       
    }
}
