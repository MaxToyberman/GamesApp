//
//  ViewController.swift
//  TMDB
//
//  Created by Maxim Toyberman on 26/08/2016.
//  Copyright © 2016 Maxim Toyberman. All rights reserved.
//

import UIKit
import FoldingCell
import AlamofireImage

class GameFeedTableViewController:UITableViewController {

    let kCloseCellHeight: CGFloat = 75
    let kOpenCellHeight: CGFloat = 200
    var kRowsCount=0
    var cellHeights = [CGFloat]()
    
    var feed:GamesFeed?{
        didSet{
            print("didset")
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
        kRowsCount=self.feed?.games.count ?? 0
        for _ in 0...5 {
            cellHeights.append(kCloseCellHeight)
        }
         */
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed?.games.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieTableViewCell", forIndexPath: indexPath) as! GameTableViewCell
        
        if let game=feed?.games[indexPath.row]{
            
            cell.name.text=game.name
            // Configure the cell...
            let URL = NSURL(string: game.imageURL)!
            
        //    cell.gameImage.contentMode=UIViewContentMode.ScaleAspectFit
            cell.gameImage.af_setImageWithURL(URL)
            
        }
        
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

