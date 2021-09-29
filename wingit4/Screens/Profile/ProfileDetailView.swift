//
//  ProfileDetailView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/16/21.
//

import SwiftUI
import SPAlert

struct ProfileDetailView: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State var toggle: Bool = false
    @State var isPresented = false
    @Binding var linkIcon: String
    
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
            
            ZStack{
        VStack(alignment: .leading, spacing: 5){
        VStack(alignment: .center, spacing: 10){
           
            Text("Hi I love to eat, jump, laugh, play the guitar, think, talk, and do nothing. If you want to talk about these things please hit me up. :)").font(.caption).foregroundColor(.gray).padding()
            
            HStack{
                Text("Interests:").bold().font(.caption).foregroundColor(.gray).padding(.leading)
            Text("Design, Food, Tech, Drawing, Whiskey, Wine").font(.caption2).foregroundColor(.gray)
            }.padding(.bottom)
        }
            Text("Winged Posts").bold().font(.title2).padding()
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ProfDetailCard()
                    ProfDetailCard()
                }
            }
            HStack{
                Spacer(minLength: 0)
                LinkCard(isPresented: $isPresented)
                Spacer(minLength: 0)
            }.padding()
            HStack{
                Image(systemName: "books.vertical.fill").padding(.leading).foregroundColor(Color.downeyGreen)
            Image(systemName: self.toggle ?  "arrowtriangle.down.fill" : "arrowtriangle.forward.fill").foregroundColor(.gray).font(.caption2)
                .onTapGesture{toggle.toggle()}
            }
            if toggle == true {
                Text("bookTitles").padding()
            }
        }
        }
            .modifier(Popup(isPresented: isPresented,
                            alignment: .center,
                            direction: .bottom,
                            content: { LinkUpdatePopUp(linkIcon: $linkIcon)
                                            .environmentObject(profileViewModel)
            }))
    }
}
//struct ProfileDetailView_Previews: PreviewProvider {
//    @Binding var linkIconlink: String
//    static var previews: some View {
//        ProfileDetailView(linkIconlink: $linkIconlink)
//    }
//}


struct ProfDetailCard: View {
    
    var body: some View {
//Just one card but just to see how it looks like added more than one card.
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
    @Binding var isPresented: Bool
    var body: some View {
      
        VStack{
            HStack(alignment: .center, spacing: 25){
                LinkButton(linkIcon: "airbnb", isPresented: $isPresented)
                LinkButton(linkIcon: "spotify",  isPresented: $isPresented)
                LinkButton(linkIcon: "twitter",  isPresented: $isPresented)
            }
            
            HStack(alignment: .center, spacing: 25){
                LinkButton(linkIcon: "instagram",  isPresented: $isPresented)
                LinkButton(linkIcon: "vsco",  isPresented: $isPresented)
                LinkButton(linkIcon: "googleDrive", isPresented: $isPresented)
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.wingitBlue)
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .clipped()
                    .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
            }
        }
    }
}


struct LinkButton: View {
    @State var linkIcon: String
    @Binding var isPresented: Bool
    @EnvironmentObject var profileViewModel: ProfileViewModel
    var body: some View {
        
        Button(action:{
            //Api.User.addLink(field: linkIcon)
            isPresented.toggle()
        })
        {
            Image(linkIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding()
        .background(Color.white)
        .cornerRadius(30)
        .clipped()
        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
        }
    }
}

struct LinkUpdatePopUp: View {
 
    @Binding var linkIcon: String
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
//    @State var airbnb: String = ""
//    @State var spotify: String = ""
//    @State var twitter: String = ""
//    @State var instagram: String = ""
//    @State var vsco: String = ""
//    @State var googleDrive: String = ""
    
//    func addLink() {
//        if !airbnb.isEmpty || !spotify.isEmpty || !twitter.isEmpty || !instagram.isEmpty || !vsco.isEmpty || !googleDrive.isEmpty {
//            profileViewModel.addLinks(airbnb: airbnb, spotify: spotify, twitter: twitter, instagram: instagram, vsco: vsco, googleDrive: googleDrive) {
////                self.airbnb = ""
////                self.spotify = ""
////                self.twitter = ""
////                self.instagram = ""
////                self.vsco = ""
////                self.googleDrive = ""
//
//            }
//        }
//    }
    
    var body: some View {
        VStack{
            Text("Add links")
            TextField("", text: $profileViewModel.url)
                .modifier(TextFieldModifier())
                .disableAutocorrection(true)
            
            Button(action: {profileViewModel.addLinks(field: linkIcon)})
            {
                Text("Save")
            }
        }
        .background(Color.white)
        .cornerRadius(30)
        .clipped()
        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
    }
}

