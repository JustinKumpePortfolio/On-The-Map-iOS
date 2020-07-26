//
//  ListViewController.swift
//  On The Map
//
//  Created by Justin Kumpe on 7/26/20.
//  Copyright © 2020 Justin Kumpe. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    MARK: Table View
    @IBOutlet weak var viewTable: UITableView!
    
//    MARK: Table Refresh Controller
    private let refreshControl = UIRefreshControl()
    
//    MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTable.delegate = self
        viewTable.dataSource = self
        
//        Listens for data update notifications from TabView
        NotificationCenter.default.addObserver(self, selector: #selector(buildList), name: .buildList, object: nil)
    }
    
//    MARK: Set number of rows in Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentInformation.studentLocationData.count
    }
    
//    MARK: Build Table Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "\(StudentInformation.studentLocationData[indexPath.row].firstName ?? "") \(StudentInformation.studentLocationData[indexPath.row].lastName ?? "")"
        cell.detailTextLabel?.text = StudentInformation.studentLocationData[indexPath.row].mediaURL ?? ""

        return cell
    }
    
//    MARK: Did Select Cell
//    Opens URL in Safari when user clicks cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: StudentInformation.studentLocationData[indexPath.row].mediaURL ?? ""), url.host != nil {
            launchURL(StudentInformation.studentLocationData[indexPath.row].mediaURL)
        }
    }
    
//    MARK: Build List (Reload Table View Data)
    @objc func buildList(){
        viewTable.reloadData()
        refreshControl.endRefreshing()
    }
}
