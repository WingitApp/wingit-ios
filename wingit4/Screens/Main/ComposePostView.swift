//
//  ComposePostView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SPAlert
import SwiftUI

struct ComposePostView: View, KeyboardReadable {
    
    @StateObject var composePostViewModel = ComposePostViewModel()
    @State private var isPostTypeMenuExpanded: Bool = false
    @State private var isTextEditorOpen: Bool = false
  
    func sharePost() {
        composePostViewModel.sharePost(completed: {
           self.clean()
            let alertView = SPAlertView(title: "Your ask was successfully posted.", message: nil, preset: SPAlertIconPreset.done)
            alertView.present(duration: 2)
            composePostViewModel.isDisabled = false
        }) { (errorMessage) in
            //   print("Error: \(errorMessage)")
           self.composePostViewModel.showAlert = true
           self.composePostViewModel.errorString = errorMessage
           composePostViewModel.isDisabled = false
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
        return Color.uilightOrange
      case 3:
        return Color.uilightGreen
      default:
        return Color.white
    }
  }
    
    var body: some View {
        NavigationView {
            
          VStack(alignment: .leading) {
            if !isTextEditorOpen {
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
                            .cornerRadius(5)
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
             
            AddImageButton()
                
              
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
                  .transition(.enterLeftAndFade)
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
          }
            HStack {
              Text("Compose a post")
                .font(.headline)
                .padding(.bottom, 5)
                .foregroundColor(.black)
              Spacer()
              if isTextEditorOpen {
                CloseButton(onTap: dismissKeyboard)
              }
            }
            
              TextEditor(text: $composePostViewModel.caption)
                  .padding(10)
                  .cornerRadius(5)
                  .overlay(
                    RoundedRectangle(cornerRadius: 5)
                      .stroke(Color.gray, lineWidth: 0.3)
                  )
            }
          .padding(
            EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20)
          )
            .background(
              Color(.white)
                .ignoresSafeArea(.all, edges: .all)
            )
          
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
          .environmentObject(composePostViewModel)
         
        }
        .switchStyle(if: UIDevice.current.userInterfaceIdiom == .phone)
        .onReceive(keyboardPublisher) { isKeyboardVisible in
            isTextEditorOpen = isKeyboardVisible
       }
        .onTapGesture {
          dismissKeyboard()
        }
        
       
    }
}

