//
//  DoneToggle.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/27/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct DoneToggle: View {
    
    @ObservedObject var doneViewModel = DoneViewModel()
    
    init(post: Post?) {
            doneViewModel.post = post
    }
    
    func shareDone() {
       // cameraViewModel.uploadPost
        doneViewModel.shareDone(completed: {
          // print("done")
           self.clean()
        }) { (errorMessage) in
            //  print("Error: \(errorMessage)")
           self.doneViewModel.showAlert = true
           self.doneViewModel.errorString = errorMessage
           self.clean()
        }
    }
    func justDone() {
       // cameraViewModel.uploadPost
        doneViewModel.justDone(completed: {
        //   print("done")
           self.clean()
        }) { (errorMessage) in
         //   print("Error: \(errorMessage)")
           self.doneViewModel.showAlert = true
           self.doneViewModel.errorString = errorMessage
           self.clean()
        }
    }
    
    func clean() {
      self.doneViewModel.caption = ""
        self.doneViewModel.image = Image(systemName: IMAGE_PHOTO)
        self.doneViewModel.imageData = Data()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Which recommendation did you choose?").foregroundColor(.gray).font(.caption).padding(.top, 10)
                HStack(alignment: .top) {
                  
                    doneViewModel.image.resizable().scaledToFill().frame(width: 60, height: 60).clipped().foregroundColor(.gray).onTapGesture {
                          //  print("Tapped")
                            self.doneViewModel.showImagePicker = true
                    }
                      
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        //Chat Content
                        Text("")
                    }

                    TextEditor(text: $doneViewModel.caption)
                        .cornerRadius(15)
                        .padding()
               }.padding()
                Spacer()
                HStack{
                Button(action: justDone) {
                       Text("Just Done")
                           .fontWeight(.bold)
                           .foregroundColor(Color.white)
                           .padding(.vertical)
                           .frame(width: 150, height: 50)
                           .background(Color(.systemTeal))
                           .cornerRadius(8)
                }.padding(.vertical).padding(.horizontal)
                Button(action: shareDone) {
                       Text("Submit")
                           .fontWeight(.bold)
                           .foregroundColor(Color.white)
                           .padding(.vertical)
                           .frame(width: 150, height: 50)
                           .background(Color(.systemTeal))
                           .cornerRadius(8)
                }.padding(.vertical).padding(.horizontal)
            }
                .alert(isPresented: $doneViewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text(self.doneViewModel.errorString), dismissButton: .default(Text("OK")))
                }
            }.sheet(isPresented: $doneViewModel.showImagePicker) {
               // ImagePickerController()
                ImagePicker(showImagePicker: self.$doneViewModel.showImagePicker, pickedImage: self.$doneViewModel.image, imageData: self.$doneViewModel.imageData)
            }
         
        }.onTapGesture { dismissKeyboard() }
        
       
    }
}

