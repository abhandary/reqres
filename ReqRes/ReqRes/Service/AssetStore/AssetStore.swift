//
//  AssetStore.swift
//  IMDBMovies
//
//  Created by Akshay Bhandary on 7/3/22.
//

import Foundation


private let TAG = "AssetStore"

struct AssetStore {
  
  var imageCache = NSCache<NSString, NSData>()
  
  func fetchAsset(url: URL?) -> Asset {
    guard let url = url else {
      Log.error(TAG, "attempt to fetch using nil url, returning placeholder")
      return Asset(url: nil, state: .placeholder, data: nil)
    }
    if let cachedAsset = imageCache.object(forKey: url.path as NSString) {
      return Asset(url: url, state: .downloaded, data: cachedAsset as Data)
    }
    return Asset(url: url, state: .placeholder, data: nil)
  }
  
  func downloadAsset(url: URL?, completionHandler: @escaping (Asset) -> Void) {
    guard let url = url else {
      Log.error(TAG, "attempt to fetch using nil url, returning placeholder")
      completionHandler(Asset(url: nil, state: .placeholder, data: nil))
      return
    }
    
    if let cachedAsset = imageCache.object(forKey: url.path as NSString) {
      completionHandler(Asset(url: url, state: .downloaded, data: cachedAsset as Data))
    } else {
      Task.detached {
        do {
          let downloadedData = try Data(contentsOf: url)
          imageCache.setObject(downloadedData as NSData, forKey: url.path as NSString)
          completionHandler(Asset(url: url, state: .downloaded, data: downloadedData))
        } catch {
          Log.error(TAG, error)
        }
      }
    }
  }
}
