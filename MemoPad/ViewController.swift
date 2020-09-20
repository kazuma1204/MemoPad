//
//  ViewController.swift
//  MemoPad
//
//  Created by Kazuma Adachi on 2020/06/07.
//  Copyright © 2020 Kazuma Adachi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var bottunCollection: [UIButton]!
    var tagNumber: Int!
    
    var ud: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for button in bottunCollection {
            button.layer.cornerRadius = 50
            button.backgroundColor = UIColor(red: 188/225, green: 186/225, blue: 190/225, alpha: 1.0)
            tagNumber = button.tag
            var genre = ud.object(forKey: "genre\(tagNumber)") as? String
            button.setTitle(genre, for: .normal)
        }
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toList" {
            let ListViewController = segue.destination as!  ListViewController
            ListViewController.tagNumber = self.tagNumber
        }
    }
    
    
    
    @IBAction func tappedButton(_ sender: Any) {
        let button = sender as! UIButton
        tagNumber = button.tag
        print(tagNumber)
        var currentButton = bottunCollection[tagNumber]
        currentButton.backgroundColor = UIColor(red: 161/225, green: 214/225, blue: 226/225, alpha: 1.0)
        
        performSegue(withIdentifier: "toList", sender: nil)
           
    }
    

    
    
}

