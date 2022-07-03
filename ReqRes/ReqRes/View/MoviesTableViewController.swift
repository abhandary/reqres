//
//  MoviesTableViewController.swift
//  IMDB Movies
//
//  Created by Akshay Bhandary on 7/1/22.
//

import UIKit
import Combine

private let REQ_USER_CELL_HOW_HEIGHT = 100.0

class MoviesTableViewController: UIViewController {
  
  @Published var keyStroke: String = ""
  var cancellables: Set<AnyCancellable> = []
  
  let searchBar: UISearchBar!
  let tableView: UITableView!
  let viewModel: MoviesViewModel!
  
  init(viewModel: MoviesViewModel) {
    self.viewModel = viewModel
    self.tableView = UITableView()
    self.searchBar = UISearchBar()
    super.init(nibName: nil, bundle: nil)
  }
  
  // This is also necessary when extending the superclass.
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupSearchBar()
    setupTableView()
    setupObservers()
    
    NSLayoutConstraint.activate(staticConstraints())
  }
  
  private func staticConstraints() -> [NSLayoutConstraint] {
    var constraints: [NSLayoutConstraint] = []
    
    // profile image constraints
    constraints.append(contentsOf: [
      searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
    ])
    
    // name label constraints
    constraints.append(contentsOf:[
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
    ])
    
    return constraints
  }
}

// MARK: - UITableView Delegate
extension MoviesTableViewController: UITableViewDelegate {
  
  // delegate methods
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath)
    let movie = viewModel.movies[indexPath.row]
    let detailVC = MovieDetailViewController(movie:movie)
    detailVC.view.backgroundColor = .white
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
  
  private func setupTableView() {
    self.tableView.delegate = self
    self.tableView.register(MovieTableViewCell.self,
                            forCellReuseIdentifier: MovieTableViewCell.cellReuseIdentifier)
    self.tableView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(self.tableView)
  }
  
  private func setupSearchBar() {
    self.searchBar.delegate = self
    self.searchBar.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(searchBar)
  }
}

// MARK: - UISearchBar Delegate
extension MoviesTableViewController: UISearchBarDelegate
{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
  {
    self.keyStroke = searchText
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.keyStroke = ""
  }
}

//MARK: - Observers
extension MoviesTableViewController
{
  func setupObservers()
  {
    // MONITOR search bar textfield keystrokes
    $keyStroke
      .receive(on: RunLoop.main)
      .sink { (keywords) in
        print(keywords)
        self.viewModel.searchString = keywords
      }.store(in: &cancellables)
    
    // diffable datasource
    viewModel.diffableDataSource = MoviesTableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, model) -> UITableViewCell? in
      
      guard
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellReuseIdentifier, for: indexPath) as? MovieTableViewCell
      else { return UITableViewCell() }
      
      cell.update(movie: model)
      return cell
    }
  }
}

