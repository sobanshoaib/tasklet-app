//
//  ChatroomsView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-09-13.
//

import SwiftUI

struct ChatroomsView: View {
    @StateObject var chatroomVM = ChatroomViewModel()
    
    var body: some View {
        List(chatroomVM.allchatrooms) { chatroom in
            VStack {
                Text("Convo is between: ")
                Text(chatroom.userOne)
                Text(chatroom.userTwo)
                Text("Last updated: \(chatroom.lastUpdated)")
            }
            .background(.green)
        }
        .onAppear {
            chatroomVM.getChatrooms()
        }
    }
}

#Preview {
    ChatroomsView()
}
