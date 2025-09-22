//
//  ChatViewModel.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-07-15.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    private var db = Firestore.firestore()
    private let chatroomId: String
    
    init(chatroomId: String) {
        self.chatroomId = chatroomId
        recieveMessage()
    }
    
    func sendMessage(content: String, userId: String) {
        
        
        let textId = UUID().uuidString
        let newText = Message(id: textId, chatRoom: chatroomId, userId: userId, content: content, timeStamp: Date())
        
        do {
            _ = try db.collection("texts").addDocument(from: newText)
        } catch {
            print("error when sending message. \(error.localizedDescription)")
        }
    }
    
    
    func recieveMessage() {
        db.collection("texts").order(by: "timeStamp", descending: false)
            .addSnapshotListener { snapshot, err in
                guard let info = snapshot?.documents else {
                    print("error getting messages. \(err?.localizedDescription ?? "error")")
                    return
                }
                
                self.messages = info.compactMap { document in
                    try? document.data(as: Message.self)
                }}
    }
}
