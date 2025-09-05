//
//  StreamView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-26.
//

import SwiftUI

struct StreamView: View {
    @StateObject var streamVM = StreamViewModel()
    @StateObject var chatroomVM = ChatRoomViewModel()
    
    var body: some View {
        List(streamVM.allPosts) {post in
            HStack {
                VStack {
                    Text(post.title)
                    Text(post.description)
                    Text(post.pay)
                }
                Spacer()

                NavigationLink(destination: ChatRoomsView()) {
                    Image(systemName: "bubble.left.and.bubble.right")
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
