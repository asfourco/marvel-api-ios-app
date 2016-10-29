//
//  ComicTableViewCell.swift
//  MarvelAPIDemo
//
//  Created by Fadi Asfour on 2016-10-28.
//  Copyright © 2016 Fadi Asfour. All rights reserved.
//

import UIKit
import Alamofire

class ComicTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    func getComicImage(url: URL) {
        print("getComicImage called")
        Alamofire.download(url.absoluteString).responseData {
            response in

            print("completion of Alamofire.download")
            if let data = response.result.value {
                print("setting image")
                self.thumbnail.image = UIImage(data: data)
            }
        }
    }

}
