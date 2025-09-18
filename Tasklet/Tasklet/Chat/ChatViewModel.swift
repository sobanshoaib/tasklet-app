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
    
    init() {
        recieveMessage()
    }
    
    func sendMessage(content: String, userId: String) {
        
        let textId = UUID().uuidString
        let newText = Message(id: textId, chatRoom: <#T##String#>, userId: userId, content: content, timeStamp: Date())
    }
    
    
    func recieveMessage() {
        
    }
}
