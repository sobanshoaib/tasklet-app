//
//  UserService.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-09-04.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

//replaced profileviewmodel for now. this logic is user for the profile page

public class UserService: ObservableObject {
   
    static let shared = UserService() //singleton, so can be used in other files
    
    @Published var user: UserModel?
    
    func getUserProfile(completion: @escaping (UserModel?) -> Void) {
        guard let userid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        let db = Firestore.firestore()
        do {
            db.collection("users").document(userid).getDocument { snapshot, error in
                if let error = error {
                    print("user not fetched: ", error.localizedDescription)
                    completion(nil)
                    return
                }
                
                
                if let document = snapshot {
                    if document.exists {
                        do {
                            if let getUser = try document.data(as: UserModel?.self) {
                                self.user = getUser
                                completion(self.user)
                            } else {
                                completion(nil)
                            }
                        } catch {
                            print("Error encoding: ", error)
                            completion(nil)
                        }
                    }
                }
            }
        }
    }
}
