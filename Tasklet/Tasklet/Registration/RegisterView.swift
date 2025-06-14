//
//  RegisterView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-11.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = RegisterViewModel()
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var clickLogin = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient (colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    Text("Welcome to Tasklet!")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    Text("Please register below")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding(.bottom)
                    
                    RegisterFieldView(registerPlaceholder: "First Name", getInput: $firstName)
                    RegisterFieldView(registerPlaceholder: "Last Name", getInput: $lastName)
                    RegisterFieldView(registerPlaceholder: "Email", getInput: $email)
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
                        viewModel.registerUser(firstName: firstName, lastName: lastName, email: email, password: password)
                    } label: {
                        Text("Register")
                            .foregroundStyle(.blue)
                    }
                    .frame(width: 100, height: 50)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .fill(Color.teal))
                    .padding(.bottom)
                    NavigationLink(destination: LoginView(), isActive: $viewModel.isRegistered) {
                        EmptyView()
                    }
                    
                    HStack {
                        Text("Already have an account?")
                        Button {
                            clickLogin = true
                        } label: {
                            Text("Login")
                                .foregroundStyle(.white)
                        }
                    }
                    NavigationLink(destination: LoginView(), isActive: $clickLogin) {
                        EmptyView()
                    }

                    
                }
            }
            
        }
        
    }
}

#Preview {
    RegisterView()
}

struct RegisterFieldView: View {
    var registerPlaceholder: String
    @Binding var getInput: String
    var body: some View {
        HStack (alignment: .center){
            TextField(registerPlaceholder, text: $getInput)
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
