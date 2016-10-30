//
//  ComicDetailViewController.swift
//  MarvelAPIDemo
//
//  Created by Fadi Asfour on 2016-10-28.
//  Copyright © 2016 Fadi Asfour. All rights reserved.
//

import UIKit

class ComicDetailViewController: UIViewController {

    @IBOutlet weak var comicCover: UIImageView!
    @IBOutlet weak var priceValue: UILabel!
    @IBOutlet weak var ISBNValue: UILabel!
//    @IBOutlet weak var comicDescription: UITextView!
    
    @IBOutlet weak var comicDescription: UILabel!
    
    var comicData: APIResult!
    var comicCoverImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set cover image
        self.comicCover.image = self.comicCoverImage
    
        // assign comic details
        self.priceValue.text = comicData.prices != nil ? "$ " + String(format: "%.2f", (comicData.prices?[0].price!)!) : "No price available"
        self.ISBNValue.text = comicData.isbn != nil ? comicData.isbn! : "ISBN unavailable"
        
        self.comicDescription.lineBreakMode = .byWordWrapping
        self.comicDescription.text = comicData.description != nil ? comicData.description! : "No description available"
        self.comicDescription.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
