//
//  CameraView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import SwiftUI


struct CameraView: View {
    @ObservedObject var cameraViewModel = CameraViewModel()
//    @State var txt = ""
//    @State var height: CGFloat = 0
//    @State var textfieldMessage = "Which recommendations do you need help on?"

    func sharePost() {
       // cameraViewModel.uploadPost
        cameraViewModel.sharePost(completed: {
           print("done")
           self.clean()
        }) { (errorMessage) in
            print("Error: \(errorMessage)")
           self.cameraViewModel.showAlert = true
           self.cameraViewModel.errorString = errorMessage
           self.clean()
        }
    }
    
    func shareGem() {
       // cameraViewModel.uploadPost
        cameraViewModel.shareGem(completed: {
           print("done")
           self.clean()
        }) { (errorMessage) in
            print("Error: \(errorMessage)")
           self.cameraViewModel.showAlert = true
           self.cameraViewModel.errorString = errorMessage
           self.clean()
        }
    }
    
    func clean() {
      self.cameraViewModel.caption = ""
        self.cameraViewModel.image = Image(systemName: IMAGE_PHOTO)
        self.cameraViewModel.imageData = Data()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Need both pic and text to post recs but not asking").foregroundColor(.gray).font(.caption).padding(.top, 10)
                HStack(alignment: .top) {
                  
                    cameraViewModel.image.resizable().scaledToFill().frame(width: 60, height: 60).clipped().foregroundColor(.gray).onTapGesture {
                            print("Tapped")
                            self.cameraViewModel.showImagePicker = true
                    }
                      
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        //Chat Content
                        Text("")
                    }
//                    Resizabletextfield(textfieldMessage: self.textfieldMessage, txt: self.$txt, height: self.$height).padding(.top, 5)
//                        .frame(height: self.height)
//                    Text("Ask for recs or recommend yourself!~").foregroundColor(.gray).font(.caption2)
                    TextEditor(text: $cameraViewModel.caption)
                        .cornerRadius(15)
                        .padding()
               }.padding()
                Spacer()
            }.sheet(isPresented: $cameraViewModel.showImagePicker) {
               // ImagePickerController()
                ImagePicker(showImagePicker: self.$cameraViewModel.showImagePicker, pickedImage: self.$cameraViewModel.image, imageData: self.$cameraViewModel.imageData)
            }.navigationBarTitle(Text("Ask for recs or recommend!"), displayMode: .inline)
             .navigationBarItems(trailing: Menu(content: {
                
                Button(action: sharePost) {

                    Text("Ask!")
                }
                
                Button(action: shareGem) {

                    Text("Post Rec")
                }

            }, label: {

                Text("Post").foregroundColor(.gray)
        
            }).alert(isPresented: $cameraViewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(self.cameraViewModel.errorString), dismissButton: .default(Text("OK")))
            }
            ).foregroundColor(.gray)
        }.onTapGesture { dismissKeyboard() }
        
       
    }
}

