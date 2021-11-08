//
//  ArcSummaryView.swift
//  wingit4
//
//  Created by Amy Chun on 11/7/21.
//

import SwiftUI

struct ArcSummaryView: View {
    var body: some View {
      ZStack {
        Color(red: 127 / 255, green: 188 / 255, blue: 209 / 255)
          .ignoresSafeArea()
          .opacity(7)
        VStack {
          
        Rectangle()
            .fill(Color.white)
            .frame(height: 630)
            .cornerRadius(30)
            .ignoresSafeArea()
            
            Spacer()
        }
        
      VStack {
        HStack {
        Image("Pic1")
          .resizable()
          .clipShape(Circle())
          .frame(width: 70, height: 70)

      VStack(alignment: .leading) {
        
        Text("Arc Title")
          .bold()
          .font(.title)
        Text("Lori Dons")
            .font(.caption)
            .foregroundColor(.gray)
      }.padding(.horizontal, 5)
          
          Spacer()
        }.padding(25)
        .padding(.horizontal, 5)
        ListOfNeeds()
        ArcPageScroll()
        ArcDescription()
          .foregroundColor(.white)
        
        HStack {
          Spacer()
          Image(systemName: "bookmark.fill")
          Image(systemName: "heart")
          Image(systemName: "flag")
        }
        .foregroundColor(.white)
        .padding(.horizontal, 25)
      }
    }
    }
}

struct ArcSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ArcSummaryView()
    }
}

