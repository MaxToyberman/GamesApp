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

class MovieFeedTableViewController:UITableViewController {

    let kCloseCellHeight: CGFloat = 100
    let kOpenCellHeight: CGFloat = 200
    var cellHeights = [CGFloat]()
    
    var feed:MoviesFeed?{
        didSet{
            let kRowsCount=(feed?.movies.count)!

            for _ in 0...kRowsCount {
                cellHeights.append(kCloseCellHeight)
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor=UIColor.lightGrayColor()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed?.movies.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieTableViewCell", forIndexPath: indexPath) as! MovieTableViewCell
        
        if let movie=feed?.movies[indexPath.row]{
            
            
            cell.title.text=movie.title
            
            cell.overView.text=movie.overview
            // Configure the cell...
            let URL = NSURL(string: movie.imageURL)!
            
        //    cell.gameImage.contentMode=UIViewContentMode.ScaleAspectFit
            cell.movieImage.af_setImageWithURL(URL)
            
            cell.movieImageUnfolded.af_setImageWithURL(URL)
            
        }
        
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell is FoldingCell {
            let foldingCell = cell as! FoldingCell
            foldingCell.backgroundColor = UIColor.clearColor()
            if cellHeights[indexPath.row] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}

