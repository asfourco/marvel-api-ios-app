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
    var imageList: [UIImage] = []
    
    let reusableCellIdentifier = "comicCell"
    let comicDetailSegueIdentifier = "ComicDetailSegue"
    
    
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    let loadingLabel = UILabel()
    var loadingData = false
    
    let limit:Int = 10
    var offset:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLoadingScreen()
        self.populateTable()
    
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (self.comicList.count > 0) ? 1 : 0
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.comicList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier, for: indexPath) as! ComicTableViewCell

        let cellData = self.comicList[indexPath.row]

        cell.titleLabel.text = cellData.title
        // Use AlamofireImage to async download and set images
        cell.thumbnail.af_setImage(withURL: (cellData.thumbnail?.url)!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        print("willDisplay cell at \(indexPath.row), loadingData: \(loadingData), imageList.count = \(self.comicList.count)")
        
        if !self.loadingData && indexPath.row == self.comicList.count - 3 {
            self.setLoadingScreen()
            self.loadingData = true
            self.populateTable()
        }
    }
    
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print("user selected row: \(indexPath.row)")
        
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
    
    
    // MARK: - Loading screen
    
    private func setLoadingScreen() {
        LoadingIndicatorView.show("Loading")
    }
    
    private func removeLoadingScreen() {
        LoadingIndicatorView.hide()
    }
    
    // MARK: - Downloaders
    
    private func populateTable() {
        
        APICall().downloadComics(limit: limit, offset: offset) {
            (data: APIReturnDataSet?, results: [APIResult]?, error: String) in
            print("status: \(data?.status)")
            print("attributionText: \(data?.attributionText)")
            print("Returned with data count: \(data?.data?.count)")
            print("Returned with data limit of: \(data?.data?.limit)")
            print("results count: \(results?.count)")
            print("errors: \(error)")
            
            self.offset += self.limit
            
            self.comicList += results!
            
            self.loadingData = false
            self.tableView.reloadData()
            self.removeLoadingScreen()
            
        }
    }

}
