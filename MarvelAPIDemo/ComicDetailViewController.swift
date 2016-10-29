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
    @IBOutlet var comicDescription: UITextView!
    
    var comicData: APIResult!
    var comicCoverImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.comicCover.image = self.comicCoverImage
        
        self.priceValue.text = comicData.prices!.count > 0 ? "$ " + String(format: "%.2f", (comicData.prices?[0].price!)!) : "No price available"
        self.ISBNValue.text = (comicData.isbn?.isEmpty)! ? "ISBN unavailable" : comicData.isbn
        self.comicDescription.text = (comicData.description?.isEmpty)! ? "No description available" : comicData.description
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
