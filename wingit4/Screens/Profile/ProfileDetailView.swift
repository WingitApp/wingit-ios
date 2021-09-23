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
    @State var toggle: Bool = false
    
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
           
            Text("Hi I love to eat, jump, laugh, play the guitar, think, talk, and do nothing. If you want to talk about these things please hit me up. :)").font(.caption).foregroundColor(.gray).padding()
            
            HStack{
                Text("Interests:").bold().font(.caption).foregroundColor(.gray).padding(.leading)
            Text("Design, Food, Tech, Drawing, Whiskey, Wine").font(.caption2).foregroundColor(.gray)
            }.padding(.bottom)
        }
            Text("Winged Posts").bold().font(.title2).padding(.leading)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ProfDetailCard()
                    ProfDetailCard()
                }
            }
            Divider().padding()
    //        Text("Reviews?").padding()
//            HStack{
//                Image(systemName: "link").foregroundColor(.gray).padding(.leading).padding(.top, 10)
//
//                Image(systemName: self.toggle ?  "arrowtriangle.down.fill" : "arrowtriangle.forward.fill").foregroundColor(.gray).padding(.top, 10).font(.caption2)
//                    .onTapGesture{toggle.toggle()}
//            }
            
           // if toggle == true {
        
                 LinkCard()
                
           // }
//         TODO: save links in a dictionary upon edit( [.website : link]
//            if link.isValidURL
//              Link(link, destination: URL(string: link)!)
//            else {
//              Text(link)
//            }
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


struct ProfDetailCard: View {
    
    var body: some View {

    VStack{
        
        Image("Pic2").resizable().frame(width: 150, height: 100)
            
        Text("My Rec").font(.body).foregroundColor(.black).padding(.bottom)
            
    }
    .background(Color.white)
    .cornerRadius(8)
    .overlay(
      RoundedRectangle(cornerRadius: 8)
        .stroke(Color.borderGray, lineWidth: 1)
    )
    .padding(
      EdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 0)
    )
    .clipped()
    .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
        
        VStack{
            
            Image("Pic2").resizable().frame(width: 150, height: 100)
                
            Text("title").font(.body).foregroundColor(.black).padding(.bottom)
                
        }
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.borderGray, lineWidth: 1)
        )
        .padding(
          EdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15)
        )
        .clipped()
        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
        

    }
}

struct LinkCard: View {
    
    var body: some View {

        
        HStack{
                Image("airbnb")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding()
            Text("My airbnb")
                .foregroundColor(.pink)
                .bold()
                .padding(.trailing)
        }
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.borderGray, lineWidth: 1)
        )
        .padding(
          EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0)
        )
        .clipped()
        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
        
        HStack{
                Image("spotify")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding()
            Text("My spotify")
                .foregroundColor(.green)
                .bold()
                .padding(.trailing)
        }
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.borderGray, lineWidth: 1)
        )
        .padding(
          EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0)
        )
        .clipped()
        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)

    }
}
