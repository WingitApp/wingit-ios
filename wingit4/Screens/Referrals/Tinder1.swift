//
//  Tinder1.swift
//  wingit4
//
//  Created by Amy Chun on 10/6/21.
//

import SwiftUI

struct Tinder1: View {
    var body: some View {
        VStack{
        Text("Hey I think you can help with this")
        Text("Post preview")
            ZStack{
        Text("person")
                VStack{
                    Spacer()
            HStack{
                Text("wing").padding()
                Spacer()
                VStack{
                Text("Name")
                Text("bio")
                }
                Spacer()
                Text("Accept").padding()
            }.padding()
                }
            }
        }
    }
}

struct Tinder1_Previews: PreviewProvider {
    static var previews: some View {
        Tinder1()
    }
}
