//
//  UserModel.swift
//  Tasklet
//
//  Created by Soban Shoaib on 2025-06-14.
//

import Foundation


struct UserModel: Identifiable, Codable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var createdAt: Date
}
