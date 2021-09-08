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
                    ForEach(self.activityViewModel.activityArray, id: \.id) { activity in
                          HStack {
                            if activity.type == .comment {
                                ZStack {
                                    NotificationEntry(activity: activity)
//                                    NavigationLink(destination: CommentView(postId: activity.postId)) {
//                                        EmptyView()
//                                    }
                                }
                            } else if activity.type == .connectRequest {
                                ZStack {
                                    CommentActivityRow(activity: activity, activityViewModel: self.activityViewModel)
                                }
                            } else {
//                                URLImage(URL(string: activity.mediaUrl)!,
//                                                             content: {
//                                                                 $0.image
//                                                                     .resizable()
//                                                                     .aspectRatio(contentMode: .fill)
//                                                                     .clipShape(Circle())
//                                                             }).frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(activity.connectionName ?? "").font(.subheadline).bold()
                                    Text(activity.notificationMessage).font(.subheadline)
                                }
                                Spacer()
                                TimeAgoStamp(date: Double(activity.createdAt?.seconds ?? 0))
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
    var activity: ActivityEvent
    var activityViewModel: ActivityViewModel
    var body: some View {
        HStack {
            URLImage(URL(string: activity.mediaUrl!)!,
                                         content: {
                                             $0.image
                                                 .resizable()
                                                 .aspectRatio(contentMode: .fill)
                                                 .clipShape(Circle())
                                         }).frame(width: 50, height: 50)
            HStack{
                VStack(alignment: .leading) {
                    HStack{
                        Text(activity.connectionName ?? "").font(.subheadline).bold()
                        Spacer()
//                        TimeAgoStamp(date: Double(activity.createdAt?.seconds ?? 0))
                    }
                    Spacer()
                    HStack{
                        Text(activity.notificationMessage).font(.subheadline)
                        Spacer()
                        RespondToConnectRequestRow(activity: activity)
                    }
                 
                }
            }
            
        }
    }
}

struct RespondToConnectRequestRow: View {
    var activity: ActivityEvent
    @EnvironmentObject var activityViewModel: ActivityViewModel
    var body: some View {
        
        HStack {
                Button(action: { activityViewModel.ignoreConnectRequest(fromUserId: activity.connectionId) }) {
                   
                    Text("Ignore")
                        .fontWeight(.bold).foregroundColor(Color.black)
                        .font(.system(size: 10))
                }
                .padding(.horizontal, 5)
                .frame(height: UIScreen.main.bounds.width / 15)
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color(.gray).opacity(0.5),lineWidth: 1.5))
                //.modifier(AcceptConnectRequestButtonModifier())
                Button(action: { activityViewModel.acceptConnectRequest(fromUserId: activity.connectionId) }) {
              
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
