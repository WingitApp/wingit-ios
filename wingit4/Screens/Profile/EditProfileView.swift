//
//  EditProfileView.swift
//  wingit4
//
//  Created by Amy Chun on 9/28/21.
//

import SwiftUI

struct EditProfileView: View {
    var body: some View {
        VStack{
        Text("Edit Profile").font(.headline)
        HStack{
            Image("user-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 100, height: 100)
            Text("FirstName")
        }
        Text("Last")
        Text("Bio")
        Text("Interests")
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
