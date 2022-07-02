//
//  IReqResNetworkLoader.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation

protocol ReqResNetworkLoaderProtocol {
  func queryForUsers() async -> ReqResResponse?
}