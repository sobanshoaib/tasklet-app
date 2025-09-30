//
//  ChatroomsView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-09-13.
//

import SwiftUI
import FirebaseAuth

struct ChatroomsView: View {
    @StateObject var chatroomVM = ChatroomViewModel()
    var iduser: String
    
    var body: some View {
            ScrollView {
                LazyVStack {
                    ForEach(chatroomVM.allchatrooms) { chatroom in
                        NavigationLink(destination: ChatScreenView(personID: iduser, idRoom: chatroom.id)) {
                            HStack(alignment: .center) {
                                VStack {
                                    Text("Convo is between: ")
                                    Text(chatroom.users.first ?? "unknown")
                                    Text(chatroom.users.last ?? "unknown")
                                    Text("Last updated: \(chatroom.lastUpdated)")
                                }
                                .background(.green)
                                
                                Spacer()
                                

                                }
                            }
                        }
                    }
                }
            .onAppear {
                chatroomVM.getChatrooms()
            }

        }
            
    }


#Preview {
    ChatroomsView(iduser: "randomperson")
}
