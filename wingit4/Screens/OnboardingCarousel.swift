//
//  OnboardingCarousel.swift
//  wingit4
//
//  Created by Joshua Lee on 9/28/21.
//

import SwiftUI

struct OnboardingCarousel: View {
  @State private var activePage: Int = 0
  
  func onSwipeEnd(page: Int) -> Void {
    activePage = page
  }
  
    var body: some View {
      VStack{
        GeometryReader { geometry in
          CarouselWrapper(
            width: UIScreen.main.bounds.width,
            height: geometry.size.width,
            onSwipeEnd: onSwipeEnd
          ) {
            HStack {
              // replace with onboarding screen
              Onboarding1()
              Onboarding2()
              Onboarding3()
            }
          }
          
        }
        HStack {
          Circle()
            .frame(width: 10, height: 10)
            .foregroundColor(activePage == 0 ? Color.wingitBlue : Color.gray)
          Circle()
            .frame(width: 10, height: 10)
            .foregroundColor(activePage == 1 ? Color.wingitBlue : Color.gray)
          Circle()
            .frame(width: 10, height: 10)
            .foregroundColor(activePage == 2 ? Color.wingitBlue : Color.gray)
        }
        Spacer()
      }
      
    }
}

struct OnboardingCarousel_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding1()
        Onboarding2()
        Onboarding3()
    }
}

struct Onboarding1: View {
 
  
    var body: some View {
      VStack{
       Text("hi")
      }
      
    }
}

struct Onboarding2: View {
 
  
    var body: some View {
      VStack{
       Text("hi")
      }
      
    }
}

struct Onboarding3: View {
 
  
    var body: some View {
      VStack{
       Text("hi")
      }
      
    }
}

//struct Onboarding1: View {
//    @State private var bouncing = false
//    var body: some View {
//    VStack(alignment: .center){
//      FloatingImage(
//        image: "wing.logo",
//        imageSize: 300,
//        bouncingHeight: 5,
//        bouncingDuration: 10)
//            .padding(.bottom, 30)
//          Text("Wingit.").font(.title).bold()
//      Text("Finding the right person to reach each ask.")
//            .font(.headline).bold()
//      }
//
//    }
//}
//
//struct Onboarding2: View {
//    @State var x : CGFloat = 330
//    @State var addThis: CGFloat = 100
//    var body: some View {
//    VStack(alignment: .center){
//        ZStack{
//            AskCardPlaceholder()
//            Text("Wing Asks, and use swipe features but for a good purpose.")
//                .bold()
//                .padding(.top, 500)
//            Image("finger")
//                  .resizable()
//                  .scaledToFit()
//                  .aspectRatio(contentMode: .fill)
//                  .frame(width: 150, height: 150)
//                  .position(x: x, y: 500)
//                              .onAppear() {
//                                  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
//                                      withAnimation() {
//                                          self.addThis = -self.addThis
//                                          self.x = self.x + self.addThis
//                                      }
//                                  }
//                             }
//                         }
//
//                    }
//                }
//}
//
//struct Onboarding3: View {
//
//    @State var open = true
//
//    var body: some View {
//        VStack{
//        ZStack{
//
////            Button(action: {self.open.toggle()}) {
//                Image(systemName: "plus")
//                    .rotationEffect(.degrees(open ? 45 : 0))
//                    .foregroundColor(.white)
//                    .font(.system(size: 38, weight: .bold))
//                    .animation(.spring(response: 0.2, dampingFraction: 0.4, blendDuration: 0))
////            }
//            .padding(24)
//            .background(Color.wingitBlue)
//            .mask(Circle())
//            .shadow(color: Color.wingitBlue, radius: 10)
//            .zIndex(10)
//
//
//            SecondaryButton(open: $open, icon: "person.fill", color: "pblue", offsetY: -90)
//            SecondaryButton(open: $open, icon: "person.fill", color: "pyellow", offsetX: -60, offsetY: -60, delay: 0.1)
//            SecondaryButton(open: $open, icon: "person.fill", color: "ppink", offsetX: -90, delay: 0.2)
//            SecondaryButton(open: $open, icon: "person.fill", color: "pblue", offsetX: -60, offsetY: 60, delay: 0.3)
//            SecondaryButton(open: $open, icon: "person.fill", color: "pyellow", offsetY: 90, delay: 0.4)
//            SecondaryButton(open: $open, icon: "person.fill", color: "ppink", offsetX: 60, offsetY: 60, delay: 0.5)
//            SecondaryButton(open: $open, icon: "person.fill", color: "pblue", offsetX: 90, delay: 0.6)
//            SecondaryButton(open: $open, icon: "person.fill", color: "pyellow", offsetX: 60, offsetY: -60, delay: 0.7)
//
//        }
//            Text("Let's keep the chain going.")
//                .bold()
//                .font(.title2)
//                .foregroundColor(.charcoal)
//                .padding(.top, 100)
//        }
//        .onAppear{
//            self.open.toggle()
//        }
//        }
//    }
//
//struct SecondaryButton: View {
//    @Binding var open: Bool
//    var icon = "pencil"
//    var color = "pblue"
//    var offsetX = 0
//    var offsetY = 0
//    var delay = 0.0
//
//    var body: some View {
//        Button(action: {}) {
//            Image(systemName: icon)
//                .foregroundColor(.white)
//                .font(.system(size: 16, weight: .bold))
//
//        }
//        .padding()
//        .background(Color(color))
//        .mask(Circle())
//        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
//        .scaleEffect(open ? 1: 0)
//        .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)))
//    }
//}
//
//
//struct FloatingImage: View {
//
//    @State private var bouncing = false
//    var image: String
//    var imageSize: Int
//    var bouncingHeight: Int
//    var bouncingDuration: Int
//
//    var body: some View {
//        VStack(alignment: .center){
//      Image(image)
//                .font(.system(size: CGFloat(imageSize)))
//              .foregroundColor(.wingitBlue)
//              .frame(maxHeight: CGFloat(bouncingHeight), alignment: bouncing ? .bottom : .top)
//              .animation(Animation.easeInOut(duration: Double(bouncingDuration)).repeatForever(autoreverses: true))
//              .onAppear {
//                  self.bouncing.toggle()
//              }
//      }
//
//    }
//}

//struct BoncingView: View {
//    @State private var bouncing = false
//    var body: some View {
//        Text("Hello, World!")
//            .frame(maxHeight: .infinity, alignment: bouncing ? .bottom : .top)
//            .animation(Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true))
//            .onAppear {
//                self.bouncing.toggle()
//            }
//    }
//}

