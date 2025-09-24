//
//  ChatroomsView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-09-13.
//

import SwiftUI

struct ChatroomsView: View {
    @StateObject var chatroomVM = ChatroomViewModel()
    var iduser: String
    
    var body: some View {
        NavigationView {
            List(chatroomVM.allchatrooms) { chatroom in
                HStack {
                    VStack {
                        Text("Convo is between: ")
                        Text(chatroom.userOne)
                        Text(chatroom.userTwo)
                        Text("Last updated: \(chatroom.lastUpdated)")
                    }
                    .background(.green)
                    
                    Spacer()
                    
                    NavigationLink(destination: ChatScreenView(personID: iduser, idRoom: chatroom.id)) {
                        Image(systemName: "message.fill")
                    }
                }
            }
            .onAppear {
                chatroomVM.getChatrooms()
            }
        }
    }
}

#Preview {
    ChatroomsView(iduser: "randomperson")
}
