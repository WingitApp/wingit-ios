//
//  DoneView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/27/21.
//

import SwiftUI
import FirebaseAuth

struct DoneView: View {
    @ObservedObject var doneViewModel = DoneViewModel()
    var user: User

    var body: some View {
        ScrollView{
            if !doneViewModel.isLoading {
                ForEach(self.doneViewModel.doneposts, id: \.postId) {
                    donepost in
                    VStack{
                        DoneCell(donepost: donepost)
                    }
                }
            }
        }.padding(.top, 10)
        .onAppear {
            logToAmplitude(event: .viewFulfilledRequests)
            self.doneViewModel.loadDonePosts(userId: user.uid)
        }
    }
}



