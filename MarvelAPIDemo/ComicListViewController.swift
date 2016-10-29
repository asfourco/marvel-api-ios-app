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
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    var loadingData = false
    
    let limit:Int = 20
    var offset:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageList = []
        
        self.setLoadingScreen()
        self.populateTable()
    
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

    // TODO: update number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.comicList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier, for: indexPath) as! ComicTableViewCell

        let cellData = self.comicList[indexPath.row]

        cell.titleLabel.text = cellData.title
        cell.thumbnail.image = self.imageList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("willDisplay cell at \(indexPath.row), loadingData: \(loadingData), imageList.count = \(imageList.count)")
        
        if !self.loadingData && indexPath.row == self.imageList.count - 1 {
            self.setLoadingScreen()
            self.loadingData = true
            self.populateTable()
        }
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
    
    
    // MARK: - Loading screen
    private func setLoadingScreen() {
        
        // set the container view to be center of screen
        let width: CGFloat = 120
        let height: CGFloat = 30
        
        let x = (self.tableView.frame.width / 2) - (width / 2)
        let y = (self.tableView.frame.height / 2) - (height / 2) - (self.navigationController?.navigationBar.frame.height)!
        
        self.loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        self.loadingView.backgroundColor = UIColor.white
        
        // set loading text
        self.loadingLabel.textColor = UIColor.gray
        self.loadingLabel.textAlignment = NSTextAlignment.center
        self.loadingLabel.text = "Loading ..."
        self.loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        
        // setup spinner
        self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.spinner.startAnimating()
        
        // Load label and spinner onto the view
        self.loadingView.addSubview(self.spinner)
        self.loadingView.addSubview(self.loadingLabel)
        
        // load view on top of table
        self.tableView.addSubview(self.loadingView)
    }
    
    private func removeLoadingScreen() {
        
        // Stop animation and review subview
        self.spinner.stopAnimating()
        self.loadingView.removeFromSuperview()
        
    }
    
    
    private func getImages(results:[APIResult]) {
        var itemCount: Int = 0
        print("getImages called with results.count: \(results.count)")
        
        for item in results {
            print("item: \(itemCount)")
            do {
                try self.imageList.append(UIImage(data: Data(contentsOf: (item.thumbnail?.url)!))!)
                itemCount += 1
            } catch let error as NSError {
                print("error: \(error)")
            }
        }
        
        self.loadingData = false
        self.tableView.reloadData()
        self.removeLoadingScreen()
        
    }
    
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
            
            self.getImages(results: results!)
        }
    }

}
