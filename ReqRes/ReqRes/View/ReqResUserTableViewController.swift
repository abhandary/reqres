//
//  ViewController.swift
//  ReqRes
//
//  Created by Akshay Bhandary on 7/1/22.
//

import UIKit

private let REQ_USER_CELL_REUSE_ID = "com.reqres.user"
private let REQ_USER_CELL_HOW_HEIGHT = 100.0

class ReqResUserTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let tableView: UITableView!
  let viewModel: ReqResUsersViewModel!
  
  init(viewModel: ReqResUsersViewModel) {
    self.viewModel = viewModel
    self.tableView = UITableView()
    
    super.init(nibName: nil, bundle: nil)
  }
  
  // This is also necessary when extending the superclass.
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented") 
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()

    // Do any additional setup after loading the view.
    async {
      await viewModel.fetchUsers()
      
      // if table view is large we would just update the changed rows.
      tableView.reloadData()
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: REQ_USER_CELL_REUSE_ID) as? ReqResUserTableViewCell {
      cell.update(user: viewModel.users[indexPath.row])
      return cell
    }
    return UITableViewCell()
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.users.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return REQ_USER_CELL_HOW_HEIGHT
  }
  
  private func setupTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(ReqResUserTableViewCell.self,
                            forCellReuseIdentifier: REQ_USER_CELL_REUSE_ID)
    self.tableView.frame = self.view.frame
    self.view.addSubview(self.tableView)
  }
}

