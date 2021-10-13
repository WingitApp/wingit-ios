//
//  FirstView.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

/*
 First thing you see on the app.
 
 different form of appStorage
 log status is neither true or false.
 */

struct FirstView: View {
  
    var body: some View {
      
      VStack{
        Button(action: {}){
          Text("Login")
        }
        
        Button(action: {}){
          Text("Sign Up")
        }
      }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
