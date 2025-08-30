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
        VStack (alignment: .center){
            CreatePostDetails(titlePlaceholder: "Title", getField: $postTitle)
            CreatePostDetails(titlePlaceholder: "Description", getField: $postDescription)
            CreatePostDetails(titlePlaceholder: "Pay", getField: $postPay)
            
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
            }
            NavigationLink(destination: EachPostView(postId: createPostId ?? ""), isActive: $postButton) {
                EmptyView()
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
    
    var body: some View {
        TextField(titlePlaceholder, text: $getField)
            .textFieldStyle(.roundedBorder)
            .padding()
    }
}
