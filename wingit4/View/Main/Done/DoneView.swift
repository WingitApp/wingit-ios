//
//  DoneView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/22/21.
//

//import SwiftUI
//
//struct DoneView: View {
//    @ObservedObject var doneViewModel = DoneViewModel()
//
//    init(donepost: DonePost?) {
//        doneViewModel.donepost = donepost
//    }
//
//    func sharePost() {
//       // cameraViewModel.uploadPost
//        doneViewModel.sharePost(completed: {
//           print("done")
//           self.clean()
//        }) { (errorMessage) in
//            print("Error: \(errorMessage)")
//           self.doneViewModel.showAlert = true
//           self.doneViewModel.errorString = errorMessage
//           self.clean()
//        }
//    }
//
//    func clean() {
//      self.doneViewModel.caption = ""
//        self.doneViewModel.image = Image(systemName: IMAGE_PHOTO)
//        self.doneViewModel.imageData = Data()
//    }
//    var body: some View {
//        VStack {
//
//            Text("Who's recommendation did you decide on?").foregroundColor(.gray).font(.caption).padding(.top, 10)
//
//            HStack(alignment: .top) {
//
//                doneViewModel.image.resizable().scaledToFill().frame(width: 60, height: 60).clipped().foregroundColor(.gray).onTapGesture {
//                        print("Tapped")
//                        self.doneViewModel.showImagePicker = true
//                }
//
//                ScrollView(.vertical, showsIndicators: false) {
//
//                    //Chat Content
//                    Text("")
//                }
////                    Resizabletextfield(textfieldMessage: self.textfieldMessage, txt: self.$txt, height: self.$height).padding(.top, 5)
////                        .frame(height: self.height)
////                    Text("Ask for recs or recommend yourself!~").foregroundColor(.gray).font(.caption2)
//                TextEditor(text: $doneViewModel.caption)
//                    .cornerRadius(15)
//                    .padding()
//           }.padding()
//            Button(action: sharePost) {
//                   Text("Submit")
//                       .fontWeight(.bold)
//                       .foregroundColor(Color.white)
//                       .padding(.vertical)
//                       .frame(maxWidth: .infinity)
//                       .background(Color(.systemTeal))
//                       .cornerRadius(8)
//            }.padding(.vertical).padding(.horizontal)
//            .alert(isPresented: $doneViewModel.showAlert) {
//                Alert(title: Text("Error"), message: Text(self.doneViewModel.errorString), dismissButton: .default(Text("OK")))
//            }
//        }.sheet(isPresented: $doneViewModel.showImagePicker) {
//            // ImagePickerController()
//             ImagePicker(showImagePicker: self.$doneViewModel.showImagePicker, pickedImage: self.$doneViewModel.image, imageData: self.$doneViewModel.imageData)
//         }
//    }
//}
//
//
//
//
