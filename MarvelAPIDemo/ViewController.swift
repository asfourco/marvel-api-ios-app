//
//  ViewController.swift
//  MarvelAPIDemo
//
//  Created by Fadi Asfour on 2016-10-27.
//  Copyright © 2016 Fadi Asfour. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CryptoSwift

class ViewController: UIViewController {
    let MarvelPublicKey =  "3db41b1c539b051d6de3590596073c18"
    let MarvelPrivateKey = "33573c4faa8960b27e447b1564bc70e88fcf28d8"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadComics()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadComics() {
        let baseMarvelURL = "https://gateway.marvel.com/v1/public/comics"
        let ts = NSDate().timeIntervalSince1970.description
        let hashString = ts + MarvelPrivateKey + MarvelPublicKey
        
        let params: Parameters = [
            "apikey": MarvelPublicKey,
            "ts": ts,
            "hash": hashString.md5()
        ]
        
        Alamofire.request(baseMarvelURL, parameters: params).responseJSON { response in
//            print(response.data)
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    

    
}
