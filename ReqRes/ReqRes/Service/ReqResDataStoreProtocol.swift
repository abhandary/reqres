//
//  ReqResDataStoreProtocol.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation

protocol ReqResDataStoreProtocol {
  func fetchUsers() async -> [ReqResUser]?
  
  func write(response: ReqResResponse) async
}
