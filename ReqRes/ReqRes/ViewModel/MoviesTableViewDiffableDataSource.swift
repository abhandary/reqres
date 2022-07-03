//
//  MoviesTableViewDiffableDataSource.swift
//  IMDB Movies
//
//  Created by Akshay Bhandary on 7/2/22.
//

import Foundation
import UIKit

class MoviesTableViewDiffableDataSource: UITableViewDiffableDataSource<String?, Movie> {
  static let cellRowHeight = 100.0
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return MoviesTableViewDiffableDataSource.cellRowHeight
  }
}
