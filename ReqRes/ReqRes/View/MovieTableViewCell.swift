//
//  ReqResUserTableViewCell.swift
//  IMDB Movies
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
  var nameLabel: UILabel!
  var movieImage: UIImageView!
  
  static let cellReuseIdentifier = "com.reqres.movie"
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupProfilePic()
    setupNameLabel()
    
    NSLayoutConstraint.activate(staticConstraints())
  }
  
  func update(movie: Movie) {
    nameLabel.text = movie.title
    setThumbnailImage(urlString: movie.image)
  }
  
  private func setThumbnailImage(urlString: String) {
    if let url = URL(string: urlString) {
      do {
        movieImage.image = try UIImage(data: Data(contentsOf: url))
      } catch {
        print(error)
      }
    }
  }
  
  private func staticConstraints() -> [NSLayoutConstraint] {
    var constraints: [NSLayoutConstraint] = []
    
    // profile image constraints
    constraints.append(contentsOf: [
      movieImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
      movieImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0),
      movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
      movieImage.widthAnchor.constraint(equalTo: movieImage.heightAnchor)
    ])
    
    // name label constraints
    constraints.append(contentsOf:[
      nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
      nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0),
      nameLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 20.0),
      nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5.0)
    ])
    
    constraints.append(contentsOf:[
      self.heightAnchor.constraint(equalToConstant: 100.0)
    ])
    
    return constraints
  }
  
  private func setupProfilePic() {
    movieImage = UIImageView()
    
    // setup corners
    movieImage.layer.cornerRadius = 10.0
    movieImage.clipsToBounds = true
    movieImage.translatesAutoresizingMaskIntoConstraints = false
    
    // add border
    movieImage.layer.borderWidth = 1.0
    movieImage.layer.borderColor = UIColor.gray.cgColor
    
    self.addSubview(movieImage)
  }
  
  private func setupNameLabel() {
    nameLabel = UILabel()
    nameLabel.translatesAutoresizingMaskIntoConstraints = false

    self.addSubview(nameLabel)
  }
}
