//
//  ComposePostView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SPAlert
import SwiftUI


struct ComposePostView: View {
    @ObservedObject var composePostViewModel = ComposePostViewModel()

    func sharePost() {
        composePostViewModel.sharePost(completed: {
           self.clean()
            let alertView = SPAlertView(title: "Your ask was successfully posted.", message: nil, preset: SPAlertIconPreset.done)
            alertView.present(duration: 2)
            
        }) { (errorMessage) in
            //   print("Error: \(errorMessage)")
           self.composePostViewModel.showAlert = true
           self.composePostViewModel.errorString = errorMessage
           self.clean()
        }
    }
        
    func clean() {
      self.composePostViewModel.caption = ""
        self.composePostViewModel.image = Image(systemName: IMAGE_PHOTO)
        self.composePostViewModel.imageData = Data()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Need both pic and text to post recs but not asking").foregroundColor(.gray).font(.caption).padding(.top, 10)
                HStack(alignment: .top) {
                  
                    composePostViewModel.image.resizable().scaledToFill().frame(width: 60, height: 60).clipped().foregroundColor(.gray).onTapGesture {
                            self.composePostViewModel.showImagePicker = true
                    }
                      
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        //Chat Content
                        Text("")
                    }
                    TextEditor(text: $composePostViewModel.caption)
                        .cornerRadius(15)
                        .padding()
               }.padding()
                Spacer()
            }.sheet(isPresented: $composePostViewModel.showImagePicker) {
               // ImagePickerController()
                ImagePicker(showImagePicker: self.$composePostViewModel.showImagePicker, pickedImage: self.$composePostViewModel.image, imageData: self.$composePostViewModel.imageData)
            }
             .navigationBarItems(trailing:
                                    
                Button(action: sharePost) {

                    Text("Wingit!")
                }
           
             .alert(isPresented: $composePostViewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(self.composePostViewModel.errorString), dismissButton: .default(Text("OK")))
            }
            ).foregroundColor(.gray)
        }.onTapGesture { dismissKeyboard() }
        
       
    }
}

