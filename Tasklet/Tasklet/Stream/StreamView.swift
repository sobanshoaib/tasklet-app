//
//  StreamView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-26.
//

import SwiftUI

struct StreamView: View {
    @StateObject var streamVM = StreamViewModel()
    var body: some View {
        List(streamVM.allPosts) {post in
            VStack {
                Text(post.title)
                Text(post.description)
                Text(post.pay)
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
