//
//  ProfileView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-14.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var profileviewmodel = ProfileVIewModel()
    @State private var logoutApp = false
    var body: some View {
        VStack {
            if let user = profileviewmodel.user {
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
            profileviewmodel.getUserProfile()
        }
    }
}

#Preview {
    ProfileView()
}
