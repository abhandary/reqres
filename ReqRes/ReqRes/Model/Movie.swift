//
//  ReqResUser.swift
//  IMDB Movies
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation

struct Movie: Codable, Hashable {
  let id, resultType: String
  let image: String
  let title, resultDescription: String
  
  enum CodingKeys: String, CodingKey {
    case id, resultType, image, title
    case resultDescription = "description"
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  public static func == (lhs: Movie, rhs: Movie) -> Bool {
    return lhs.id == rhs.id
  }
}
