//
//  CreatePostView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-14.
//

import SwiftUI

//title, task, pay

struct CreatePostView: View {
    @State private var postTitle = ""
    @State private var postButton = false
    var body: some View {
        VStack (alignment: .center){
            CreatePostDetails(titlePlaceholder: "Title", getField: $postTitle)
            CreatePostDetails(titlePlaceholder: "Task", getField: $postTitle)
            CreatePostDetails(titlePlaceholder: "Pay", getField: $postTitle)
            
            Button {
                postButton = true
            } label: {
                Text("Post")
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
