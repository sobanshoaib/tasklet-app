//
//  MainTabView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-14.
//

import SwiftUI
import FirebaseAuth

struct MainTabView: View {
    var body: some View {
        TabView {
            StreamView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            CreatePostView()
                .tabItem {
                    Image(systemName: "plus.app")
                    Text("Post")
                }
            
            if let thisUser = Auth.auth().currentUser {
                ChatroomsView(iduser: thisUser.uid)
                    .tabItem {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("Chat")
                    }
            } else {
                Text("User not logged in")
                    .tabItem {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("Chat")
                    }
            }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainTabView()
}
