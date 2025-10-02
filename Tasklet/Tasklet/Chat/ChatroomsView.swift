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
        ZStack {
            Color("NavyBlue")
                .ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    Text("Chat List")
                        .foregroundStyle(.white)
                        .font(.system(size: 35, design: .rounded))
                        .tracking(4)
                    ForEach(chatroomVM.allchatrooms) { chatroom in
                        NavigationLink(destination: ChatScreenView(personID: iduser, idRoom: chatroom.id)) {
                            HStack {
                                VStack {
                                    let otherUserId = chatroom.users.first(where:
                                        { $0 != iduser }) ?? ""
                                    Text(chatroomVM.userNames[otherUserId] ?? "user known")
                                }
                                Spacer()
                            }
                            .padding()
//                            .padding([.leading, .trailing])
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.aqua, lineWidth: 3)
                                )
                        }
                    }
                }
                .padding([.leading, .trailing])
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
