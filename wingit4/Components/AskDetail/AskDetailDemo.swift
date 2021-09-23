//
//  AskDetailDemo.swift
//  wingit4
//
//  Created by Joshua Lee on 9/6/21.
//

import SwiftUI

struct AskDetailDemo: View {
    var body: some View {
      VStack(alignment: .leading) {
        // HeaderCell
        HStack {
          Circle()
            .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(.green)
          VStack(alignment: .leading){
            Text("3D Cartoon Exhibitions")
              .font(.title3)
              .fontWeight(.bold)

            Text("December 12, 2020")
              .font(.caption2)
              
          }
          Spacer()
          
        }
        //Body
        VStack(alignment: .leading) {

          Text("Featured artists include Barry Doupe, Kathleen Daniel, Ryan Whittier Hale, and Jacolby Satterwhite, Beyond human forms..")
            .font(.callout)
//            Text("Description")
//              .font(.headline)
//              .padding(.bottom, 5)
        }
        .padding(.top, 10)
        .padding(.bottom, 10)

        //Meta Data
        VStack(alignment: .leading) {
          Text("Wingers")
            .font(.headline)
            .padding(.bottom, 5)
          HStack {
            Circle()
              .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
              .foregroundColor(.orange)
            
            Circle()
              .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
              .foregroundColor(.gray)
              .padding(.leading, -15)
            Circle()
              .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
              .foregroundColor(.yellow)
              .padding(.leading, -15)
            Circle()
              .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
              .foregroundColor(.red)
              .padding(.leading, -15)
            Circle()
              .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
              .foregroundColor(.blue)
              .padding(.leading, -15)
            Text("+344")
              .font(.caption)
          }
          .padding(.bottom, 15)

          
          // Footer
          Divider()
          HStack {
            Image(systemName: "heart.circle.fill")
              .foregroundColor(.red)
              .font(.system(size: 25))
            Text("12")
              .font(.caption)
            
            
            Image(systemName: "message")
                .foregroundColor(Color.wingitBlue)
              .padding(.leading, 5)
              .font(.system(size: 20))
            Text("21")
              .font(.caption)
            Spacer()
            Image(systemName: "arrowshape.turn.up.right")
                .foregroundColor(Color.wingitBlue)

          }
//          .padding(.top, 10)
          
          Divider()

          
        }

        Spacer()

      }
      .padding(.top, 40)
      .padding(.leading, 15)
      .padding(.trailing, 15)
      .frame(
        width: UIScreen.main.bounds.size.width,
        height: UIScreen.main.bounds.size.height
      )

    }
}

struct AskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AskDetailDemo()
    }
}
