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
    @State private var isPostTypeMenuExpanded: Bool = false
  
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
  
  func primaryColorByIndex(index: Int) -> Color {
    let modIndex = index % 4
    
    switch(modIndex) {
      case 0:
        return Color.uiviolet
      case 1:
        return Color.uiblue
      case 2:
        return Color.uiorange
      case 3:
        return Color.uigreen
      default:
        return Color.uiviolet
    }
  }
  
  

  func secondaryColorByIndex(index: Int) -> Color {
    let modIndex = index % 4
    
    switch(modIndex) {
      case 0:
        return Color.uilightViolet
      case 1:
        return Color.uilightBlue
      case 2:
        return Color.uilightGreen
      case 3:
        return Color.uilightOrange
      default:
        return Color.white
    }
  }
    
    var body: some View {
        NavigationView {
          VStack(alignment: .leading) {
            
            
            
            Text("Attach an image")
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
              
              Text("Choose a category")
                .font(.headline)
                .foregroundColor(.black)
              DisclosureGroup(
                isExpanded: $isPostTypeMenuExpanded,
                content: {
                  VStack(alignment: .leading){
                    ForEach(POST_TYPE_OPTIONS.indices, id: \.self) { index in
                      if composePostViewModel.selectedPostType != index {
                        HStack {
                          PostTypeOption(option: POST_TYPE_OPTIONS[index])
                            .frame(width: UIScreen.main.bounds.width - 55)
                        }
                        .background(secondaryColorByIndex(index: index).darker(by: 2))
                        .cornerRadius(5)
                        .overlay(
                          RoundedRectangle(cornerRadius: 5)
                          .stroke(primaryColorByIndex(index: index), lineWidth: 0.2)
                        )
                        .onTapGesture {
                          self.composePostViewModel.selectedPostType = index
                          withAnimation {
                            self.isPostTypeMenuExpanded.toggle()
                          }
                        }
                      }
                      
                    }
                  }
                  .frame(maxWidth: .infinity, alignment: .leading)
                },
                label: {
                  HStack {
                    PostTypeOption(option: POST_TYPE_OPTIONS[composePostViewModel.selectedPostType])
                      .frame(width: UIScreen.main.bounds.width - 55)
                  }
                  .background(secondaryColorByIndex(index: composePostViewModel.selectedPostType).darker(by: 2))
                  .cornerRadius(5)
                  .overlay(
                    RoundedRectangle(cornerRadius: 5)
                      .stroke(primaryColorByIndex(index: composePostViewModel.selectedPostType), lineWidth: 0.2)
                  )
                  .padding(.bottom, 5)
                  .onTapGesture {
                    withAnimation {
                      self.isPostTypeMenuExpanded.toggle()
                    }
                  }
                })
              .padding(.bottom, 5)
      
              Text("Compose a post")
                .font(.headline)
                .padding(.bottom, 5)
                .foregroundColor(.black)
              TextEditor(text: $composePostViewModel.caption)
                  .padding(10)
                  .cornerRadius(5)
                  .overlay(
                    RoundedRectangle(cornerRadius: 5)
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
                    Text("Ask")
                      .foregroundColor(Color.wingitBlue)
                }.disabled(composePostViewModel.isDisabled)
                    
             .alert(isPresented: $composePostViewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(self.composePostViewModel.errorString), dismissButton: .default(Text("OK")))
            }
            )
        }
        //.onTapGesture { dismissKeyboard() }
        
       
    }
}

