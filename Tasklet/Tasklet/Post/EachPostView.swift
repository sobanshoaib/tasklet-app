//
//  EachPostView.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-26.
//

import SwiftUI
import FirebaseAuth 

struct EachPostView: View {
    @StateObject private var eachPostVM = EachPostViewModel()
    @StateObject private var chatroomVM = ChatroomViewModel()
    var secondUserId: String
    var previewMode: Bool = false
    var chatOption: Bool
    let postId: String

    private var thisUserPost: Bool {
        guard let thisUserId = Auth.auth().currentUser?.uid,
        let postIdWho = eachPostVM.post?.userId else {
            return false 
        }
        return thisUserId == postIdWho 

    }
    var body: some View {
        
        ZStack {
            Color("NavyBlue")
                .ignoresSafeArea()
            VStack {
                if let post = eachPostVM.post {
                    Text("Title is: \(post.title)")
                    Text("Description is: \(post.description)")
                    Text("Pay is: \(post.pay)")
                } else {
                    Text("Loading...")
                }
                
                if (chatOption == true && !thisUserPost) {
                    Button {
                        chatroomVM.createChatroom(userTwoId: eachPostVM.post?.userId ?? "123") {roomId in
                            if let roomId = roomId {
                                print("chatoom made. id is: \(roomId)")
                            } else {
                                print("chatoom failed to be created.")
                            }}
                    } label: {
                        Image(systemName: "bubble.left.and.bubble.right")
                    }
                }
            }
            .foregroundStyle(Color.blue)
            .frame(width: 250, height: 250, alignment: .center)
            .background(.aqua)
            .cornerRadius(15)
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
}

#Preview {
    EachPostView(secondUserId: "seconduser", previewMode: true, chatOption: false, postId: "previewid")
}
