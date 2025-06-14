//
//  LoginView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-11.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = RegisterViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var clickRegister = false
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient (colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    Text("Login to Tasklet")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding(.bottom)
                    
                    LoginFieldView(loginPlaceholder: "Email", getInput: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    HStack (alignment: .center){
                        SecureField("Password", text: $password)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .frame(width: 300, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .padding(.bottom)
                    
                    Button {
                        viewModel.loginUser(email: email, password: password)
                    } label: {
                        Text("Login")
                    }
                    .frame(width: 100, height: 50)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .fill(Color.teal))
                    .padding(.bottom)
                    
                    NavigationLink(destination: HomeView(), isActive: $viewModel.isLoggedIn) {
                        EmptyView()
                    }
                    
                    HStack {
                        Text("Don't have an account?")
                        Button {
                            clickRegister = true
                        } label: {
                            Text("Register")
                                .foregroundStyle(.white)
                                .underline()
                        }
                    }
                    NavigationLink(destination: RegisterView(), isActive: $clickRegister) {
                        EmptyView()
                    }
                    
                    
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    LoginView()
}

struct LoginFieldView: View {
    var loginPlaceholder: String
    @Binding var getInput: String
    var body: some View {
        HStack (alignment: .center){
            TextField(loginPlaceholder, text: $getInput)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(width: 300, height: 50)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white, lineWidth: 2)
        )
        .padding(.bottom)
    }
}
