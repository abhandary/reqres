//
//  ReqResDataStore.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation

actor ReqResDataStore: ReqResDataStoreProtocol {
  
  let encoder = PropertyListEncoder()
  let decoder = PropertyListDecoder()
  
  init() {
    encoder.outputFormat = .binary
  }
  
  func fetchUsers() async -> [ReqResUser]? {
    
    guard let fileURL = getFileURL() else {
      print("error: unable to get file URL")
      return nil
    }
    
    do {
      let savedData = try Data(contentsOf: fileURL)
      let savedResponse
          = try decoder.decode(ReqResResponse.self, from: savedData)
      print("###### saved resonse users - \(savedResponse.users)")
      return savedResponse.users
    } catch {
      print("Couldn't read file. - \(error)")
    }
    return nil
  }
  
  func write(response: ReqResResponse) async {
    
    guard let fileURL = getFileURL() else {
      print("error: unable to get file URL")
      return
    }
    
    do {
      
      let data = try encoder.encode(response)
      try data.write(to: fileURL)
    } catch {
      print(error)
    }
  }
  
  private func getFileURL() -> URL? {
    let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    guard fileURLs.count > 0 else {
      return nil
    }
    let directoryURL = fileURLs.first
    return URL(fileURLWithPath: "reqres_users_response", relativeTo: directoryURL)
  }
}


