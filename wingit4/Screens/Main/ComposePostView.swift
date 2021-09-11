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
        }
    }
        
    func clean() {
      self.composePostViewModel.caption = ""
        self.composePostViewModel.image = Image(systemName: IMAGE_PHOTO)
        self.composePostViewModel.imageData = Data()
    }
    
    var body: some View {
        NavigationView {
          
          
          
          VStack(alignment: .leading) {
            Text("Add a photo")
              .font(.headline)
              .padding(.bottom, 5)
              .foregroundColor(.black)
            
            if composePostViewModel.imageData.count != 0 {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        Image(uiImage: UIImage(data: composePostViewModel.imageData)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width / 2, height: 150)
                            .cornerRadius(15)
                                // Cancel Button...
                        Button(action: {composePostViewModel.imageData = Data(count: 0)}) {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color("Color"))
                                .clipShape(Circle())
                        }
                    }
                .padding(.bottom, 5)
            }
              HStack{
                  Group{
                    Image(systemName: "camera.fill")
                      .foregroundColor(Color.white)

                    Text("Add photo")
                      .font(.subheadline)
                      .bold()
                      .foregroundColor(Color.white)
                  }
              }
              .frame(
                width: UIScreen.main.bounds.width - 30,
                height: UIScreen.main.bounds.width / 10
              )
              .background(Color(.systemTeal))
              .cornerRadius(8)
              .overlay(
                RoundedRectangle(cornerRadius: 8)
                  .stroke(Color.gray, lineWidth: 0.3)
              )
              .onTapGesture {
                      self.composePostViewModel.showImagePicker = true
              }
              .padding(.bottom, 5)

            
      
              Text("Compose a post")
                .font(.headline)
                .padding(.bottom, 5)
                .foregroundColor(.black)
              TextEditor(text: $composePostViewModel.caption)
                  .cornerRadius(8)
                  .background(Color(.gray).opacity(0.1))
                  .overlay(
                    RoundedRectangle(cornerRadius: 10)
                      .stroke(Color.gray, lineWidth: 0.3)
                  )
                  .onTapGesture { dismissKeyboard() }
                  
                
              
            }
          .padding(
            EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20)
          )
            .background(
              Color(.white)
                .ignoresSafeArea(.all, edges: .all)
            )
            .sheet(isPresented: $composePostViewModel.showImagePicker) {
               // ImagePickerController()
                ImagePicker(showImagePicker: self.$composePostViewModel.showImagePicker, pickedImage: self.$composePostViewModel.image, imageData: self.$composePostViewModel.imageData)
            }
            .navigationBarTitle("Wingit!", displayMode: .inline)
            .navigationBarItems(trailing:
                                    
                Button(action: sharePost) {
                    Text("Post")
                      .foregroundColor(Color(.systemTeal))
                }
                    
           
             .alert(isPresented: $composePostViewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(self.composePostViewModel.errorString), dismissButton: .default(Text("OK")))
            }
            )
        }
        //.onTapGesture { dismissKeyboard() }
        
       
    }
}

