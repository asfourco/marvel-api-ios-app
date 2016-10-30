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
    @IBOutlet weak var pageCount: UILabel!
    @IBOutlet weak var comicDescription: UILabel!
    
    var comicData: APIResult!
    var comicCoverImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set cover image
        self.comicCover.image = self.comicCoverImage
    
        // assign comic details
        self.priceValue.text = comicData.prices != nil ? "$ " + String(format: "%.2f", (comicData.prices?[0].price!)!) : "No price available"
        self.pageCount.text = comicData.pageCount != nil ? String(comicData.pageCount!) : "No data"
        
        self.comicDescription.lineBreakMode = .byWordWrapping
        self.comicDescription.text = comicData.description != nil ? comicData.description! : "No description available"
        self.comicDescription.sizeToFit()
    }

}
