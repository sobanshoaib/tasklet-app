//
//  MainTabView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-14.
//

import SwiftUI

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
            ChatView()
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right")
                    Text("Chat")
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
