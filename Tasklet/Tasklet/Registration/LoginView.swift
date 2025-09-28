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
                Color("NavyBlue")
                    .ignoresSafeArea()
                VStack {
                    Text("Login to Tasklet")
                        .foregroundStyle(.trueBlue)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    
                    LoginFieldView(loginPlaceholder: "Email", getInput: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    HStack (alignment: .center){
                        SecureField("Password", text: $password)
                            .foregroundStyle(.aqua)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .frame(width: 300, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.aqua, lineWidth: 2)
                    )
                    .padding(.bottom)
                    
                    Button {
                        viewModel.loginUser(email: email, password: password)
                    } label: {
                        Text("Login")
                            .foregroundStyle(.aqua)
                    }
                    .frame(width: 100, height: 50)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .fill(Color.trueBlue))
                    .padding(.bottom)
                    
                    NavigationLink(destination: MainTabView(), isActive: $viewModel.isLoggedIn) {
                        EmptyView()
                    }
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundStyle(.blue)

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
                .foregroundStyle(.aqua)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(width: 300, height: 50)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.aqua, lineWidth: 2)
        )
        .padding(.bottom)
    }
}
