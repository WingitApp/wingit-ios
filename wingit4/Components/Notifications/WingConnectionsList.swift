//
//  WingConnectionsList.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/5/21.
//

import SwiftUI
import Firebase
import URLImage
import SPAlert

//struct WingConnectionsList: View {
//    @EnvironmentObject var referViewModel: ReferViewModel
//    @Binding var referral: Referral
//
//    var body: some View {
//            VStack{
//                Spacer()
//                VStack(spacing: 18){
//                    HStack{
//                        Text("Who can help?")
//                            .font(.title2)
//                            .fontWeight(.regular)
//                            .foregroundColor(Color("bw"))
//                        Spacer()
//                        Button(action: {
//                            logToAmplitude(event: .rewingReferral, properties: [.askId : referral.askId])
//                            referViewModel.rewingReferral(
//                                askId: referral.askId,
//                                parentId: referral.id
//                            )
//                        },
//                               label: {
//                            Text("Send")
//                                .fontWeight(.regular)
//                                .foregroundColor(Color(.systemTeal))
//                        })
//                    }
//                    .padding([.horizontal,.top])
//                    .padding(.bottom, 10)
//                    List {
//                      ForEach(Array(self.referViewModel.allUsers.enumerated()), id: \.element) { index, user in
//                        // this conditional should taken care of in api call
//                            if (user.id != referral.ask?.ownerId) {
//                                WingOptionsCardView(user: user, userId: user.id)
//                            }
//                        }
//                    }
//                }
//                .background(Color.white)
//            }
//            .onAppear {
//                referViewModel.loadConnections(askId: referral.askId)
//            }
//    }
//}
//
//struct WingOptionsCardView: View {
//    @EnvironmentObject var referViewModel: ReferViewModel
//
//    var user: User
//    var userId: String?
//
//    func onTapGesture() {
//      //  print("onTap called")
//        if self.referViewModel.allReferralRecipientIds.contains(userId) {
//            return
//        }
//
//        self.referViewModel.handleUserSelect(userId: userId)
//    }
//
//    var body: some View {
//
//        HStack{
//            URLImageView(urlString: user.profileImageUrl)
//                .frame(width: 40, height: 40)
//                .clipShape(Circle())
//                .overlay(RoundedRectangle(cornerRadius: 100)
//                .stroke(Color.gray, lineWidth: 1))
//                VStack(alignment: .leading, spacing: 5) {
//                 Text(user.displayName ?? "").font(.headline).bold()
//                    Text("@\(user.username ?? "")")
//                        .font(.subheadline)
//                        .foregroundColor(Color(.systemTeal))
//                }
//                .padding(.leading, 5)
//                Spacer()
//
//                ZStack{
//                    Circle()
//                        .stroke(
//                            self.referViewModel.selectedUsers.contains(userId) || self.referViewModel.allReferralRecipientIds.contains(userId)
//                                ? Color(.systemTeal)
//                                : Color.gray,
//                                lineWidth: 1
//                        )
//                        .frame(width: 25, height: 25)
//                    if self.referViewModel.selectedUsers.contains(userId) || self.referViewModel.allReferralRecipientIds.contains(userId) {
//                        Image(systemName: "checkmark.circle.fill")
//                            .font(.system(size:25))
//                            .foregroundColor(Color("Color"))
//                    }
//                }
//            }
//        .padding(
//        EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
//        )
//        .contentShape(Rectangle())
//        .opacity(self.referViewModel.allReferralRecipientIds.contains(userId) ? 0.3 : 1)
//        .onTapGesture(perform: onTapGesture)
//        }
//}
