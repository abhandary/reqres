//
//  ReqResUser.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation

struct ReqResUser: Codable {
  
  let avatar: String
  let email: String
  let firstName: String
  let lastName: String
  let id: Int

  enum CodingKeys: String, CodingKey {
    case avatar = "avatar"
    case email = "email"
    case firstName = "first_name"
    case lastName = "last_name"
    case id = "id"
  }
  }
