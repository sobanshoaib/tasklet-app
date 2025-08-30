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
                Color("ArgentinianBlue")
                    .ignoresSafeArea()
                VStack {
                    Text("Welcome to Tasklet!")
                        .foregroundStyle(.trueBlue)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    Text("Please register below")
                        .foregroundStyle(.trueBlue)
                        .font(.headline)
                        .padding(.bottom)
                    
                    RegisterFieldView(registerPlaceholder: "First Name", getInput: $firstName)
                    RegisterFieldView(registerPlaceholder: "Last Name", getInput: $lastName)
                    RegisterFieldView(registerPlaceholder: "Email", getInput: $email)
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
                        viewModel.registerUser(firstName: firstName, lastName: lastName, email: email, password: password)
                    } label: {
                        Text("Register")
                            .foregroundStyle(.aqua)
                    }
                    .frame(width: 100, height: 50)
                    .background(RoundedRectangle(cornerRadius: 12)
                        .fill(Color.trueBlue))
                    .padding(.bottom)
                    NavigationLink(destination: LoginView(), isActive: $viewModel.isRegistered) {
                        EmptyView()
                    }
                    
                    HStack {
                        Text("Already have an account?")
                            .foregroundStyle(.plum)
                        Button {
                            clickLogin = true
                        } label: {
                            Text("Login")
                                .foregroundStyle(.white)
                                .underline()
                        }
                    }
                    NavigationLink(destination: LoginView(), isActive: $clickLogin) {
                        EmptyView()
                    }
                    
                    

                }
            }
            .navigationBarBackButtonHidden(true)
            
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
