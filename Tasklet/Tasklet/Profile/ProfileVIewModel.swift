//
//  ProfileVIewModel.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-17.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth


class ProfileVIewModel: ObservableObject {
    @Published var user: UserModel?
    
    func getUserProfile() {
        guard let userid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        do {
            db.collection("users").document(userid).getDocument { snapshot, error in
                if let error = error {
                    print("user not fetched", error.localizedDescription)
                    return
                }
                
                
                if let document = snapshot {
                    if document.exists {
                        do {
                            self.user = try document.data(as: UserModel.self)
                        } catch {
                            print("error encoding")
                        }
                    }
                }
            }
        }
    }
}
