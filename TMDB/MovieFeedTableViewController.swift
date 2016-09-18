//
//  ViewController.swift
//  TMDB
//
//  Created by Maxim Toyberman on 26/08/2016.
//  Copyright © 2016 Maxim Toyberman. All rights reserved.
//

import FoldingCell
import Alamofire
import AlamofireImage
import SwiftyJSON

class MovieFeedTableViewController:UITableViewController {
    
    //MARK: Properties
    private let kCloseCellHeight: CGFloat = 100
    private let kOpenCellHeight: CGFloat = 200
    private var cellHeights = [CGFloat]()
    private var cells=[FoldingCell]()
    
    var feed:MoviesFeed?{
        didSet{
            let kRowsCount=(feed?.movies.count)!
            
            for _ in 0...kRowsCount {
                cellHeights.append(kCloseCellHeight)
            }
            self.tableView.reloadData()
        }
    }
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor=UIColor.lightGrayColor()
        self.tableView.contentInset = UIEdgeInsetsZero
    }
    //MARK: UITbaleView delegate
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

            let URL = NSURL(string: movie.imageURL)!
            
            cell.movieImage.af_setImageWithURL(URL)
            
            cell.movieImageUnfolded.af_setImageWithURL(URL)
            
        }
        
        cells.append(cell)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        
        configureCellState(indexPath.row,cell: cell)
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
    //MARK: Warnings
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Method
    private func configureCellState(index:Int,cell:FoldingCell){
        
        var duration = 0.0
        if cellHeights[index] == kCloseCellHeight { // open cell
            cellHeights[index] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[index] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            }, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //if the index is not available return
        guard let index=self.tableView.indexPathForSelectedRow else {
            return
        }
        
        let id=String(feed!.movies[index.row].movieId)
        
        if(segue.identifier=="postersSegue"){
            let postersViewController=segue.destinationViewController as! PostersViewController
            
            postersViewController.movieId=id;
        }
        else if(segue.identifier=="trailersSegue"){
            
            let trailersViewController=segue.destinationViewController as! TrailersViewController
            
            trailersViewController.movieId=id
        }
        configureCellState(index.row,cell: cells[index.row])
        self.tableView.reloadData()
    }
}

