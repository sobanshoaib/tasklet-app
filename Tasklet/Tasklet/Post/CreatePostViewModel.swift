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
    
    @Published var latestPost: PostModel?
    
    
    func createPost(postTitle: String, postDescription: String, postPay: String, completion: @escaping (String?) -> Void) {
        
        
        //all the logic, including storing the post, is because we need the firstname, hence the user, cause this is when the user data is availaible. anything that needs user has to be inside the closure
        UserService.shared.getUserProfile { user in
            guard let firstNameUser = user?.firstName else {
                print("Did not get first name.")
                completion(nil)
                return
            }
            
            
            //check user is logged in
            guard let user = Auth.auth().currentUser else {
                print("user not logged in")
                completion(nil)
                return
            }
            
            
            
            
            //creates unique identifier
            let postId = UUID().uuidString
            
            //from model we made
            //the user.uid at the end links the post to the user that made it
            let postModel = PostModel(id: postId, title: postTitle, description: postDescription, pay: postPay, createdAt: Date(), firstName: firstNameUser, userId: user.uid)
            
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
                            self.latestPost = postModel
                        }
                    }
                }
            } catch {
                print("encoding error")
                completion(nil)
            }
            
        }
        
    }
}
