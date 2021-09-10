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
            VStack {
                
//                    composePostViewModel.image.resizable().scaledToFill().frame(width: 60, height: 60).clipped().foregroundColor(.gray).onTapGesture {
//                            self.composePostViewModel.showImagePicker = true
//                    }
                
                TextEditor(text: $composePostViewModel.caption)
                    .padding()
                    .onTapGesture { dismissKeyboard() }
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
                .padding()
        }
                HStack{
                    Group{
                    Image(systemName: "camera.fill")
                    Text("Add photo").bold()
                    }.foregroundColor(.black).font(.caption2)
                }
                .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.width / 10)
                .background(Color.gray).opacity(0.3)
                .cornerRadius(10)
                .padding(.bottom, 5)
                .onTapGesture {
                        self.composePostViewModel.showImagePicker = true
                }
              
            }.sheet(isPresented: $composePostViewModel.showImagePicker) {
               // ImagePickerController()
                ImagePicker(showImagePicker: self.$composePostViewModel.showImagePicker, pickedImage: self.$composePostViewModel.image, imageData: self.$composePostViewModel.imageData)
            }
            .navigationBarTitle("Wingit!", displayMode: .inline)
            .navigationBarItems(trailing:
                                    
                Button(action: sharePost) {

                    Text("Post")
                }
                    
           
             .alert(isPresented: $composePostViewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(self.composePostViewModel.errorString), dismissButton: .default(Text("OK")))
            }
            ).foregroundColor(.gray)
        }
        //.onTapGesture { dismissKeyboard() }
        
       
    }
}

