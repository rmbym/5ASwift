//
//  ViewController.swift
//  SKETUVEUX
//
//  Created by jtj on 28/10/2022.
//

import UIKit


class JTJController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var myTable: UITableView!
    let tableDataSource: [String] = ["Yannick", "Jovan", "Theo", "Rocco", "Clara", "Merci", "Jacquie", "Michel"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTable.delegate = self
        myTable.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = "Back"
        navigationController?.navigationBar.backItem?.backBarButtonItem = backButtonItem
    }
    
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableDataSource[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 28.0)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Show chat messages
        let vc = ChatViewController()
        vc.title = "Chat"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
