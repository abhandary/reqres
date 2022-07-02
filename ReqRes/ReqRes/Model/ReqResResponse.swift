//
//  ReqResResponse.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation

struct ReqResResponse: Codable {
  let users: [ReqResUser]
  
  enum CodingKeys: String, CodingKey {
    case users = "data"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    users = try container.decode([ReqResUser].self, forKey: .users)
  }
}
