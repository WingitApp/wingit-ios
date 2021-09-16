//
//  ProfileDetailView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/16/21.
//

import SwiftUI

struct ProfileDetailView: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
      // If scrolling up, yOffset will be a negative number
      if maxHeight + yOffset < minHeight {
        // SCROLLING UP
        // Never go smaller than our minimum height
        return minHeight
      }
      
      // SCROLLING DOWN
      return maxHeight + yOffset
    }
    
        var body: some View {
            
            
        VStack(alignment: .leading, spacing: 5){
        VStack(alignment: .center, spacing: 10){
            Text("jolly").bold().foregroundColor(.gray)
            Text("Skater").font(.caption).foregroundColor(.gray)
            Divider().frame(width: 75).padding(.bottom, 5)
            Text("Hi I love to eat, jump, laugh, play the guitar, think, talk, and do nothing. If you want to talk about these things please hit me up. :)").font(.caption).foregroundColor(.gray).padding()
            HStack{
                Text("Interests:").bold().font(.caption).foregroundColor(.gray).padding(.leading)
            Text("Design, Food, Tech, Drawing, Whiskey, Wine").font(.caption2).foregroundColor(.gray)
            }.padding(.bottom)
        }
            HStack{
                Image(systemName: "link").foregroundColor(.gray).padding(.leading).padding(.top, 10)
                Image(systemName: "arrowtriangle.down.fill").foregroundColor(.gray).padding(.top, 10).font(.caption2)
            }
            Text("sub links").padding(.horizontal, 25).font(.caption).foregroundColor(.gray)
            Text("sub links").padding(.horizontal, 25).font(.caption).foregroundColor(.gray)
            Image("fb")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20).padding()
            Image("twitter")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20).padding(.horizontal)
            Image(systemName: "books.vertical.fill").padding().foregroundColor(Color.downeyGreen)
            
        }
    }
}
struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView()
    }
}


