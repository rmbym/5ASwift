//
//  BasanasViewController.swift
//  SKETUVEUX
//
//  Created by rmbym on 28/10/2022.
//

import Foundation
import UIKit
import Alamofire

struct JokeBasanas: Decodable{
    let joke: Joke
}

struct Joke: Decodable {
    let question, answer: String
}

class  BasanasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let jokeUrl: String = "https://blague.xyz/api/joke/random"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basanasCell", for: indexPath)
        if answered[indexPath.row] {
            cell.textLabel?.text = myAnswers[indexPath.row]
        } else {
            cell.textLabel?.text = myList[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.answered[indexPath.row] = true
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView1: UITableView!
    var myList: Array<String> = []
    var myAnswers: Array<String> = []
    var answered: Array<Bool> = []
    
    @IBAction func Retour(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView1.dataSource = self
        tableView1.delegate = self
        
        for _ in 1...15{
            AF.request(jokeUrl, method: .get).validate().responseDecodable(of: JokeBasanas.self) { response in
                if let responseValue = response.value {
                    self.myList.append(responseValue.joke.question)
                    self.myAnswers.append(responseValue.joke.answer)
                    self.answered.append(false)
                }
                self.tableView1.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
