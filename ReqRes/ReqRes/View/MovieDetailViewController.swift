//
//  MovieDetailViewController.swift
//  IMDB Movies
//
//  Created by Akshay Bhandary on 7/2/22.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
  
  var movie: Movie!
  let stackView: UIStackView!
  
  let movieImage = UIImageView()
  
  init(movie: Movie) {
    self.movie = movie
    stackView = UIStackView()
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    
    setMovieImage(urlString: movie.image)

    // setup stack views
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 50
    
    stackView.addArrangedSubview(movieImage)
    stackView.addArrangedSubview(getHozintalStackView(staticPrefix: "Title:", labelString: movie.title))
    stackView.addArrangedSubview(getHozintalStackView(staticPrefix: "Description", labelString: movie.resultDescription))
    
    self.view.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    debug(stackView)
    NSLayoutConstraint.activate(getConstraints())
  }
  
  
  required init?(coder: NSCoder) {
    stackView = UIStackView()
    super.init(coder: coder)
  }
  
  private func getHozintalStackView(staticPrefix: String, labelString: String) -> UIStackView {
    let hStackView = UIStackView()
    hStackView.axis = .horizontal
    hStackView.alignment = .fill
    hStackView.distribution = .fill
    hStackView.spacing = 10
    hStackView.translatesAutoresizingMaskIntoConstraints = false
    debug(hStackView)
    
    let prefixLabel = UILabel()
    prefixLabel.translatesAutoresizingMaskIntoConstraints = false
    prefixLabel.text = staticPrefix
    prefixLabel.font = .boldSystemFont(ofSize: 20)
    prefixLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    debug(prefixLabel)
    hStackView.addArrangedSubview(prefixLabel)
    
    let label = UILabel()
    label.text = labelString
    label.translatesAutoresizingMaskIntoConstraints = false
    label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    debug(label)
    hStackView.addArrangedSubview(label)
    
    return hStackView
  }
  
  private func setMovieImage(urlString: String) {
    if let url = URL(string: urlString) {
      do {
        movieImage.image = try UIImage(data: Data(contentsOf: url))
      } catch {
        print(error)
      }
    }
  }
  
  private func getConstraints() -> [NSLayoutConstraint] {
    return [
      stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      movieImage.widthAnchor.constraint(equalTo: movieImage.heightAnchor),
    ]
  }
  
  private func debug(_ view: UIView) {
    // view.backgroundColor = .random()
  }
}
