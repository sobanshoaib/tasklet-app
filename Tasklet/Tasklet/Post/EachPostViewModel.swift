//
//  EachPostViewModel.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-26.
//

import Foundation
import FirebaseFirestore

class EachPostViewModel: ObservableObject {
    @Published var post: PostModel?
    
    func getPost(withId postId: String) {
        
        guard !postId.isEmpty else {
            print("empty postid")
            return
        }

        
        let db = Firestore.firestore()
        
        do {
            db.collection("posts").document(postId).getDocument { snapshot, error in
                if let error = error {
                    print("post not found. ", error.localizedDescription)
                    return
                }
                
                guard let document = snapshot, document.exists else {
                    print("no document found")
                    return
                }
                
                if let document = snapshot {
                    if document.exists {
                        do {
                            self.post = try document.data(as: PostModel.self)
                        } catch {
                            print("encoding error")
                        }
                    }
                }
            }
        }
    }
}



