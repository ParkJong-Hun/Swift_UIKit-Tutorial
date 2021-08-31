//
//  ViewController.swift
//  StoryBoardTutorial
//
//  Created by 박종훈 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var country = ["Seoul", "Tokyo", "Los Angeles", "New york", "Paris", "London", "Shanghai", "Beijing"]
    var searching_country:[String]?
    var searching:String?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let c = searching_country { return c.count }
        else { return country.count }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if searching_country != nil {
            cell.textLabel!.text = searching_country![indexPath.row]
        } else {
            cell.textLabel!.text = country[indexPath.row]
        }
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        search_bar.delegate = self
    }
    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func clicked_searchBtn(_ sender: Any) {
        searching = search_bar.text!
        searching_country = country.filter{$0.contains(searching!)}
        tableView.reloadData()
    }
}
