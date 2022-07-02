//
//  ReqResSupport.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation

struct ReqResSupport: Codable {
  let text: String
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case text = "text"
    case url = "url"
  }
}
