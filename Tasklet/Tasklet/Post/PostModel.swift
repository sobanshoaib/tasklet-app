//
//  PostModel.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-14.
//

import Foundation


struct PostModel: Identifiable, Codable {
    var id: String
    var title: String
    var description: String
    var pay: String
    var createdAt: Date
    var userId: String
}
