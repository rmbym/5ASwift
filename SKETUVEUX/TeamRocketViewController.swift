//
//  TeamRocketViewController.swift
//  SKETUVEUX
//
//  Created by Julien Marion on 28/10/2022.
//

import Foundation
import UIKit
import WebKit

class TeamRocketViewController: UIViewController, WKUIDelegate {
    
    let teamRocketURLS = ["https://my.spline.design/untitledcopycopy-2115623a2ab7e02f20b87b0794c8c179/",
                          "https://my.spline.design/untitledcopycopy-5ba1a2e630b99e15ff09e2c94bbb227e/",
                          "https://my.spline.design/untitledcopycopycopy-9197acda582da592121f89d4c81e9558/",
                          "https://my.spline.design/untitledcopycopycopycopy-75ac77bd80efcdff47e425695087f2ce/",
                          "https://my.spline.design/untitledcopycopycopycopycopycopy-211e5cb15f28b26ed2bcc6cfc4ae748f/"
    ]
    
    var randomImage: Int?
        
    @IBAction func toHomePage(_ sender: UIButton) {
        self.teamRocketWebView.stopLoading()
        self.dismiss(animated: true)
    }

    @IBAction func Onchange(_ sender: UIButton) {
        loadImage()
    }
    
    @IBOutlet var teamRocketWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    func loadImage(){
        teamRocketWebView.uiDelegate = self
        randomImage = Int.random(in: 0..<teamRocketURLS.count)
        let myURL = URL(string:teamRocketURLS[randomImage ?? 0])
        if let url = myURL {
            teamRocketWebView.load(URLRequest(url: url))
        }
    }
}

