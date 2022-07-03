//
//  ReqResUsersViewModel.swift
//  IMDB Movies
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation
import UIKit
import Combine

class MoviesViewModel {
  
  var cancellables: Set<AnyCancellable> = []
  var networkLoader: NetworkLoaderProtocol!
  var dataStorage: DataStoreProtocol!
  
  var diffableDataSource: MoviesTableViewDiffableDataSource!
  
  init(networkLoader: NetworkLoaderProtocol,
       dataStorage: DataStoreProtocol) {
    self.networkLoader = networkLoader
    self.dataStorage = dataStorage
    
    $searchString
               .receive(on: RunLoop.main)
               .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
               .sink { keywords in self.fetchMovies(keywords: keywords)
               }.store(in: &cancellables)
  }
  
  @Published var searchString: String = ""
  
  @Published @MainActor var movies: [Movie] = []
  @Published @MainActor var photos: [PhotoRecord] = []
  
  func fetchMovies(keywords: String) {
    async {
      await fetchMoviesAsync(keywords: keywords)
    }
  }
  
  func fetchMoviesAsync(keywords: String) async {
    
    // fetch from data store if present
    await fetchFromDataStoreAndUpdate(keywords: keywords)

    print("running query for keywords - \(keywords)")
    // async fetch from network and update and notify
    if let response = await networkLoader.queryForMovies(usingSearchString: searchString) {
      print("###### writing network response to data store")
      await dataStorage.write(response: response, usingSearchString: keywords)
      await fetchFromDataStoreAndUpdate(keywords: keywords)
    } else {
      print("##### got back an empty response")
    }
  }
  
  private func fetchFromDataStoreAndUpdate(keywords: String) async {
    print("###### fetchFromDataStoreAndUpdate")
    var snapshot = NSDiffableDataSourceSnapshot<String?, Movie>()
    snapshot.appendSections([""])
    if let movies = await dataStorage.fetchMovies(usingSearchString: keywords) {
      await MainActor.run {
        self.movies = movies
      }
      snapshot.appendItems(movies, toSection: "")
    }
    await self.diffableDataSource.apply(snapshot, animatingDifferences: true)
  }
  
  /*
  @MainActor private func updatePhotos() {
    self.photos = self.users.map {
      PhotoRecord(url: URL(string: $0.avatar),
                  state: .new,
                  image: UIImage(named: "Placeholder"))
    }
  }
   */
}
