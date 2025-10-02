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
        ZStack {
            Color("NavyBlue")
                .ignoresSafeArea()
            VStack {
                Text("Profile")
                    .foregroundStyle(.white)
                    .font(.system(size: 35, design: .rounded))
                    .tracking(4)
                if let user = userService.user {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(Color.white)
                        .padding(.bottom)
                    VStack {
                        Text("Name: \(user.firstName) \(user.lastName)")
                        Text("Emai: \(user.email)")
                    }
                    .foregroundStyle(.white)
                    .padding([.top, .bottom])
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
}

#Preview {
    ProfileView()
}
