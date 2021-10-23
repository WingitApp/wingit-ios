//
//  OnboardingCarousel.swift
//  wingit4
//
//  Created by Joshua Lee on 9/28/21.
//
//
//import SwiftUI
//
//struct OnboardingCarousel: View {
//  @State private var activePage: Int = 0
//  
//  func onSwipeEnd(page: Int) -> Void {
//    activePage = page
//  }
//  
//    var body: some View {
//      VStack{
//        GeometryReader { geometry in
//          CarouselWrapper(
//            width: UIScreen.main.bounds.width,
//            height: geometry.size.width,
//            onSwipeEnd: onSwipeEnd
//          ) {
//            HStack {
//              // replace with onboarding screen
//              AskCardPlaceholder()
//              AskCardPlaceholder()
//              AskCardPlaceholder()
//            }
//          }
//          
//        }
//        HStack {
//          Circle()
//            .frame(width: 10, height: 10)
//            .foregroundColor(activePage == 0 ? Color.wingitBlue : Color.gray)
//          Circle()
//            .frame(width: 10, height: 10)
//            .foregroundColor(activePage == 1 ? Color.wingitBlue : Color.gray)
//          Circle()
//            .frame(width: 10, height: 10)
//            .foregroundColor(activePage == 2 ? Color.wingitBlue : Color.gray)
//        }
//        Spacer()
//      }
//      
//    }
//}
//
//struct OnboardingCarousel_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingCarousel()
//    }
//}
