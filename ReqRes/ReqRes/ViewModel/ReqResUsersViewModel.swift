//
//  ReqResUsersViewModel.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation

class ReqResUsersViewModel {
  
  var networkLoader: ReqResNetworkLoaderProtocol!
  var dataStorage: ReqResDataStoreProtocol!
  
  init(networkLoader: ReqResNetworkLoaderProtocol,
       dataStorage: ReqResDataStoreProtocol) {
    self.networkLoader = networkLoader
    self.dataStorage = dataStorage
  }
  
  @MainActor var users: [ReqResUser] = []
  
  func fetchUsers() async {
    
    print("###### fetchUsers")
    // fetch from data store
    await fetchFromDataStoreAndUpdate()
    
    // async fetch from network and update and notify
    async {
      // fetch from network simultaneously
      if let response = await networkLoader.queryForUsers() {
        print("### writing network response to data store")
        await dataStorage.write(response: response)
        await fetchFromDataStoreAndUpdate()
      }
    }
  }
  
  private func fetchFromDataStoreAndUpdate() async {
    print("###### fetchFromDataStoreAndUpdate")
    if let users = await dataStorage.fetchUsers() {
      await MainActor.run {
        print("####### setting users")
        self.users = users
      }
    }
  }
}
