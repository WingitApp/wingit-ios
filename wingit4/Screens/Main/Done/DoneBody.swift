//
//  DoneBody.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/7/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct DoneFooter: View {
    
    @ObservedObject var doneViewModel = DoneViewModel()
    @ObservedObject var commentViewModel = CommentViewModel()
    @State var showComments : Bool = false
    @State var ImageScreen: Bool = false
    
    init(donepost: DonePost) {
        self.doneViewModel.donepost = donepost
    }
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text(doneViewModel.donepost.askcaption).font(.subheadline).padding(.bottom, 2).fixedSize(horizontal: false, vertical: true)
                HStack{
                Text(timeAgoSinceDate(Date(timeIntervalSince1970: doneViewModel.donepost.askdate), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
//
                    Button(action: {
                        logToAmplitude(event: .viewComments)
                        showComments.toggle()
                    },
                           label: {
                            Image(systemName: "message").foregroundColor(.gray).padding(.leading, 15).accentColor(.red)
                    })
                    if !commentViewModel.comments.isEmpty {
                        Text("\(commentViewModel.comments.count)").foregroundColor(.gray).font(.caption)
                    }
                }
            }.padding(.horizontal)
            Spacer(minLength: 0)
            
            if doneViewModel.donepost.mediaUrl != "" {
                Button(action: {
                    withAnimation(.easeInOut){
                        ImageScreen.toggle()
                    }
                }, label: {
                    URLImage(URL(string:  doneViewModel.donepost.mediaUrl)!,
                             content: {
                                $0.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                             }).frame(width: 200, height: 250).cornerRadius(3).clipped()
                })
                
            }
        }
        .padding(.bottom, 10)
        .frame(width: UIScreen.main.bounds.width - 30)
        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.3),lineWidth: 1.5))

    }
}

