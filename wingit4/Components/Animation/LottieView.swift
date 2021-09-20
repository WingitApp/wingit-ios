//
//  OnBumpSuccess.swift
//  wingit4
//
//  Created by Joshua Lee on 9/19/21.
//

import SwiftUI
import Lottie

//struct LottieView: UIViewRepresentable {
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    var name: String!
//
//    var animationView = AnimationView()
//
//    class Coordinator: NSObject {
//        var parent: LottieView
//
//        init(_ animationView: LottieView) {
//            self.parent = animationView
//            super.init()
//        }
//    }
//
//    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
//        let view = UIView()
//
//        animationView.animation = Animation.named(name)
//        animationView.contentMode = .scaleAspectFit
//
//
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(animationView)
//
//        NSLayoutConstraint.activate([
//            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
//        ])
//
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
//        animationView.play()
//    }
//}

//import Lottie
//
//import SwiftUI

struct LottieView: UIViewRepresentable {

  var name: String!
  var onAnimationEnd: () -> Void

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = AnimationView()
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1.5

        animationView.play() { (finished) in
//          animationView.isHidden = true
          onAnimationEnd()
      }

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
