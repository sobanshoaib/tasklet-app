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

class ChatroomViewModel: ObservableObject {
    
    @Published var latestRoom: ChatroomModel?
    
    let db = Firestore.firestore()
    
    func createChatroom(userTwoId: String, completion: @escaping (String?) -> Void) {
        
        
        //get the current user
        UserService.shared.getUserProfile {user in
            guard let userOneId = user?.id else {
                print("did not get user one's id.")
                completion(nil)
                return 
            }
            
            //check user is logged in
            guard let user = Auth.auth().currentUser else {
                print("user not logged in")
                completion(nil)
                return
            }
            
            if (userOneId == userTwoId) {
                print("same person. ")
                completion(nil)
                return
            }
            
            
            print("123")
            
            self.checkChatroomExists(userOne: userOneId, userTwo: userTwoId) { result in
                
                print("456")
                if let result = result {
                    print("chatroom already exists. ")
                    completion(result)
                    return
                }
                
                let chatroomId = UUID().uuidString
                print("chatroom id is: \(chatroomId)")
                
                let chatroomModel = ChatroomModel(id: chatroomId, userOne: userOneId, userTwo: userTwoId, lastUpdated: Date())
                
                
                do {
                    try self.db.collection("chatrooms").document(chatroomId).setData(from: chatroomModel) {error in
                        if (error != nil) {
                            print("firestore error. did not create chatroom")
                            completion(nil)
                            return
                        } else {
                            //encodes the chatroomModel object
                            print("chatroom created")
                            completion(chatroomId)
                            DispatchQueue.main.async {
                                self.latestRoom = chatroomModel
                            }
                            return
                        }}
                    
                } catch {
                    print("encoding error from creating chatroom")
                    completion(nil)
                    return
                }
                
                
            }

        }
    }
    
    func checkChatroomExists(userOne: String, userTwo: String, completion: @escaping (String?) -> Void) {
        
        print("789")
        let variationFirst = db.collection("chatrooms")
            .whereField("userOne", isEqualTo: userOne)
            .whereField("userTwo", isEqualTo: userTwo)
        
        let variationSecond = db.collection("chatrooms")
            .whereField("userOne", isEqualTo: userTwo)
            .whereField("userTwo", isEqualTo: userOne)
        
        print("1")
        variationFirst.getDocuments { snapshot, _ in
            if let snapshot = snapshot {
                if snapshot.documents.count > 0 {
                    print("chatroom found between \(userOne) and \(userTwo)")
                    completion("randomchatroomdoc")
                    return
                }
            }
            print("2")
            
            variationSecond.getDocuments { snapshot, _ in
                if let snapshot = snapshot {
                    if snapshot.documents.count > 0 {
                        print("chatroom found between \(userOne) and \(userTwo)")
                        let roomId = snapshot.documents.first?.documentID
                        completion(roomId)
                        return
                    }
                }
                completion(nil)
            }
            print("3")
        }
        print("4")
    
    }
    
}
