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
    @Published var allchatrooms: [ChatroomModel] = []
    
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
            
            let idOfUsers = [userOneId,userTwoId].sorted()
            
            
            print("123")
            
            self.checkChatroomExists(between: idOfUsers) { result in
                
                print("456")
                if let result = result {
                    print("chatroom already exists. ")
                    completion(result)
                    return
                }
                
                let chatroomId = UUID().uuidString
                print("chatroom id is: \(chatroomId)")
                
                let chatroomModel = ChatroomModel(id: chatroomId, users: idOfUsers, lastUpdated: Date())
                
                
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
    
    func checkChatroomExists(between idOfUsers: [String], completion: @escaping (String?) -> Void) {
        
        print("789")
        guard idOfUsers.count == 2 else {
            completion(nil)
            return
        }
        
        let idOrdered = idOfUsers.sorted()
        
        db.collection("chatrooms").whereField("users", isEqualTo: idOrdered)
            .getDocuments { info, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                
                if let doc = info?.documents.first {
                    print("chatroom exists between users")
                    completion(doc.documentID)
                } else {
                    completion(nil)
                }
            }
    
    }
    
    func getChatrooms() {

        
        guard let loggedIn = Auth.auth().currentUser else {
            print("user not logged in")
            return
        }
        
        let thisId = loggedIn.uid
        db.collection("chatrooms").whereField("users", arrayContains: thisId).order(by: "lastUpdated", descending: true).addSnapshotListener { snapshot, error in
            
            if let error = error {
                print("error when getting chatrooms: \(error)")
                return
            }
            if let snapshot = snapshot?.documents {
                self.allchatrooms = snapshot.compactMap { doc in
                    try? doc.data(as: ChatroomModel.self)}
            }
        }

    }
    
}
