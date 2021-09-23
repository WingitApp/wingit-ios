//
//  AddImageButton.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/22/21.
//

import SwiftUI

struct AddImageButton: View {
    
    @EnvironmentObject var composePostViewModel: ComposePostViewModel
 
    
    var body: some View {
        HStack{
            Group{
              Image(systemName: "camera.fill")
                .foregroundColor(Color.white)

              Text("Add image")
                .font(.subheadline)
                .bold()
                .foregroundColor(Color.white)
            }
        }
        
        .padding(.top, 12)
        .padding(.bottom, 12)
        .frame(
          width: UIScreen.main.bounds.width - 30
        )
        .background(Color.wingitBlue)
        .cornerRadius(5)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.gray, lineWidth: 0.3)
        )
        .onTapGesture {
            self.composePostViewModel.showImagePicker = true
        }
        .padding(.bottom, 5)
        .sheet(isPresented: $composePostViewModel.showImagePicker) {
           // ImagePickerController()
            ImagePicker(showImagePicker: self.$composePostViewModel.showImagePicker, pickedImage: self.$composePostViewModel.image, imageData: self.$composePostViewModel.imageData)
        }
    }
}

struct AddImageButton_Previews: PreviewProvider {
    static var previews: some View {
        AddImageButton()
    }
}
