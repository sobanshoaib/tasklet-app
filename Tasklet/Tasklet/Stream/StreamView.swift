//
//  StreamView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-26.
//

//logic for this file would be, show all the posts from firebase. for each post, we need to click on it, and see the individual post. so need to fetch the postid, pass it in navigation, so eachpostview uses that id to show the post

import SwiftUI

struct StreamView: View {
    @StateObject var streamVM = StreamViewModel()
    
    var body: some View {
        List(streamVM.allPosts) {post in
            HStack {
                VStack {
                    Text(post.title)
                    Text(post.description)
                    Text(post.pay)
                }
                Spacer()

                NavigationLink(destination: EachPostView(chatOption: true, postId: post.id)) {
                    Image(systemName: "bubble.left.and.bubble.right")
                    EmptyView()
                }

            }
        }
        .onAppear {
            streamVM.getAllPosts()
        }
    }
}

#Preview {
    StreamView()
}
