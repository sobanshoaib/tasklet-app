//
//  ChatRoomViewModel.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-09-01.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ChatRoomViewModel: ObservableObject {
    
    @Published var latestRoom: ChatroomModel?
    
    func createChatroom() {
        
        
        let db = Firestore.firestore()
        
        do {
            try db.collection("chatrooms").document().setData(from: chatRoomModel)
        }
        
        
    }
}
