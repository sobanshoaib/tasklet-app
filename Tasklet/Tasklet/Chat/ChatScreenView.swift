//
//  ChatScreenView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-09-18.
//

import SwiftUI

struct ChatScreenView: View {
    
    @State private var textContent = ""
    let personID: String
    var idRoom: String

    @StateObject var chatVM: ChatViewModel

    init(personID: String, idRoom: String) {
        self.personID = personID
        self.idRoom = idRoom
        _chatVM = StateObject(wrappedValue: ChatViewModel(chatroomId: idRoom))
    }
    
    var body: some View {
        ZStack {
            Color("NavyBlue")
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    VStack (alignment: .leading) {
                        ForEach(chatVM.messages) {message in
                            HStack {
                                if message.userId == personID {
                                    Spacer()
                                    Text(message.content)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                        .foregroundStyle(Color.white)
                                } else {
                                    Text(message.content)
                                        .padding()
                                        .background(Color.gray)
                                        .cornerRadius(10)
                                        .foregroundStyle(Color.white)
                                    Spacer()
                                }
                            }
                            .padding()
                        }
                    }
                }
                HStack {
                    TextField("Enter message", text: $textContent)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Send") {
                        chatVM.sendMessage(content: textContent, userId: personID)
                        textContent = ""
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ChatScreenView(personID: "random123", idRoom: "123")
}
