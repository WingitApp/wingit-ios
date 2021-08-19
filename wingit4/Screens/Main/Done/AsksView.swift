//
//  AsksView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/22/21.
//

//import SwiftUI
//
//struct AsksContentView: View {
//    
//    @State var selected = 0
//    @ObservedObject var profileViewModel = ProfileViewModel()
//    var body: some View {
//        
//        VStack{
//            AsksView(selected: $selected)
//            Spacer()
//         
//                VStack{
//                    if self.selected == 0 {
//                        ScrollView{
//                            ForEach(self.profileViewModel.posts, id: \.postId) { post in
//                                VStack {
//                                    HeaderCell(post: post)
//                                    FooterCell(post: post)
//                                }
//                            }
//                        }
//                    } else {
//                        ScrollView{
//                            ForEach(self.profileViewModel.gemposts, id: \.postId) { gempost in
//                                VStack {
//                                    gemHeader(gempost: gempost)
//                                }
//                            }
//                        }
//                    }
//                }
//                
//            
//        }.edgesIgnoringSafeArea(.top)
//    }
//}
//
//
//struct AsksView: View {
//    @Binding var selected : Int
//    var body: some View {
//        VStack{
//            
//            HStack(spacing: 50){
//                Button(action: {  self.selected = 0 })
//                {
//                    Text("Asks").fontWeight(.semibold).foregroundColor(self.selected == 0 ? Color(.systemTeal) : Color(.systemTeal).opacity(0.5))
//                }
//            
//                
//                Button(action: {  self.selected = 1 }){
//                    Text("Done Asks").fontWeight(.semibold).foregroundColor(self.selected == 1 ? Color(.systemTeal) : Color(.systemTeal).opacity(0.5))
//                }
//            }.padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
//            
//        }
//
//      
//    }
//}

/////Example of multiple tabs for future use.

//struct AsksContentView: View {
//
//    @State var selected = 0
//    var body: some View {
//        VStack{
//            AsksView(selected: $selected)
//            Spacer()
//            GeometryReader{ _ in
//                VStack{
//                    if self.selected == 0 {
//                        Text("Chats")
//                    }else if self.selected == 1 {
//                        Text("Group")
//                    } else if self.selected == 2 {
//                        Text("Status")
//                    } else {
//                        Text("Active")
//                    }
//                }
//
//            }
//        }.edgesIgnoringSafeArea(.top)
//    }
//}
//
//class Host : UIHostingController<AsksContentView>{
//
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }
//
//}
//struct AsksView: View {
//    @Binding var selected : Int
//    var body: some View {
//        VStack(spacing: 20){
//            HStack{
//                Text("Whatsapp")
//                Spacer()
//                Button(action: {}) {
//                    Image(systemName: "plus").font(.headline).foregroundColor(.white)
//                }
//            }
//
//            HStack{
//                Button(action: {  self.selected = 0 })
//                {
//                    Text("Chats").fontWeight(.semibold).foregroundColor(self.selected == 0 ? .white : Color.white.opacity(0.5))
//                }
//                Spacer(minLength: 8)
//
//                Button(action: {  self.selected = 1 }){
//                    Text("Groups").fontWeight(.semibold).foregroundColor(.white).foregroundColor(self.selected == 1 ? .white : Color.white.opacity(0.5))
//                }
//                Spacer(minLength: 8)
//
//                Button(action: {  self.selected = 2 }){
//                    Text("Status").fontWeight(.semibold).foregroundColor(.white).foregroundColor(self.selected == 2 ? .white : Color.white.opacity(0.5))
//                }
//                Spacer(minLength: 8)
//                Button(action: {  self.selected = 3 }){
//                    Text("Active").fontWeight(.semibold).foregroundColor(.white).foregroundColor(self.selected == 3 ? .white : Color.white.opacity(0.5))
//                }
//            }.padding(.top)
//
//        }.padding()
//        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! + 10)
//        .background(Color(.systemTeal))
//
//    }
//}
//
