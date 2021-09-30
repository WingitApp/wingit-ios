//
//  CarouselWrapper.swift
//  wingit4
//
//  Created by Joshua Lee on 9/28/21.
//

import SwiftUI

struct CarouselWrapper<Content: View>: UIViewRepresentable{
  var width: CGFloat
  var height: CGFloat
  var onSwipeEnd: (_ page: Int) -> Void
  @ViewBuilder var content: Content

  
  func makeCoordinator() -> Coordinator {
    return CarouselWrapper.Coordinator(carouselC: self)
  }
    
  
  func makeUIView(context: Context) -> UIScrollView {
    let total = width * CGFloat(3)
    let view = UIScrollView()
    view.isPagingEnabled = true
    view.contentSize = CGSize(width: total, height: 1.0)
    view.bounces = true
    view.showsVerticalScrollIndicator = false
    view.showsHorizontalScrollIndicator = false
    view.delegate = context.coordinator
    
    let view1 = UIHostingController(rootView: content)
    view1.view.frame = CGRect(x: 0, y: 0, width: total, height: self.height)
    view1.view.backgroundColor = .clear
    
    view.addSubview(view1.view)
    
    return view
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {}
  
  // Class Coordinator
  class Coordinator: NSObject, UIScrollViewDelegate {
    var carousel: CarouselWrapper
    
    init(carouselC: CarouselWrapper) {
      carousel = carouselC
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      let page = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
      self.carousel.onSwipeEnd(page)
    }
    
    
  }

}


