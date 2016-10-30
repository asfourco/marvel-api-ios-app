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
    
    var comicAttributionText: String?
    var comicList: [APIResult] = []
    
    let reusableCellIdentifier = "comicCell"
    let comicDetailSegueIdentifier = "ComicDetailSegue"
    
    var loadingData = false
    let limit:Int = 10
    var offset:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLoadingScreen()
        self.populateTable(limit: limit, offset: offset)
    
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (self.comicList.count > 0) ? 1 : 0
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        
        if !self.loadingData && indexPath.row == self.comicList.count - 1 {
            self.setLoadingScreen()
            self.loadingData = true
            self.populateTable(limit:limit, offset:offset)
        }
    }
    
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("user selected row: \(indexPath.row)")
        shouldPerformSegue(withIdentifier: comicDetailSegueIdentifier, sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == comicDetailSegueIdentifier {
            
            let indexPath = tableView.indexPathForSelectedRow!
            let cell = tableView.cellForRow(at: indexPath ) as! ComicTableViewCell
            let destination = segue.destination as? ComicDetailViewController
        
            destination?.comicCoverImage = cell.thumbnail.image
            destination?.comicData = self.comicList[indexPath.row]
        }
    }
    
    /// Present an alert view to the user with Marvel attribution
    ///
    /// - Parameter sender: The associated UIBarButtonItem
    @IBAction func openAboutScreen(_ sender: UIBarButtonItem) {
        let title = "About"
        let message = self.comicAttributionText! + "\n\n" + "Fadi Asfour © 2016"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated:true, completion:nil)
        
    }
    
    
    // MARK: - Loading screen
    
    /// Insert loading overlay on screen
    private func setLoadingScreen() {
        LoadingIndicatorView.show("Loading")
    }
    
    /// Remove loading overlay from screen
    private func removeLoadingScreen() {
        LoadingIndicatorView.hide()
    }
    
    // MARK: - Downloaders
    
    /// Retrieve data from marvel api and populate the comic list
    ///
    /// - Parameters:
    ///   - limit: A number indicating how many records should be retrieved
    ///   - offset: The number of records to skip
    private func populateTable(limit:Int, offset:Int) {
        print("limit:\(limit), offset:\(offset)")
        APICall().downloadComics(limit: limit, offset: offset) {
            (data: APIReturnDataSet?, results: [APIResult]?, error: String) in
            print("return code: \(data?.code)")
            print("attributionText: \(data?.attributionText)")
            print("total avaialable: \(data?.data?.total)")
            print("offset: \(data?.data?.offset)")
            print("Returned with data count: \(data?.data?.count)")
            print("Returned with data limit of: \(data?.data?.limit)")
            print("results count: \(results?.count)")
            print("errors: \(error)")
            
            self.offset += (data?.data?.count)!
            
            print("new offset:\(self.offset)")
            self.comicAttributionText = data?.attributionText
            self.comicList += results!
            self.loadingData = false
            self.tableView.reloadData()
            self.removeLoadingScreen()
            
        }
    }
    
}
