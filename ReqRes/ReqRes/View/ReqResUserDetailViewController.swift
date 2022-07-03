//
//  ReqResUserDetailViewController.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/2/22.
//

import Foundation
import UIKit

class ReqResUserDetailViewController: UIViewController {
  
  var user: ReqResUser!
  let stackView: UIStackView!
  
  let profilePic = UIImageView()
  
  init(user: ReqResUser) {
    self.user = user
    stackView = UIStackView()
    super.init(nibName: nil, bundle: nil)
  }

  override func viewDidLoad() {
    
    setProfileImage(urlString: user.avatar)

    // setup stack views
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 50
    
    stackView.addArrangedSubview(getProfilePicHostingView())
    stackView.addArrangedSubview(getHozintalStackView(staticPrefix: "First Name:", labelString: user.firstName))
    stackView.addArrangedSubview(getHozintalStackView(staticPrefix: "Last Name:", labelString: user.lastName))
    stackView.addArrangedSubview(getHozintalStackView(staticPrefix: "Email:", labelString: user.email))
    
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
  
  private func setProfileImage(urlString: String) {
    if let url = URL(string: urlString) {
      do {
        profilePic.image = try UIImage(data: Data(contentsOf: url))
      } catch {
        print(error)
      }
    }
  }
  
  private func getProfilePicHostingView() -> UIView {
    let verticalStackView = UIStackView()
    verticalStackView.axis = .vertical
    verticalStackView.alignment = .fill
    verticalStackView.distribution = .fill
    verticalStackView.addArrangedSubview(profilePic)
    return profilePic
  }
  
  private func getConstraints() -> [NSLayoutConstraint] {
    return [
      stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      profilePic.widthAnchor.constraint(equalTo: profilePic.heightAnchor),
    ]
  }
  
  private func debug(_ view: UIView) {
    // view.backgroundColor = .random()
  }
}
