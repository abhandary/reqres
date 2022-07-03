//
//  ReqResResponse.swift
//  IMDB Movies
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation

struct Response: Codable, Hashable {
    let searchType, expression: String
    let movies: [Movie]
    let errorMessage: String
  
  enum CodingKeys: String, CodingKey {
    case searchType, expression, errorMessage
    case movies = "results"
  }
}
