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
        ZStack {
            Color("NavyBlue")
                .ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    Text("Tasks Available")
                        .foregroundStyle(.white)
                        .font(.system(size: 35, design: .rounded))
                        .tracking(4)

                    ForEach(streamVM.allPosts) {post in
                        NavigationLink(destination: EachPostView(secondUserId: "", chatOption: true, postId: post.id)) {
                            HStack {
                                VStack(alignment: .center) {
                                    Text(post.title)
                                        .font(.system(size:40))
                                        .fontWeight(.bold)
                                    Text(post.description)
                                        .font(.title)
                                    Text(post.pay)
                                        .font(.title2)
                                }
                                .foregroundStyle(Color.blue)
                            }
                            .padding()
                            .frame(width: 350, height: 350, alignment: .center)
                            .background(.aqua)
                            .cornerRadius(15)

                        }
                        
                    }
                    .padding(.bottom)
                }
                .background(Color("NavyBlue"))
                .padding()
                .onAppear {
                    streamVM.getAllPosts()
                }
                
            }
            .ignoresSafeArea(edges: .bottom)
            .mask(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .black, location: 0.0),
                        .init(color: .black, location: 0.9),
                        .init(color: .clear, location: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
}


#Preview {
    StreamView()
}
