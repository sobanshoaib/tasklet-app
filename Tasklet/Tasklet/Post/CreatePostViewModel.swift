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
    
    func createPost(postTitle: String, postDescription: String, postPay: String) {
        
        guard let user = Auth.auth().currentUser else {
            print("user not logged in")
            return
        }
        print("user is", user)
        
        let postId = UUID().uuidString
        
        let postModel = PostModel(id: postId, title: postTitle, description: postDescription, pay: postPay, createdAd: Date(), userId: user.uid)
        
        let db = Firestore.firestore()
        do {
            try db.collection("posts").document(postId).setData(from: postModel) {error in
                if error != nil {
                    print("firestore error, post didn't store")
                } else {
                    print("post stored successfully")
                }
            }
        } catch {
            print("encoding error")
        }

    }
    
}
