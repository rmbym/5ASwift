//
//  PidoufController.swift
//  SKETUVEUX
//
//  Created by moi on 28/10/2022.
//


import UIKit
import Alamofire

class PidoufController:UIViewController, UITableViewDelegate {
    
    var listeLivres: [String] = []
    
    struct PidoufApiResponse: Decodable {
        let items: [items]
    }
    
    struct items : Decodable {
        let volumeInfo: volumeInfo
    }
    
    struct volumeInfo : Decodable {
        let title: String
    }

    @IBOutlet weak var TableView: UITableView!
    
    @IBAction func Bouton(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.dataSource = self
        self.TableView.delegate = self
        
        AF.request("https://www.googleapis.com/books/v1/volumes?q=subject:fantasy&printType=books&orderBy=relevance&maxResults=10",method: .get).validate().responseDecodable(of: PidoufApiResponse.self) { response in
            if response.value != nil {
                let responseValue = response.value!
                self.listeLivres = responseValue.items.compactMap{
                    
                    $0.volumeInfo.title
                    
                }
                
                self.TableView.reloadData()
            }
            
        }
        
    }
}

extension PidoufController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listeLivres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.section, indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = listeLivres[indexPath.row]
        return cell
    }
}
