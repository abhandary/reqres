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
  
  init(user: ReqResUser) {
    super.init(nibName: nil, bundle: nil)
    self.user = user
  }
  
  override func viewWillLayoutSubviews() {
    
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
