//
//  CreatePostView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-14.
//

import SwiftUI

//title, task, pay

struct CreatePostView: View {
    @StateObject private var createPostVM = CreatePostViewModel()
    @State private var postTitle = ""
    @State private var postDescription = ""
    @State private var postPay = ""
    @State private var postButton = false
    @State private var createPostId: String?
    
    var body: some View {
        ZStack {
            Color("NavyBlue")
                .ignoresSafeArea()
            VStack (alignment: .center){
                Text("Tasks Available")
                    .foregroundStyle(.white)
                    .font(.system(size: 35, design: .rounded))
                    .tracking(4)
                CreatePostDetails(titlePlaceholder: "Title", getField: $postTitle)
                CreatePostDetails(titlePlaceholder: "Description", getField: $postDescription)
                CreatePostDetails(titlePlaceholder: "Pay", getField: $postPay, whichKeyboard: .numberPad)
                    
                
                Button {
                    createPostVM.createPost(postTitle: postTitle, postDescription: postDescription, postPay: postPay)
                    {newestId in
                        if let id = newestId {
                            createPostId = id
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                postButton = true
                            }
                        }}
                } label: {
                    Text("Post")
                        .foregroundStyle(.aqua)
                }
                .frame(width: 100, height: 50)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(Color.trueBlue))
                .padding(.bottom)
                
                NavigationLink(destination: EachPostView(secondUserId: "", chatOption: false, postId: createPostId ?? ""), isActive: $postButton) {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    CreatePostView()
}

struct CreatePostDetails: View {
    
    var titlePlaceholder: String
    @Binding var getField: String
    var whichKeyboard: UIKeyboardType = .default
    
    var body: some View {
        TextField(titlePlaceholder, text: $getField)
            .keyboardType(whichKeyboard)
            .onChange(of: getField) { thisText in
                if whichKeyboard == .numberPad {
                    getField = thisText.filter { $0.isNumber}
                }}
            .foregroundStyle(.white)
            .frame(width: 300, height: 50)
            .background(Color("TextBlue"))
            .padding()
        
    }
}
