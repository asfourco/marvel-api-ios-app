//
//  TableViewController.swift
//  MarvelAPIDemo
//
//  Created by Fadi Asfour on 2016-10-28.
//  Copyright © 2016 Fadi Asfour. All rights reserved.
//

import UIKit
import AlamofireImage

class ComicListViewController: UITableViewController {
    
    var comicList: [APIResult] = []
    let reusableCellIdentifier = "comicCell"
    let comicDetailSegueIdentifier = "ComicDetailSegue"
    
    var imageToPass:UIImage!
    var dataToPass:APIResult!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        APICall().downloadComics() {
            (data: APIReturnDataSet?, results: [APIResult]?, error: String) in
            print("status: \(data?.status)")
            print("attributionText: \(data?.attributionText)")
            print("Returned with data count: \(data?.data?.count)")
            print("Returned with data limit of: \(data?.data?.limit)")
            print("results count: \(results?.count)")
            print("errors: \(error)")
            self.comicList = results!
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.comicList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier, for: indexPath) as! ComicTableViewCell

        let cellData = self.comicList[indexPath.row]
//        cell.thumbnail.contentMode = .scaleAspectFill
        print("cell at \(indexPath.row) call download image)")
        let url = cellData.thumbnail?.url
        print("going to get image from url: \(url)")
        do {
            let data = try Data(contentsOf: url!)
            cell.thumbnail.image = UIImage(data: data)
            cell.thumbnail.image?.af_inflate()
            
        } catch let error as NSError {
            print("error: \(error)")
        }
        
        cell.titleLabel.text = cellData.title

        return cell
    }
    
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.cellForRow(at: indexPath) as! ComicTableViewCell
//        self.imageToPass = cell.thumbnail.image
//        self.dataToPass = self.comicList[indexPath.row]
//
        print("user selected row: \(indexPath.row)")
        
        shouldPerformSegue(withIdentifier: comicDetailSegueIdentifier, sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == comicDetailSegueIdentifier {
            
            let indexPath = tableView.indexPathForSelectedRow!
            let cell = tableView.cellForRow(at: indexPath ) as! ComicTableViewCell
            let destination = segue.destination as? ComicDetailViewController
        
            destination?.comicCoverImage = cell.thumbnail.image
            destination?.comicData = self.comicList[indexPath.row]
        }
    }
    

}
