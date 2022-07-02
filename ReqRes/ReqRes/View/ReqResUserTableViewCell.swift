//
//  ReqResUserTableViewCell.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/1/22.
//

import Foundation
import UIKit

class ReqResUserTableViewCell: UITableViewCell {
  var nameLabel: UILabel!
  var profilePic: UIImageView!
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupProfilePic()
    setupNameLabel()
    
    NSLayoutConstraint.activate(staticConstraints())
  }
  
  func update(user: ReqResUser) {
    print("#### updating cell with user - \(user)")
    nameLabel.text = "\(user.firstName) \(user.lastName)"
    setThumbnailImage(urlString: user.avatar)
  }
  
  private func setThumbnailImage(urlString: String) {
    if let url = URL(string: urlString) {
      do {
        profilePic.image = try UIImage(data: Data(contentsOf: url))
      } catch {
        print(error)
      }
    }
  }
  
  private func staticConstraints() -> [NSLayoutConstraint] {
    var constraints: [NSLayoutConstraint] = []
    
    // profile image constraints
    constraints.append(contentsOf: [
      profilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10.0),
      profilePic.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
      profilePic.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
      profilePic.widthAnchor.constraint(equalTo: profilePic.heightAnchor)
    ])
    
    // name label constraints
    constraints.append(contentsOf:[
      nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10.0),
      nameLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
      nameLabel.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 20.0),
      nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 5.0)
    ])
    
    return constraints
  }
  
  private func setupProfilePic() {
    profilePic = UIImageView()
    
    // setup corners
    profilePic.layer.cornerRadius = 10.0
    profilePic.clipsToBounds = true
    profilePic.translatesAutoresizingMaskIntoConstraints = false
    
    // add border
    profilePic.layer.borderWidth = 1.0
    profilePic.layer.borderColor = UIColor.gray.cgColor
    
    self.addSubview(profilePic)
  }
  
  private func setupNameLabel() {
    nameLabel = UILabel()
    nameLabel.translatesAutoresizingMaskIntoConstraints = false

    self.addSubview(nameLabel)
  }
  

}
