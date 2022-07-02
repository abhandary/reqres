//
//  ReqResNetworkLoader.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation

actor ReqResNetworkLoader: ReqResNetworkLoaderProtocol {
  func queryForUsers() async -> ReqResResponse? {
    let url = URL(string: "https://reqres.in/api/users/")
    
    guard let url = url else {
      print("error unwrapping url")
      return nil
    }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let response = try JSONDecoder().decode(ReqResResponse.self, from: data)
      print("Success \(response)")
      return response
    }
    catch {
      print("Network request and decoding failed - \(error)")
    }
    return nil
  }
}
