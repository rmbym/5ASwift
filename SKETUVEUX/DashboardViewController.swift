//
//  ViewController.swift
//  SKETUVEUX
//
//  Created by rmbym on 27/10/2022.
//

import UIKit

class DashboardViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var DashBoardMenuCollectionView: UICollectionView!
    
    private let dashboardSeguesIdentifiers = ["toPidouf","toJTJ","toBasanas","toEkip","toTeamRocket"]
    private let dashboardNavItems = [["Pidouf","pidouf"], ["JTJ","JTJ"], ["Basanas",""], ["Ekip","ekip"], ["Team Rocket","teamRocket"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.DashBoardMenuCollectionView.dataSource = self
        self.DashBoardMenuCollectionView.delegate = self
    }

}

extension DashboardViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: dashboardSeguesIdentifiers[indexPath.row], sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardSeguesIdentifiers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashBoardNavCell", for: indexPath)
        cell.contentView.subviews.forEach { cellItem  in
            if let cellLabel = cellItem as? UILabel {
                cellLabel.text = dashboardNavItems[indexPath.row][0]
            } else if let cellImage = cellItem as? UIImageView {
                cellImage.image = UIImage(named: dashboardNavItems[indexPath.row][1])
            }
        }
        return cell
    }
    
    
}
