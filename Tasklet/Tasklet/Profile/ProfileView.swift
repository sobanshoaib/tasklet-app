//
//  ProfileView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-14.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var userService = UserService.shared
    @State private var logoutApp = false
    var body: some View {
        VStack {
            if let user = userService.user {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("Name: \(user.firstName) \(user.lastName)")
                Text("Emai: \(user.email)")
            } else {
                ProgressView("Loading")
            }
            Button {
                logoutApp = true
            } label: {
                Text("Logout")
            }
            NavigationLink(destination: LoginView(), isActive: $logoutApp) {
                EmptyView()
            }
        }
        .onAppear {
            UserService.shared.getUserProfile { user in
                if let user = user {
                    print("user loader.")
                } else {
                    print("user failed to load.")
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
