//
//  NotificationView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//
import SwiftUI
import URLImage

struct NotificationView: View {
    
    @EnvironmentObject var activityViewModel: ActivityViewModel

    var body: some View {
       
        NavigationView {
            List {
                if !activityViewModel.activityArray.isEmpty {
                    ForEach(self.activityViewModel.activityArray, id: \.activityId) { activity in
                      HStack(alignment: .top) {
                            if activity.type == "comment" {
                                ZStack {
                                    NotificationEntry(activity: activity)
//                                    NavigationLink(destination: CommentView(postId: activity.postId)) {
//                                        EmptyView()
//                                    }
                                }
                            } else if activity.type == "connectRequest" {
                                ZStack {
                                    CommentActivityRow(activity: activity, activityViewModel: self.activityViewModel)
                                }
                            } else {
                                URLImage(URL(string: activity.userAvatar)!,
                                   content: {
                                       $0.image
                                           .resizable()
                                           .aspectRatio(contentMode: .fill)
                                           .clipShape(Circle())
                                   })
                                  .frame(width: 35, height: 35)
                                  .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                      .stroke(Color.gray, lineWidth: 1)
                                  )
                              VStack(alignment: .leading) {
                                HStack(alignment: .center, spacing: 5) {
                                    Text(activity.username).font(.subheadline).bold()
                                    Text(activity.typeDescription).font(.subheadline)
                                }
                                Spacer()
                                Text(timeAgoSinceDate(Date(timeIntervalSince1970: activity.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                              }
                              .padding(.leading, 3)
                                
                               
                            }
                       

                        }
                        .padding(
                          EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                        )
                    }
                }
                  
           
            }.navigationBarTitle(Text("Notifications"), displayMode: .automatic)
            .onDisappear {
                 if self.activityViewModel.listener != nil {
                     self.activityViewModel.listener.remove()
                 }
              }

        }
      
    }
}

struct CommentActivityRow: View {
    var activity: Activity
    var activityViewModel: ActivityViewModel
    var body: some View {
      HStack(alignment: .top) {
            URLImage(URL(string: activity.userAvatar)!,
               content: {
                   $0.image
                       .resizable()
                       .aspectRatio(contentMode: .fill)
                       .clipShape(Circle())
               })
              .frame(width: 35, height: 35)
              .overlay(
                RoundedRectangle(cornerRadius: 100)
                  .stroke(Color.gray, lineWidth: 1)
              )
            HStack{
                VStack(alignment: .leading) {
                    HStack{
                        Text(activity.username).font(.subheadline).bold()
                        Text(activity.typeDescription).font(.subheadline)
                    }
                    HStack{
                      Text(timeAgoSinceDate(Date(timeIntervalSince1970: activity.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                    }
                    .padding(.top, 3)
                    VStack(alignment: .trailing){
                        RespondToConnectRequestRow(activity: activity)
                    }.padding(.top, 3)
                 
                }
            }
            .padding(.leading, 5)
            
        }
    }
}

struct RespondToConnectRequestRow: View {
    var activity: Activity
    @EnvironmentObject var activityViewModel: ActivityViewModel
    var body: some View {
        
        HStack {
                Button(
                    action: {
                        activityViewModel.deleteConnectRequest(fromUserId: activity.userId)
                        
                    }) {
                   
                    Text("Ignore")
                        .fontWeight(.bold).foregroundColor(Color.black)
                        .font(.system(size: 10))
                }
                .padding(.horizontal, 5)
                .frame(height: UIScreen.main.bounds.width / 15)
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color(.gray).opacity(0.5),lineWidth: 1.5))
                //.modifier(AcceptConnectRequestButtonModifier())
                Button(action: { activityViewModel.acceptConnectRequest(fromUserId: activity.userId) }) {
              
                    Text("Accept")
                        .fontWeight(.bold).foregroundColor(Color.white)
                        .font(.system(size: 10))
                }
                .padding(.horizontal, 5)
                .frame(height: UIScreen.main.bounds.width / 15)
                .background(Color(.systemTeal))
                .background(RoundedRectangle(cornerRadius: 5))
              
                //.modifier(AcceptConnectRequestButtonModifier())
            }
    }
}
