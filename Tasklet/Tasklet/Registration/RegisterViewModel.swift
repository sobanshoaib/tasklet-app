//
//  RegisterViewModel.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-11.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var isRegistered = false
    func registerUser(firstName: String, lastName: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("failed to register " + error!.localizedDescription)
            }
            
            guard let user = result?.user else {return}
            
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).setData([
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "createdAt": Timestamp()
            ]) { error in
                if let error = error {
                    print("firestore error")
                } else {
                    print("registered success")
                    self.isRegistered = true
                }
            }
            
        }
    }
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print("failed to log in " + error!.localizedDescription)
            } else {
                print("login success")
                self.isLoggedIn = true
            }
            
        }
    }
}
