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
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel

    
    var body: some View {
       
        NavigationView {
            List {
                if !activityViewModel.activityArray.isEmpty {
                    ForEach(self.activityViewModel.activityArray, id: \.activityId) { activity in
                          HStack {
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
                                                             }).frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(activity.username).font(.subheadline).bold()
                                    Text(activity.typeDescription).font(.subheadline)
                                }
                                Spacer()
                                Text(timeAgoSinceDate(Date(timeIntervalSince1970: activity.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                            }
                       

                        }.padding(10)
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
        HStack {
            URLImage(URL(string: activity.userAvatar)!,
                                         content: {
                                             $0.image
                                                 .resizable()
                                                 .aspectRatio(contentMode: .fill)
                                                 .clipShape(Circle())
                                         }).frame(width: 50, height: 50)
            HStack{
                VStack(alignment: .leading) {
                    HStack{
                        Text(activity.username).font(.subheadline).bold()
                        Spacer()
                        Text(timeAgoSinceDate(Date(timeIntervalSince1970: activity.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                    }
                    Spacer()
                    HStack{
                        Text(activity.typeDescription).font(.subheadline)
                        Spacer()
                        RespondToConnectRequestRow(activity: activity)
                    }
                 
                }
            }
            
        }
    }
}

struct RespondToConnectRequestRow: View {
    var activity: Activity
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
    var body: some View {
        
        HStack {
                Button(action: { connectionsViewModel.ignoreConnectRequest(fromUserId: activity.userId) }) {
                   
                    Text("Ignore")
                        .fontWeight(.bold).foregroundColor(Color.black)
                        .font(.system(size: 10))
                }
                .padding(.horizontal, 5)
                .frame(height: UIScreen.main.bounds.width / 15)
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color(.gray).opacity(0.5),lineWidth: 1.5))
                //.modifier(AcceptConnectRequestButtonModifier())
                Button(action: { connectionsViewModel.acceptConnectRequest(fromUserId: activity.userId) }) {
              
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
