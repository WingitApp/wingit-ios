//
//  RollingNumberView.swift
//  wingit4
//
//  Created by Joshua Lee on 9/5/21.
//

import SwiftUI

struct RollingNumberView: View {
    @State var nextCount = 10 // update this to desired number
    @State var showAnimation: Bool = false
    @State var total = 0
    var backgroundColor = Color.white
  
  
  func updateNumber(count: Int) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
      addNumberWithRollingAnimation()
    }
    
  }
  
    var body: some View {
      Text("Like: \(total)")
          // create a barrier from the total and scaled animation
         .background(Rectangle().foregroundColor(self.backgroundColor))
      .font(.system(size: 18, weight: .medium, design: .serif))
      .onAppear {
        self.updateNumber(count: 20)
      }
    }


}


extension RollingNumberView {
    var enteredNunberIsPositive: Bool {
        nextCount > 0 // technically zero isn't positive lol
    }
    
    // guard against adding animation during another animation
    var isAnimationAllowed: Bool{
        !self.showAnimation
    }
    
    func addNumberWithRollingAnimation() {
        guard isAnimationAllowed else { return }
        
        withAnimation {
            // show scale animation
            self.showAnimation = true
            
            // Decide on the number of animation steps
            let animationDuration = 1000 // milliseconds
            let steps = min(abs(self.nextCount), 100)
            let stepDuration = (animationDuration / steps)
            
            // add the remainder of our entered num from the steps
            self.total += self.nextCount % steps
            
            (0..<steps).forEach { step in
                let updateTimeInterval = DispatchTimeInterval.milliseconds(step * stepDuration)
                let deadline = DispatchTime.now() + updateTimeInterval
                DispatchQueue.main.asyncAfter(deadline: deadline) {
                    // Add piece of the entire entered number to our total
                    self.total += Int(self.nextCount / steps)
                }
            }
            
            // hide scale animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showAnimation = false
            }
        }
    }
}

struct RollingNumberView_Previews: PreviewProvider {
    static var previews: some View {
        RollingNumberView()
    }
}
