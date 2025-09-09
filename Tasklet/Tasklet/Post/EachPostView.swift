//
//  EachPostView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-26.
//

import SwiftUI

struct EachPostView: View {
    @StateObject private var eachPostVM = EachPostViewModel()
    var previewMode: Bool = false
    var chatOption: Bool
    let postId: String
    var body: some View {
        VStack {
            if let post = eachPostVM.post {
                Text("Your post:")
                Text("Author is: \(post.firstName)")
                Text("Title is: \(post.title)")
                Text("Description is: \(post.description)")
                Text("Pay is: \(post.pay)")
            } else {
                Text("Loading...")
            }
            
            if (chatOption == true) {
                Image(systemName: "bubble.left.and.bubble.right")
            }
        }
        .background(.red)
        .onAppear {
            if previewMode {
                eachPostVM.post = PostModel(
                    id: "sample", title: "previewposttitle", description: "postdescription", pay: "99", createdAt: Date(), firstName: "john", userId: "randomid"
                )
            } else {
                eachPostVM.getPost(withId: postId)
            }
        }
    }
}

#Preview {
    EachPostView(previewMode: true, chatOption: false, postId: "previewid")
}
