//
//  ReqResDataStore.swift
//  IMDB Movies
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation

private let STORED_SEARCH_RESULTS_LIMIT = 100

actor DataStore: DataStoreProtocol {
  
  let encoder = PropertyListEncoder()
  let decoder = PropertyListDecoder()
  
  init() {
    encoder.outputFormat = .binary
  }
  
  func fetchMovies(usingSearchString searchString: String) async -> [Movie]? {
    
    guard let fileURL = getFileURL(usingSearchString: searchString) else {
      print("error: unable to get file URL")
      return nil
    }
    
    do {
      if FileManager.default.fileExists(atPath: fileURL.path) == false {
        print("No file stored for search string - \(searchString)")
        return nil
      }
      let savedData = try Data(contentsOf: fileURL)
      let savedResponse
          = try decoder.decode(Response.self, from: savedData)
      print("###### got saved movies")
      return savedResponse.movies
    } catch {
      print("Couldn't read file. - \(error)")
    }
    return nil
  }
  
  func write(response: Response, usingSearchString searchString: String) async {
    
    guard let fileURL = getFileURL(usingSearchString: searchString) else {
      print("error: unable to get file URL")
      return
    }
    
    do {
      let data = try encoder.encode(response)
      try data.write(to: fileURL)
      print("Succesfully wrote to \(fileURL)")
    } catch {
      print(error)
    }
    
    deleteOldFiles()
  }
  
  private func getFileURL(usingSearchString searchString: String) -> URL? {
    let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    guard fileURLs.count > 0 else {
      return nil
    }
    let directoryURL = fileURLs.first
    return URL(fileURLWithPath: "\(searchString).dat", relativeTo: directoryURL)
  }
  
  private func deleteOldFiles() {
    let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    guard fileURLs.count > 0 else {
      return
    }
    guard let directoryURL = fileURLs.first else { return }
    do {
      let directoryContents = try FileManager.default.contentsOfDirectory(
              at: directoryURL,
              includingPropertiesForKeys: [.creationDateKey]
          )
      for url in directoryContents {
        let creationDate = try url.resourceValues(forKeys:[.creationDateKey])
        print("\(url) creationDate = \(creationDate)")
      }

    } catch {
      print(error)
    }
  }
}


