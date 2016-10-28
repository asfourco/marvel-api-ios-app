//
//  ViewController.swift
//  MarvelAPIDemo
//
//  Created by Fadi Asfour on 2016-10-27.
//  Copyright © 2016 Fadi Asfour. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        APICall().downloadComics() {
            (status: String, attributionText: String, results: [APIResults], error: String) in
            print("status: \(status)")
            print("attributionText: \(attributionText)")
            print("results count: \(results.count)")
            print("errors: \(error)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
