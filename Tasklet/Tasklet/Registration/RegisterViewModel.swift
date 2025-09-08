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
    
    //registers a user in firebase
    func registerUser(firstName: String, lastName: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print("failed to register " + error!.localizedDescription)
            }
            
            guard let user = result?.user else {return}
            
            let userModel = UserModel(id: user.uid,
                                      firstName: firstName,
                                      lastName: lastName,
                                      email: email,
                                      createdAt: Date())
            
            let db = Firestore.firestore()
            do {
                try db.collection("users").document(user.uid).setData(from: userModel) { error in
                    if error != nil {
                        print("firestore error")
                    } else {
                        print("registered success")
                        self.isRegistered = true
                    }
                }
            } catch {
                print("encoding error")
            }
            
        }
    }
    
    
    //logs a user in
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
