//
//  CreatePostViewModel.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-14.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class CreatePostViewModel: ObservableObject {
    
    @Published var latesPost: PostModel?
    
    
    func createPost(postTitle: String, postDescription: String, postPay: String, completion: @escaping (String?) -> Void) {
        
        //check user is logged in
        guard let user = Auth.auth().currentUser else {
            print("user not logged in")
            completion(nil)
            return
        }
        
        print(user)

        
        //creates unique identifier
        let postId = UUID().uuidString
        
        //from model we made
        //the user.uid at the end links the post to the user that made it
        let postModel = PostModel(id: postId, title: postTitle, description: postDescription, pay: postPay, createdAt: Date(), userId: user.uid)
        
        let db = Firestore.firestore()
        do {
            try db.collection("posts").document(postId).setData(from: postModel) {error in
                if error != nil {
                    print("firestore error, post didn't store")
                    completion(nil)
                } else {
                    print("post stored successfully")
                    completion(postId)
                    DispatchQueue.main.async {
                        self.latesPost = postModel
                    }
                }
            }
        } catch {
            print("encoding error")
            completion(nil)
        }

    }
    
}
