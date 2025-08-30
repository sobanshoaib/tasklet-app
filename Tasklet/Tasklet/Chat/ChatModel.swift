//
//  ChatModel.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-07-15.
//

import Foundation


struct ChatroomModel: Identifiable, Codable {
    var id: String
    var userOne: String
    var userTwo: String
    var lastUpdated: Date
}

struct Message {
    var id: String
    var chatRoom: String
    var userId: String
    var content: String
    var timeStamp: Date
}
