//
//  StreamViewModel.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-07-05.
//

import Foundation
import Firebase
import FirebaseFirestore

class StreamViewModel: ObservableObject {
    @Published var allPosts: [PostModel] = []
    
    //returns all the posts from firebase, regardless of who posted
    func getAllPosts() {
        
        let db = Firestore.firestore()
        db.collection("posts").order(by: "createdAt", descending: true).addSnapshotListener { snapshot, error in
            if let documents = snapshot?.documents {
                self.allPosts = documents.compactMap { doc in
                    try? doc.data(as: PostModel.self)
                }
            }
        }
    }
}
