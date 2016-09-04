//
//  PostersViewController.swift
//  TMDB
//
//  Created by Maxim Toyberman on 03/09/2016.
//  Copyright © 2016 Maxim Toyberman. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class PostersViewController:UICollectionViewController {
    
    
    private let resuseIdentifier="posterCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    var movieId: String?{
        didSet{
            updatePosters()
        }
    }
    var posters=[String]()
    
    override func viewDidLoad() {
        self.collectionView!.backgroundColor = UIColor.whiteColor()
    }
    
    // MARK: - UICollectionViewDataSource protocol
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posters.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let baseURL = "http://image.tmdb.org/t/p/w92"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(resuseIdentifier, forIndexPath: indexPath) as! PosterCollectionViewCell
        let poster=posters[indexPath.row]
        
        let url=NSURL(string:baseURL+poster)
        cell.imageView.af_setImageWithURL(url!)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func updatePosters(){
        
        Alamofire.request(.GET,"https://api.themoviedb.org/3/movie/"+movieId!+"/images?api_key=39ce2c8a878066aa7e7ff178828aadb2").responseJSON { response in
            
            switch response.result{
                
            case .Success(let data):
                let json=JSON(data)
                let postersJson = json["posters"]
                for (_,json):(String, JSON) in postersJson {
                    if let file_path=json["file_path"].string{
                        self.posters.append(file_path)
                    }
                }
                //posters=postersArr
                self.collectionView?.reloadData()
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
            
        }
    }
}
