//
//  ImageView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/13/21.
//

import SwiftUI
import URLImage

struct ImageView: View {
    
    @ObservedObject var headerCellViewModel = HeaderCellViewModel()
    @Environment(\.presentationMode) var presentationmode
    
    var body: some View {
        
        ZStack{
            HStack{
                Button(action: {presentationmode.wrappedValue.dismiss()},
                       label: { Text("Cancel")}).padding()
            }
            Color.black
                .ignoresSafeArea()
            
            URLImage(URL(string: headerCellViewModel.post.mediaUrl)!,
                  content: {
                      $0.image
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                  })
        }

    }
}

struct gemImageView: View {
    
    var gempost: gemPost
    @Environment(\.presentationMode) var presentationmode
    
    var body: some View {
        
        ZStack{
            HStack{
                Button(action: {presentationmode.wrappedValue.dismiss()},
                       label: { Text("Cancel")}).padding()
            }
            Color.black
                .ignoresSafeArea()
            URLImage(URL(string: gempost.mediaUrl)!,
                  content: {
                      $0.image
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                  })
        }

    }
}

struct doneImageView: View {
    
    var donepost: DonePost
    @Environment(\.presentationMode) var presentationmode
    
    var body: some View {
        
        ZStack{
            HStack{
                Button(action: {presentationmode.wrappedValue.dismiss()},
                       label: { Text("Cancel")}).padding()
            }
            Color.black
                .ignoresSafeArea()
            URLImage(URL(string: donepost.mediaUrl)!,
                  content: {
                      $0.image
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                  })
        }

    }
}
struct doneMediaView: View {
    
    var donepost: DonePost
    @Environment(\.presentationMode) var presentationmode
    
    var body: some View {
        
        ZStack{
            HStack{
                Button(action: {presentationmode.wrappedValue.dismiss()},
                       label: { Text("Cancel")}).padding()
            }
            Color.black
                .ignoresSafeArea()
            URLImage(URL(string: donepost.doneMediaUrl)!,
                  content: {
                      $0.image
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                  })
        }

    }
}

